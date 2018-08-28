//S 날씨정보
var weatherLayerName = 'WEATHER'; // 날씨정보 레이어
var weatherImg = {  '맑음' : 'w_1.png',
					'구름 조금' : 'w_2.png',
					'구름 많음' : 'w_3.png',
					'흐림' : 'w_4.png',
					'비' : 'w_5.png',
					'눈/비' : 'w_6.png',
					'눈' : 'w_7.png',
					'흐리고 비' : 'w_8.png',
					'흐리고 눈 또는 비' : 'w_6.png',
					'흐리고 비 또는 눈' : 'w_6.png',
					'구름많고 눈' : 'w_7.png',
					'구름많고 비' : 'w_5.png'};

/**
 * 이미지 경로 구함
 * 
 * @param path
 * @param strWeather
 * @returns
 */
function getWeatherImgPath(path, strWeather){
	var img_path = weatherImg[strWeather];
	
	if(img_path) return path+img_path;
	else return '';
}

/**
 * 이미지 태그 생성
 * 
 * @param path
 * @param strWeather
 * @returns
 */
function getWeatherImgTag(path, strWeather){
	var img_path = getWeatherImgPath(path, strWeather);
	
	if(img_path) document.write('<img src="'+img_path+'">');
}