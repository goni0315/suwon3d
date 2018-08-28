package suwon.web.vo;

import java.util.List;

public class SuwonDongVO {
	private String code;
	private String value;
	private String gridX;
	private String gridY;
	private DongWeatherVO dongVo;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getValue() {
		return value;
	}
	public DongWeatherVO getDongVo() {
		return dongVo;
	}
	public void setDongVo(DongWeatherVO dongVo) {
		this.dongVo = dongVo;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getGridX() {
		return gridX;
	}
	public void setGridX(String gridX) {
		this.gridX = gridX;
	}
	public String getGridY() {
		return gridY;
	}
	public void setGridY(String gridY) {
		this.gridY = gridY;
	}
}
