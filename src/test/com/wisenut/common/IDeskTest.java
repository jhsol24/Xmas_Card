package test.com.wisenut.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.wisenut.idesk.api.IDeskClient;
import com.wisenut.idesk.tools.Tools;
import com.wisenut.idesk.types.Pair;

public class IDeskTest {
    public static final String IDESK_IP = "172.23.244.11"; 
    public static final int IDESK_PORT = 18000; 
    
    public static void main(String[] args) { 
            
        // 분석 컬렉션 
        String collectionId = "sample_terms" ; 

        // 초기화 
        IDeskClient client = new IDeskClient(IDESK_IP, IDESK_PORT) ; 

        long start = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각 얻음 
        long end = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각 얻음 

        //////////////////////////////// 
        /// 질의 요청 
        //////////////////////////////// 
        start = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각얻음 
        System.out.println("Target Collection: " + collectionId); 
        System.out.println("\n[get similar document]"); 
            
        // 질의문 
        String content = "1 기일 2 회입찰제 (1 期日 2 回入札制 ; double tender system within a fixed trial date) 한 기일에 두 번 입찰을 실시하는 것으로 구 민사소송법 하에서는 매각기일에 매각이 되지 아니하면 새로운 매각기일을 지정하여 최저매각가격을 저감하고 기일의 >지정 공고, 통지 등의 절차를 진행하며 새로운 매각기일은 대략 1 개월 후로 정하는 것이 보통이었다. 그러나 그것은 이미 시행한 공고 통지 등 절차를 무용한 것으로 돌리게 되어 채권자나 채무자에게 경제적인 손실을 주는 결과가 된다. 그러나 현 민사집>행법은 일단 매각을 시도하여 매각이 되지 않더라도 새로운 매각기일을 지정하기 보다는 재차 매각을 시도하는 1 기일 2 회 매각제도를 도입하였다. 즉 기일입찰 또는 호가경매의 방법에 의한 매각기일에서 매각기일을 마감할 때까지 마감을 취소하고 같은 방법으로 매수가격을 신고하도록 최고할 수 있게 하였다(민집 115③). [이상진]" ; 
            
        // 질의 결과로 보여줄 필드 선택. 필드 + 구분자 + 필드 + ... 
        String fieldToDisplay = "TITLE:CONTENT" ; 

        // 출력할 원문의 길이 제한. 설정한 숫자만큼 원문을 출력. -1 은 전체 원문을 출력. 
        String contentLength = "10" ;  

        // DOCID List 를 이용하여 학습된 문서를 필터링하여 유사 문서를 추천할 수 있음  
        ArrayList<String> docIdListForFiltering =  new ArrayList<String>(); 

        // sample_terms prefix 
        String prefix = "D" ; 

        // 질의 결과로 보여줄 추천 유사 문서 개수 
        String topCount = "10" ;  

        // 시작 날짜, 끝 날짜를 지정하여 특정 기간 내의 문서를 필터링하여 유사 문서를 추천할 수 있음 
        String startDate = "20000101" ; // 시작 날짜 
        String endDate = "20171231" ; // 끝 날짜 

        // 결과로 가져올 유사도 제한. 설정한 숫자보다 큰 유사도의 문서(연관 키워드)를 출력함. [0.0(0%) ~ 1.0(100%)] 
        double threshold = 0.0 ; 

        // request, response XML 출력 on/off 
        boolean debug = false ; 

        System.out.println("- collection : " + collectionId); 
        System.out.println("- query : " + content); 
        System.out.println("- fieldToDisplay : " + fieldToDisplay); 
        System.out.println("- pageSize : " + topCount); 
        System.out.println("- docListForFiltering.size() : " + docIdListForFiltering.size()); 
        System.out.println("- prefix : " + prefix); 
            
        ////////////////////////////////////////////////////// 
        // 질의문에 대한 핵심 키워드 분석 결과 반환 
        // 단어 1^점수,단어 2^점수 ... 
        ////////////////////////////////////////////////////// 
        start = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각 얻음 

        List<Pair<Integer>> keywords = client.extractKeywords( collectionId, content ); 

        System.out.println("=====================extractKeywords====================="); 

        // 핵심 키워드 출력 
        System.out.println( Tools.getSerializedString(keywords, ",", "^")); 

        System.out.println("\n") ; 
        end = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각 얻음 
        System.out.println( "실행시간 : " + (end - start)/1000.0 ) ; 
            
        ////////////////////////////////////////////////////// 
        // 질의문에 대한 형태소 분석 결과 반환 
        // N: 명사, V: 동사, VA: 형용사, FL: 영어 
        ////////////////////////////////////////////////////// 
        start = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각 얻음 

        String queryKMA = client.getQueryKMA(collectionId, content, debug); 

        System.out.println("=====================query_KMA====================="); 
        System.out.println(queryKMA);

        System.out.println("\n") ; 
        end = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각얻음 
        System.out.println( "실행시간 : " + (end - start)/1000.0); 

        ////////////////////////////////////////////////////// 
        // 유사 문서 추천 API 
        // 반환 Map 정보 
        // key : "DOCID" => value : 유사 문서 document ID  
        // key : "Score" => value : 유사 문서와 질의문 간의 유사도 
        //////////////////////////////////////////////////////      
        List<Map<String,String>> similarMap = client.getSimilarDocWithContent( collectionId, content, fieldToDisplay, contentLength, topCount, docIdListForFiltering, prefix , startDate, endDate, threshold, debug );  

        // 유사 문서 출력
        System.out.println("=====================similar_doc_result====================="); 
        for(Map<String,String> map : similarMap){
            System.out.println(map.get("DOCID") + " >>>> " + map.get("Score")); 

            String[] fieldsArr = Tools.joinExclude(fieldToDisplay, "/", ":").split(":"); 
            for(String field: fieldsArr){      
                System.out.println(field + " :\t" + map.get(field)); 
            }  
        } 
        
        System.out.println("\n") ; 
        end = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각 	얻음 
        System.out.println( "실행시간 : " + (end - start)/1000.0 );

        ////////////////////////////////////////////////////// 
        // 연관 키워드 API  
        // 반환 Map 정보 
        // key : "word" => value : 연관 키워드 
        // key : "score" => value : 연관 키워드와 질의 단어 간의 유사도  
        ////////////////////////////////////////////////////// 

        String word = "매각기일";
        List<Map<String,String>> similarWord = client.getSimilarWordWithContent( collectionId, word, topCount, threshold, debug ); 

        // 연관 키워드 출력
        System.out.println("=====================similar_word_result===================="); 
        System.out.println( "Most Similar word with [ " + word + " ]" );

        int count = 1 ; 
        for(Map<String,String> map : similarWord){ 
            System.out.println( count++ + "\t" + map.get("Word") + "\t" + map.get("Score") ); 
        }
        System.out.println("\n");

        end = System.currentTimeMillis(); // 소요 시간 표시 위해 시작 시각 얻음 
        System.out.println( "실행시간 : " + (end - start)/1000.0 ) ; 
        System.out.println("\n") ;      

        System.exit(0); 
    } 
}