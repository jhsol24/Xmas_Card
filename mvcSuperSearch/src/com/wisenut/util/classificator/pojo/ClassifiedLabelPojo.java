package com.wisenut.util.classificator.pojo;

public class ClassifiedLabelPojo {
    private String label;
    private double confidence;

    public ClassifiedLabelPojo(String label, double confidence) {
        this.label = label;
        this.confidence = confidence;
    }

    public String getLabel() {
        return label;
    }

    public double getConfidence() {
        return confidence;
    }

    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("ClassifiedLabelPojo{");
        sb.append("label='").append(label).append('\'');
        sb.append(", confidence=").append(confidence);
        sb.append('}');
        return sb.toString();
    }
}
