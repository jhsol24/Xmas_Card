package com.wisenut.util.classificator;

import java.io.UnsupportedEncodingException;

import org.apache.http.HttpException;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.javalite.http.Get;
import org.javalite.http.Http;
import org.javalite.http.Post;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.wisenut.util.classificator.pojo.ClassificationRequestPojo;
import com.wisenut.util.classificator.pojo.ClassificationResponsePojo;
import com.wisenut.util.classificator.pojo.LabeledSentenceListPojo;
import com.wisenut.util.classificator.pojo.LabeledSentencePojo;
import com.wisenut.util.classificator.pojo.ServiceStatusPojo;

public class ClientForClassifierService {

    private String hostName;
    private int port;
    private Gson gson = new Gson();
    private static Logger logger =  LogManager.getLogger(ClientForClassifierService.class);

    public ClientForClassifierService(String hostName, int port) {
        this.hostName = hostName;
        this.port = port;
    }

    /**
     * Classification 요청
     *
     * @param sentence
     * @param topK
     * @param threshold
     * @return
     */
    public ClassificationResponsePojo classifySentence(String sentence, int topK, double threshold) throws HttpException, JsonSyntaxException {
        String url = "http://" + hostName + ":" + port + "/classify";
        ClassificationRequestPojo requestPojo = new ClassificationRequestPojo(sentence, Integer.toString(topK), Double.toString(threshold));

        Post post = Http.post(url, gson.toJson(requestPojo))
                .header("Accept", "application/json")
                .header("Content-Type", "application/json");
//        logger.info("post.text() : " + post.text());
        ClassificationResponsePojo response = null;
        try {
            response = gson.fromJson(post.text(), ClassificationResponsePojo.class);
        } catch (JsonSyntaxException e) {
        	logger.error(e.getMessage());
            throw new JsonSyntaxException(post.text());
        }
        return response;
    }

    public ServiceStatusPojo getServerStatus() throws HttpException, JsonSyntaxException {
        String url = "http://" + hostName + ":" + port + "/status";
        Get get = Http.get(url);

        ServiceStatusPojo response = null;
        try {
            response = gson.fromJson(get.text(), ServiceStatusPojo.class);
        } catch (JsonSyntaxException e) {
            throw new JsonSyntaxException(get.text());
        }
        return response;
    }


    public void addTrainingData(String label, String sentence) throws HttpException {
        String url = "http://" + hostName + ":" + port + "/add_training_data";
        LabeledSentencePojo requestPojo = new LabeledSentencePojo(label, sentence);

        Post post = Http.post(url, gson.toJson(requestPojo))
                .header("Accept", "application/json")
                .header("Content-Type", "application/json");

        logger.info(gson.toJson(requestPojo));
        logger.info(post.text());

    }

    public void addTrainingDataSet(LabeledSentenceListPojo labeledSentenceList) throws HttpException {
        String url = "http://" + hostName + ":" + port + "/add_training_dataset";

        Post post = Http.post(url, gson.toJson(labeledSentenceList))
                .header("Accept", "application/json")
                .header("Content-Type", "application/json");
        logger.info(gson.toJson(labeledSentenceList));
        logger.info(post.text());

    }

    public void training() throws HttpException, JsonSyntaxException {
        String url = "http://" + hostName + ":" + port + "/training";
        Post post = Http.post(url);
        logger.info(post.text());
    }

    public void clearTrainingDataset(LabeledSentenceListPojo labeledSentenceList) throws HttpException {
        String url = "http://" + hostName + ":" + port + "/clear_training_dataset";

        Post post = Http.post(url, gson.toJson(labeledSentenceList))
                .header("Accept", "application/json")
                .header("Content-Type", "application/json");

        logger.info(post.text());

    }


    public void loadTrainedModel(String modelName) throws HttpException, JsonSyntaxException, UnsupportedEncodingException {
        String url = "http://" + hostName + ":" + port + "/load_trained_model?modelname=" + modelName;
        Post post = Http.post(url);

        logger.info(post.text());

    }
    public void trainingFromFile(String filename) throws HttpException, JsonSyntaxException, UnsupportedEncodingException {
        String url = "http://" + hostName + ":" + port + "/training_from_file?filename=" + filename;
        Post post = Http.post(url);

        logger.info(post.text());

    }
    public void saveTrainedModel(String modelName) throws HttpException, JsonSyntaxException, UnsupportedEncodingException {
        String url = "http://" + hostName + ":" + port + "/save_trained_model?modelname=" + modelName;
        Post post = Http.post(url);
        logger.info(post.text());

    }

    public void waitUntilReady() {

        while (true) {


            ServiceStatusPojo status = null;
			try {
				status = getServerStatus();
			} catch (JsonSyntaxException | HttpException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            if (status == ServiceStatusPojo.READY) {
                break;
            }


        }

    }

    public static void main(String[] args) {

        ClientForClassifierService client = new ClientForClassifierService("localhost", 8001);
//        try {

//       client.trainingFromFile("mois_training.csv");
//        client.addTrainingData("위치", "중부발전이 어디 있나요?");

//            client.loadTrainedModel("mois");
//            client.waitUntilReady();
//            client.saveTrainedModel("mois2");
//            client.waitUntilReady();
//            client.loadTrainedModel("taxex");
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }

//        client.addTrainingData("의료", "어제부터 배가 아픈데 어디가 문제일까요?");
//        client.addTrainingData("식사", "오늘 저녁 메뉴가 뭐예요?");

//
        LabeledSentenceListPojo list = new LabeledSentenceListPojo();
//
        list.addLabeledSentencePojo(new LabeledSentencePojo("의료", "어제부터 배가 아픈데 어디가 문제일까요?"));
        list.addLabeledSentencePojo((new LabeledSentencePojo("식사", "오늘 저녁 메뉴가 뭐예요?")));
        try {
			client.addTrainingDataSet(list);
			logger.info(client.getServerStatus().toString());
			
			
			ClassificationResponsePojo responsePojo = client.classifySentence("밥은 먹고 다니냐?", 10, 0.2);
			logger.info(responsePojo.toString());
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }


//
//    public static void main(String[] args) {
////        String url = "http://localhost://8000/classify";
////        String content = "{ " +
////                "   \"userName\" : \"" + textField_telegramUserName.getText() + "\",\n" +
////                "   \"event\" : \"9\"\n" +
////                "}";
////
////
////        Post post = Http.post(url, content)
////                .header("Accept", "application/json")
////                .header("Content-Type", "application/json");
////
////        textArea_result.setText(post.text());
//    }
}
