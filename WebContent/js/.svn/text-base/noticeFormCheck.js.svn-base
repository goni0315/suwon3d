//글작성 유효성 검사
function writeFormCheck(tmpform, bod_start, bod_end, type){ //글작성 폼, 팝업시작날짜, 팝업종료날짜
	
	//oEditors.getById[tmpform].exec("UPDATE_CONTENTS_FIELD", []);
	
	var form = document.getElementById(tmpform);
	
	var submitWriteUrl = "noticeInsert.do";
	var submitModifyUrl = "noticeModify.do";
    var typeValue = type;
	var dayCheck = true;
	var strSubCheck = true;
	//var strCttCheck = true;
	
	//글자수 제한 제목:60byte
	strSubCheck = checkContentLength(form.bod_sub, "60");
	//strCttCheck = checkContentLength(form.bod_ctt, "2000");

	if(form.bod_yn.checked){//팝업설정 날짜 검사
		dayCheck = dateCheck(bod_start, bod_end, typeValue);
	}
	
	var filecheck1=fileFormCheck(form.file1.value);
	var filecheck2=fileFormCheck(form.file2.value);
	
	if(dayCheck && filecheck1 && filecheck2 && strSubCheck){// && strCttCheck){
		if(!form.bod_sub.value.replace(/^\s+|\s+$/g,"") ){ //제목 검사
			alert("제목을 입력하세요");
			form.bod_sub.focus(); 
			return false;
		}else if(!form.bod_ctt.value.replace(/^\s+|\s+$/g,"") ){//내용 검사
			alert("내용을 입력하세요.");
			form.bod_ctt.focus();
			return false;
		}else{
			if(typeValue == 'write'){
			 	form.action = submitWriteUrl;
			}else if(typeValue == 'modify'){
				form.action = submitModifyUrl;
			}	
		}
	}else{
		return ;
	}
}
function checkContentLength(content, max_length){
	var i;
    var string = content.value;
    var one_char;
    var str_byte = 0;
    var str_length = 0;
    for(i = 0 ; i < string.length ; i++){
    // 한글자추출
    one_char = string.charAt(i);
	
	    // 한글이면 2를 더한다.
	    if (escape(one_char).length > 4){
	    	str_byte = str_byte+2;
	    }
	    // 그외의 경우는 1을 더한다.
	    else{
	     str_byte++;
	    }
	
	    // 전체 크기가 li_max를 넘지않으면
	    if(str_byte <= max_length){
	    	str_length = i + 1;
	    }
    }
    // 전체길이를 초과하면
  if(str_byte > max_length)  {
	  alert("글자를 초과 입력할수 없습니다.\n 글자수 제한 : "+ max_length + "byte(한글 : " + max_length/2 +"자, 영문 : " + max_length + "자)");
	 // content.value = string.substr(0, str_length);
	  return false;
  }else{
	  return true;
  }
  
}
//팝업여부 체크확인
function popupCheck(bod_yn, popset, bod_start, bod_end){ //팝업여부, 날짜설정폼,  팝업시작날짜, 팝업종료날짜
	var tmp = document.getElementById(bod_yn);
	var popupSet = document.getElementById(popset);	
	if(tmp.checked){//체크시 날짜 입력칸 보이기
		popupSet.style.display="inline";
	}else{//미체크시 날짜입력칸 숨김 & 입력데이터 초기화
		popupSet.style.display="none";
		document.getElementById(bod_start).value="";
		document.getElementById(bod_end).value="";
	}	
}
//팝업 날짜 유효성검사
function dateCheck(bod_start, bod_end, type){ //시작날짜, 종료잘짜
	var nowDate = new Date();		//현재날짜
	var startDate = document.getElementById(bod_start).value;		//시작날짜
	var endDate = document.getElementById(bod_end).value;			//종료날짜
	
	if(startDate == "" || endDate == ""){
		alert("팝업 날짜를 입력하세요.");
		return false;
	}	
	//현재날짜
	var year = nowDate.getFullYear();
	var month = nowDate.getMonth()+1;
	if((month+"").length < 2){
		month = "0"+month;
	}
	var date = nowDate.getDate();
	if((date+"").length < 2){
	 	date = "0"+date;
	}
	var today = year+""+month+""+date;
	
	//시작날짜
	var dateSplit = startDate.split("-");
	year = dateSplit[0];
	month = dateSplit[1];
	date = dateSplit[2];
	startDate = year+""+month+""+date;
		
	//종료날짜
	dateSplit = endDate.split("-");
	year = dateSplit[0];
	month = dateSplit[1];
	date = dateSplit[2];
	endDate = year+""+month+""+date;
	if(type == 'modify'){ //수정일때 시작날짜와 종료날짜만 검사
		if(startDate > endDate){
			alert("잘못된 팝업 날짜입니다. 다시 설정해주세요.");
			return false;
		}
	}else{
		if(today > startDate || today > endDate || startDate > endDate){
			alert("잘못된 팝업 날짜입니다. 다시 설정해주세요.");
			return false;
		}
	}		

	return true;
}
//업로드 파일 유효성 체크
function fileFormCheck(filename){
	var filePath = filename;
	var extIndex = filePath.lastIndexOf(".");
	var ext = filePath.substring(extIndex + 1);
	//업로드 가능파일 확장자
	extArray = new Array("jpg","jpeg","png","gif","txt","zip","hwp","mp4","avi","pdf","ppt","pptx","docx","doc","xls","xlsx");
	if(filePath){
	//	alert("파일 : " + filePath+"\n"+"ext : " + ext);
		var extln = false;
		for(var i = 0; i < extArray.length; i++){
			if(extArray[i] == ext){
				extln = true;
			}
		}
		if(extln == false){
			alert("업로드 할수 있는 파일 형식이 아닙니다."+"\n"+"업로드 가능 파일 형식은 " + extArray);
			return false;
		}		
	}
	return true;
}

//검색어
function searchFormCheck(searchForm){//}, searchType, searchItem){ //검색폼, 검색타입, 검색어
	var form = document.getElementById(searchForm);
	var submitUrl = null;
	var size = form.elements["searchType"].length;
	var searchType = null;
	var searchItme = form.searchItem.value;
	
	for(var i = 0; i < size ; i++){
		if(form.elements["searchType"][i].checked){
			searchType = form.elements["searchType"][i].value;
		}
	}
	if(searchType == null){
		alert("검색종류를 선택하세요");
		return;
	}
	
	if(!form.searchItem.value ){
		alert("검색어를 입력하세요");
		form.searchItem.focus();
	}else if(searchType){
		submitUrl = "noticeSearch.do?item="	+ searchItme +"&type="+ searchType;
		form.action = submitUrl;
		//form.submit();
	}
}