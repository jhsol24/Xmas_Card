package com.wisenut.util.classificator.pojo;

public class LabeledSentencePojo {
    private String label;
    private String sentence;

    public LabeledSentencePojo(String label, String sentence) {
        this.label = label;
        this.sentence = sentence;
    }

    public String getLabel() {
        return label;
    }

    public String getSentence() {
        return sentence;
    }

    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("LabeledSentencePojo{");
        sb.append("label='").append(label).append('\'');
        sb.append(", sentence='").append(sentence).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
