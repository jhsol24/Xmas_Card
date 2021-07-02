package com.wisenut.util.classificator.pojo;


import java.util.ArrayList;
import java.util.List;

public class LabeledSentenceListPojo {
    private List<LabeledSentencePojo> labeledSentenceList;

    public LabeledSentenceListPojo() {
        labeledSentenceList = new ArrayList<>();
    }

    public LabeledSentenceListPojo(List<LabeledSentencePojo> labeledSentenceList) {
        this.labeledSentenceList = labeledSentenceList;
    }

    public void addLabeledSentencePojo(LabeledSentencePojo labeledSentencePojo){
        labeledSentenceList.add(labeledSentencePojo);
    }

    public List<LabeledSentencePojo> getLabeledSentenceList() {
        return labeledSentenceList;
    }

    @Override
    public String toString() {
        return "LabeledSentenceListPojo{" +
                "labeledSentenceList=" + labeledSentenceList +
                '}';
    }
}
