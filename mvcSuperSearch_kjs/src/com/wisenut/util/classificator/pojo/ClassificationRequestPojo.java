package com.wisenut.util.classificator.pojo;

import com.google.gson.Gson;

public class ClassificationRequestPojo {
    /**
     * 질의 대상 문장
     */
    private String sentence;
    /**
     * 답변 최대갯수 (단 topK가 label의 최대갯수를 넘으면 label의 최대갯수를 반환함
     * 음수인 경우는 최대갯수를 반환함
     * <p>
     * topK와 scoreThreshold는 두개의 조건의 and 로 계산함.
     * <p>
     * 즉 topK를 만족하는 답변중에서 scoreThreshold를 동시에 만족하는 label만 반환됨
     */
    private int topK;

    /**
     * score의 하한선을 설정함. score가 이 답변보다 낮은 경우에는 답변으로 반환하지 않음
     * 음수인 경우는 score의 하한선 없음
     * <p>
     * topK와 scoreThreshold는 두개의 조건의 and 로 계산함.
     * <p>
     * 즉 topK를 만족하는 답변중에서 scoreThreshold를 동시에 만족하는 label만 반환됨
     */
    private double scoreThreshold;


    public String getSentence() {
        return sentence;
    }

    public int getTopK() {
        return topK;
    }

    public double getScoreThreshold() {
        return scoreThreshold;
    }

    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("ClassificationRequestPojo{");
        sb.append("sentence='").append(sentence).append('\'');
        sb.append(", topK=").append(topK);
        sb.append(", scoreThreshold=").append(scoreThreshold);
        sb.append('}');
        return sb.toString();
    }

    public ClassificationRequestPojo(String sentence, String topKStr, String scoreThresholdStr) {
        this.sentence = sentence;
        if (topKStr==null || topKStr.isEmpty()) {
            topK = -1;
        } else {
            try {
                topK = Integer.parseInt(topKStr);
            } catch (NumberFormatException e) {
                topK=-1;
            }
        }

        if (scoreThresholdStr == null || scoreThresholdStr.isEmpty()) {
            scoreThreshold = -1;
        } else {
            try {
                scoreThreshold = Double.parseDouble(scoreThresholdStr);
            } catch (NumberFormatException e) {
                scoreThreshold = -1;
            }
        }

    }

    public static void main(String[] args) {
        ClassificationRequestPojo c= new ClassificationRequestPojo("setnece1","10k","101.22");

        Gson gson = new Gson();

        System.out.println(gson.toJson(c));
    }
}
