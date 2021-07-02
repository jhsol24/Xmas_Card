/**
	 The MIT License
	
	Copyright (c) <2012> <Jeonghoe Kim (kdarkdev@gmail.com), http://kdarkdev.tistory.com, http://code.google.com/p/jquery-maskip/>
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
**/

/*version 1.1.1   	- replace method live to on (2013-07-10)
 * version 1.1.0   	- add to maxlength, separator option (2012-07-10)
 * version 1.0.1   	- number keypad input (2012-06-05)
 * version 1.0   	- 1st update (2012-05-24)
 */

/**
 * Mask Ip Plugin
 * 
 * ex) $(selector).maskip(); //default type is ip type
 * ex) $(selector).maskip({"type":"ip"});  // ip type   - 111.111.111.111
 * ex) $(selector).maskip({"type":"cidr"});// cidr type - 111.111.111.111/24
 * ex) $(selector).maskip({"type":"port"});// port type - 0 ~ 65535
 * ex) $(selector).maskip({"type":"number"});// number type - 0 1 2 3 4 5 ...~
 * 
 * (option)
 * 1. type      : ip, cidr, port, number (default 'ip')
 * 2. maxlength : 0 ~ (defualt 0)
 * 3. separator : '' (default '')
 */
(function( $ ) {
	var privateVal = {operaIntervalTime:100};
	
	var methods = {
			ipProc : function(obj, e, opt) {
				if(e.which=='229' || e.which=='197' && $.browser.opera) {
					setInterval(function(){
					 	obj.trigger('keyup');
					}, privateVal.operaIntervalTime);
				}
				
				if (opt.separator == '') {
					if ( ! (e.which && (e.which > 47 && e.which < 58) || (e.which >= 96 && e.which <= 105) || e.which==110 || e.which == 8 || e.which == 9 || e.which == 0|| e.which == 46|| e.which == 190  || (e.ctrlKey && e.which ==86)) ) {
						e.preventDefault();
					}
				}

				// 정규식으로 숫자 or . 구분자 제외한 문자는 모두 제거
				var regex = new RegExp("[^0-9."+opt.separator+"]","g");
				var value = regex.test(obj.val());
				
				if(value) {
					obj.val(obj.val().replace(regex,""));
				}
				
				var objValueArray = null;
				if (opt.separator != "") {
					objValueArray = obj.val().split(opt.separator);
				} else {
					objValueArray = [obj.val()];
				}
				
				var temp = "";
				for (var i = 0; i < objValueArray.length; i++) {
					if(i!=0){
						temp += opt.separator;
					}
					var startIdx = (objValueArray[i].length>=3?objValueArray[i].length-3:0);
					var endIdx   = objValueArray[i].length;
					//최근 입력한 뒤에서 3자리의 숫자
					var result = objValueArray[i].substring(startIdx, endIdx);
					// .으로 split한 배열
					var objArr = objValueArray[i].split("\.");
					// 입력한 문자열에 연속으로 ..이 들어가있을경우true 아니면 false
					var lastDotBool = objValueArray[i].substring(objValueArray[i].length-2, objValueArray[i].length)=='..'?true:false;
	
					// 입력한 문자열에 연속으로 '..'이 포함되어있거나, 
					// '.'으로 split한 배열의 갯수가 4개 초과 되거나
					// '.'으로 split한 마지막 배열객체의 문자열 길이가 3초과하면
					// input box에 입력된 문자열의 마지막 한자리를 제거
					if(lastDotBool || objArr.length>4 || (objArr.length==4 && objArr[objArr.length-1].length>3) ){
						//obj.val(obj.val().substring(0, obj.val().length-1));
						temp += (objValueArray[i].substring(0, objValueArray[i].length-1));
					} 
					// 최근 입력된 뒤에서 3자리의 숫자(.포함 안된것중)의 문자열 길이가 3개이면서,  .으로 split했을때 길이가 3이하일경우
					// 현재 입력된 inputbox 뒤에 .을 찍어 준다.
					// 단 backspace 키 입력으로 inputbox 내용 삭제시는 제외
					else if( result.length==3 && result.indexOf('\.')==-1 && objValueArray[i].split('\.').length<=3 && e.which!='8'){
						//obj.val(obj.val()+'.');
						temp += (objValueArray[i]+'.');
					} else {
						temp += (objValueArray[i]);
					}
					
				}//end for
				obj.val(temp);
					
			}, 	
			cidrProc : function(obj, e, opt) {
				if(e.which=='229' || e.which=='197' && $.browser.opera) {
					setInterval(function(){
					 	obj.trigger('keyup');
					}, privateVal.operaIntervalTime);
				}
				if (opt.separator == '') {
					if ( ! (e.which && ( (e.which > 47 && e.which < 58) || (e.which >= 96 && e.which <= 105) || e.which==110 || e.which==111 || e.which == 8 || e.which == 9 || e.which == 0 || e.which == 46|| e.which == 190|| e.which == 47|| e.which == 191  || (e.ctrlKey && e.which ==86) )) ) {
						e.preventDefault();
					}
				}
				
				// 정규식으로 숫자 or . / 구분자 제외한 문자는 모두 제거
				var regex = new RegExp("[^0-9.\/"+opt.separator+"]","g");
				var value = regex.test(obj.val());
				
				if(value) {
					obj.val(obj.val().replace(regex,""));
				}
				
				var objValueArray = null;
				if (opt.separator != "") {
					objValueArray = obj.val().split(opt.separator);
				} else {
					objValueArray = [obj.val()];
				}
				
				var temp = "";
				for (var i = 0; i < objValueArray.length; i++) {
					if (i != 0) {
						temp += opt.separator;
					}
					var startIdx = (objValueArray[i].length >= 3 ? objValueArray[i].length - 3 : 0);
					var endIdx = objValueArray[i].length;
					//최근 입력한 뒤에서 3자리의 숫자
					var result = objValueArray[i].substring(startIdx, endIdx);
					// .으로 split한 배열
					var objArr = objValueArray[i].split("\.");
					// 입력한 문자열에 연속으로 ..이 들어가있을경우true 
					var lastDotBool = objValueArray[i].substring(objValueArray[i].length - 2, objValueArray[i].length) == '..' ? true : false;
					// 입력한 문자열속에 연속으로 //이 들어가있을 경우 true
					var lastSlashBool = objValueArray[i].substring(objValueArray[i].length - 2, objValueArray[i].length) == '//' ? true : false;
					var slashSplitArray = objValueArray[i].split('/');
					
					if (lastDotBool || objArr.length > 4 || lastSlashBool) {
						temp += (objValueArray[i].substring(0, objValueArray[i].length - 1));
					} else if (objArr.length == 4 && objArr[objArr.length - 1].length > 3 && slashSplitArray.length == 1) {
						temp += (objValueArray[i].substring(0, objValueArray[i].length - 1));
					} else if (slashSplitArray.length == 2) {
						var regExResult = slashSplitArray[1].match(/\d{0,2}/g);
						temp += (objValueArray[i].split('/')[0] + '/' + regExResult[0]);
						
					// 최근 입력된 뒤에서 3자리의 숫자(.포함 안된것중)의 문자열 길이가 3개이면서,  .으로 split했을때 길이가 3이하일경우
					// 현재 입력된 inputbox 뒤에 .을 찍어 준다.
					// 단 backspace 키 입력으로 inputbox 내용 삭제시는 제외
					} else if (result.length == 3 && result.indexOf('\.') == -1 && objValueArray[i].split('\.').length <= 3 && e.which != '8') {
						temp += (objValueArray[i] + '.');
					} else {
						temp += (objValueArray[i]);
					}
				}// end for
				obj.val(temp);
			},
			portProc: function(obj, e, opt){
				if(e.which=='229' || e.which=='197' && $.browser.opera) {
					setInterval(function(){
					 	obj.trigger('keyup');
					}, privateVal.operaIntervalTime);
				}
				
				if (opt.separator == '') {
					if (obj.val().charAt(0) == '0' && e.which != 8 && e.which != 9 && e.which != 0) {
						e.preventDefault();
					}
					if (!(e.which && (e.which > 47 && e.which < 58) || (e.which >= 96 && e.which <= 105) || e.which == 8 || e.which == 9 || e.which == 0 || (e.ctrlKey && e.which == 86))) {
						e.preventDefault();
					}
				}
				if(opt.separator==""){
					if(obj.val()>65535) {
						obj.val(65535);
					}
				} else {
					var objArray = obj.val().split(opt.separator);
					var temp = "";
					for(var i=0; i<objArray.length; i++) {
						if(i!=0){
							temp += opt.separator;
						}
						if(Number(objArray[i]) > 65535){
							temp += 65535;
						} else {
							temp += objArray[i];
						}
					}
					obj.val(temp);
				}
				
				var regex = new RegExp("[^0-9."+opt.separator+"]","g");
				var value = regex.test(obj.val());
				if(value) {
					obj.val(obj.val().replace(regex,""));
				}
				
			},
			numberProc: function(obj, e, opt){
			   if(e.which=='229' || e.which=='197' && $.browser.opera) {
					setInterval(function(){
					 	obj.trigger('keyup');
					}, privateVal.operaIntervalTime);
			   }
			   
			   if (opt.separator == '') {
			   	  if (!(e.which && (e.which > 47 && e.which < 58) || (e.which >= 96 && e.which <= 105) || e.which == 8 || e.which == 9 || e.which == 0 || (e.ctrlKey && e.which == 86))) {
			   		e.preventDefault();
			   	  }
			   }
			   
		       var regex = new RegExp("[^0-9"+opt.separator+"]","g");
			   var value = regex.test(obj.val());
			   if(value) {
			  		obj.val(obj.val().replace(regex,""));
			   }
			   
			   
			}
	}; //end methods
	
	$.fn.maskip = function(opt){
		
		//option
		var options = jQuery.extend({
             type	   : "ip" // ip, cidr
            ,maxlength : 0 // 0 ~ 
			,separator : "" // default ''
        }, opt);
		
		$(this).css('imeMode','disabled');
				
		if(options.type=='ip'){
			if (options.maxlength == 0) {
				$(this).attr('maxlength',15);
			} else {
				$(this).attr('maxlength',options.maxlength);
			}
			
			this.on('keyup',function(e){
				methods.ipProc($(this),e, options);
			}).on('keydown',function(e){
				methods.ipProc($(this),e, options);	
			}).on('keypress',function(e){
				methods.ipProc($(this),e, options);	
			});
		} else if(options.type=='cidr') {
			if (options.maxlength == 0) {
				$(this).attr('maxlength',18);
			} else {
				$(this).attr('maxlength',options.maxlength);
			}

			this.on('keyup',function(e){
				methods.cidrProc($(this),e, options);
			}).on('keydown',function(e){
				methods.cidrProc($(this),e, options);	
			}).on('keypress',function(e){
				methods.cidrProc($(this),e, options);	
			});
		} else if(options.type=='port') {
			if(options.maxlength==0) {
				$(this).attr('maxlength',5);
			} else {
				$(this).attr('maxlength',options.maxlength);
			}
			
			this.on('keyup',function(e){
				methods.portProc($(this), e, options);
			}).on('keydown',function(e){
				methods.portProc($(this),e, options);
			}).on('keypress',function(e){
				methods.portProc($(this),e, options);
			});
		} else if(options.type=='number') {
			if(options.maxlength==0) {
			} else {
				$(this).attr('maxlength',options.maxlength);
			}
			
			this.on('keyup',function(e){
				methods.numberProc($(this),e, options);
			}).on('keydown',function(e){
				methods.numberProc($(this),e, options);
			}).on('keypress',function(e){
				methods.numberProc($(this),e, options);
			});
		}
		
		return this;
	};
	
})( jQuery );