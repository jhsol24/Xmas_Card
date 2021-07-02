package com.wisenut.util.classificator.pojo;

public enum ServiceStatusPojo {
    EMPTY, // 학습되지 않은 초기상태
    EMPTY_MODEL_AND_TRAINING,// 학습중, 기 학습된 모델은 없음
    EMPTY_MODEL_AND_LOADING,// 학습된 모델 로딩중, 기 학습된 모델은 없음
    READY_AND_TRAINING,// 학습중, 기 학습된 모델이 존재해서 서비스 가능, 학습 완료후 모델 교체
    READY_AND_LOADING,// 지식 로딩중, 기 학습된 모델이 존재해서 서비스 가능, 로딩 완료후 모델 교체
    READY,// 서비스 가능하며, 학습은 이루어지지 않고 있음
    ERROR // 오류 (재시작 필요)
}
