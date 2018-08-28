// 시스템에서 사용하는 변수들을 정의해 놓은 자바스크립트 함수입니다.
// 시스템 개발환경이 변경되면 이 파일에서 해당 변수값을 변경해주어야 합니다.

/**
 * 다른 환경에 세팅시 변경해야 할 사항
 */

var NaverLocalAPI={//네이버 지역검색 API 정보값
		URL : "http://openapi.naver.com/search?", 	//api요청 주소
		KEY : "0fdac50782733df3183ae0c46c9575f0"	//인증키값
};

//실서버 배포시 실서버 url로 apikey다시 인증 받아서 변경해줘야함
var DaumApiKey ={
		geoTrans : "bd1c688a2c86866065bd06cddaa627ad76d8ab03", //localhost:8080 api key
		//roadView : "c4eff4072be44dfed33f623e91f79192b6cc049e" //로드뷰 apikey localhost:8080 
		roadView : "b74db40a3f3c3b1dcbe9593c33144d5395649fe8" //수원 실서버 로드뷰 apikey
		//roadView : "5f4906146ddb13f3fa906e42b91e64a479cfa8bb" //서울서버 로드뷰 apikey
}


