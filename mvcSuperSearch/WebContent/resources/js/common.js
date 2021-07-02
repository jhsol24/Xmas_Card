	//logout
function fn_logout() {
	alertify.confirm("로그아웃 하시겠습니까?"
			, function() {
				location.href = getContextPath()+"/login/logout.wn";
			});
};//fn_logout

function getContextPath() {
    return sessionStorage.getItem("contextpath");
};

$(document).ready(function () {
    $.ajaxSetup({
    	beforeSend: function(xhr) {
            xhr.setRequestHeader("Ajax", "Y");
    	},
    	error: function(xhr, status, err) {
            if(xhr.status=="503"){
                alert("세션이 만료되었습니다.");
                location.href = getContextPath()+"/login/login.wn";
            }else{
            	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
            
        }
    });
});

