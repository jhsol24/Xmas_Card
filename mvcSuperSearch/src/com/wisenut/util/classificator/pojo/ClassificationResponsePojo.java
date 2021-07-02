package com.wisenut.util.classificator.pojo;

import java.util.ArrayList;
import java.util.List;

public class ClassificationResponsePojo {
	List<ClassifiedLabelPojo> classifiedlabels;

    public ClassificationResponsePojo(List<ClassifiedLabelPojo> classifiedlabels) {
        this.classifiedlabels = classifiedlabels;
    }
    public ClassificationResponsePojo(){
        this.classifiedlabels = new ArrayList<>();
    }

    public void addClassifiedLabel(ClassifiedLabelPojo classifiedLabel){
        classifiedlabels.add(classifiedLabel);
    }

    public List<ClassifiedLabelPojo> getClassifiedlabels() {
        return classifiedlabels;
    }

    @Override
    public String toString() {
        return "ClassificationResponsePojo{" +
                "classifiedlabels=" + classifiedlabels +
                '}';
    }
}
