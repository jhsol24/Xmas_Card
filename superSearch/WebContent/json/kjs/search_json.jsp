<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="./common/api/WNSearch.jsp" %><% request.setCharacterEncoding("UTF-8");%><%
    /*
     * subject: 검색 메인 페이지
     * @original author: SearchTool
     */
    //실시간 검색어 화면 출력 여부 체크
    boolean isRealTimeKeyword = false;
    //인기 검색어 화면 출력 여부 체크
    boolean isPopKeyword = true;
    //디버깅 보기 설정
    boolean isDebug = false;
    response.setHeader("Access-Control-Allow-Origin", "*"); //html 의 보안문제 해결
    int TOTALVIEWCOUNT = 3;    //통합검색시 출력건수

    //날짜얻어오기
    
    Calendar nowDate = Calendar.getInstance();
    int nowYear   = nowDate.get(Calendar.YEAR);
    int nowMonth  = nowDate.get(Calendar.MONTH) + 1;
    int nowDay    = nowDate.get(Calendar.DAY_OF_MONTH);
    // 결과 시작 넘버
    int startCount      = parseInt(getCheckReqXSS(request, "startCount", "0"), 0);
    int listCount      = parseInt(getCheckReqXSS(request, "listCount", "10"), 10);
    //url로 파라미터 값 던질때, 변수명들 
    String query        = getCheckReqXSS(request, "query", "");          //검색어
    String collection   = getCheckReqXSS(request, "collection", "ALL");  //컬렉션이름
    String rt   = getCheckReqXSS(request, "rt", "");              //결과내 재검색 체크필드
    String rt2   = getCheckReqXSS(request, "rt2", "");            //결과내 재검색 체크필드
    String requery   = getCheckReqXSS(request, "requery", "");    //결과내 검색어
    String mode   = getCheckReqXSS(request, "mode", "basic");     //통합검색(basic),상세검색(detail)
    String sort   = getCheckReqXSS(request, "sort", "RANK");      //정렬필드
    String range   = getCheckReqXSS(request, "range", "0");       //기간관련필드
    String startDate   = getCheckReqXSS(request, "sdate", "");    //시작날짜
    String endDate   = getCheckReq(request, "edate", "");      //끝날짜
    String writer   = getCheckReqXSS(request, "writer", "");      //작성자
    String sfield   = "";

    // 상세검색 검색 필드 설정이 되었을때
    String [] field = request.getParameterValues("sfield");
    if ( field != null ) {
        for ( int x=0; x<field.length;x++) {
            sfield = sfield + field[x] + ",";
        }

    } else sfield = "ALL";

    if ( range.equals("0") ) {
        startDate = "";
        endDate = "";
    }

    String[] collections = null;
    if(collection.equals("ALL")) { //통합검색인 경우
        collections = COLLECTIONS;
    } else {                        //개별검색인 경우
        collections = new String[] { collection };
    }

    String search = query ;
    String strOperation  = "" ; //operation 조건 필드
    String exquery = "" ;       //exquery 조건 필드
    int totalCount = 0;

    if ( rt.equals("1") && !requery.equals("") ) {
		   search = query + " " + requery;
 	} else if ( rt2.equals("1") && !requery.equals("") ) {
 		search = requery ;
  	}

    String[] searchFields = null;
    if ( !writer.equals("") ) {
        exquery = "<WRITER:" + writer + ">";
    }

    WNSearch wnsearch = new WNSearch(isDebug, false, collections, searchFields, USE_RESULT_JSON);

    int viewResultCount = listCount;
    if ( collection.equals("ALL") ||  collection.equals("") )
        viewResultCount = TOTALVIEWCOUNT;

    for (int i = 0; i < collections.length; i++) {

        //출력건수
        wnsearch.setCollectionInfoValue(collections[i], PAGE_INFO, startCount+","+viewResultCount);

        //검색어가 없으면 DATE_RANGE 로 전체 데이터 출력
        if ( !query.equals("") ) {
              wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, sort + "/DESC");
        } else {
              wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, "1970/01/01,2030/12/31,-");
              wnsearch.setCollectionInfoValue(collections[i], SORT_FIELD, "RANK/DESC,DATE/DESC");
        }
        //sfield 값이 있으면 설정, 없으면 기본검색필드
        if ( !sfield.equals("") && sfield.indexOf("ALL") == -1 ) wnsearch.setCollectionInfoValue(collections[i], SEARCH_FIELD, sfield );
        //operation 설정
        if ( !strOperation.equals("") ) wnsearch.setCollectionInfoValue(collections[i], FILTER_OPERATION, strOperation);
        //exquery 설정
        if ( !exquery.equals("") ) wnsearch.setCollectionInfoValue(collections[i], EXQUERY_FIELD, exquery );
        //기간 설정 , 날짜가 모두 있을때
        if ( !startDate.equals("")  && !endDate.equals("") )
             wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, startDate.replaceAll("-","/") + "," + endDate.replaceAll("-","/") + ",-");
        //기간 설정 , 시작날짜만 있을때에는 뒤에 날짜를 오늘날짜로 셋팅한다.
        else if ( !startDate.equals("")  && endDate.equals("") )
             wnsearch.setCollectionInfoValue(collections[i], DATE_RANGE, startDate.replaceAll("-","/") + "," + nowYear + "/" + nowMonth + "/" + nowDay + ",-");
    }

    wnsearch.search(search, false); // 검색엔진 콜 
    out.println(wnsearch.getResultJson());
    if ( wnsearch != null )
        wnsearch.closeServer();
%>