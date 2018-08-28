package suwon.web.thematic.vo;

public class ThematicExcelVo {
	private String pointX;
	private String pointY;
	
	public ThematicExcelVo(String pointX, String pointY){
		setPointX(pointX);
		setPointY(pointY);
	}
	
	public String getPointX() {
		return pointX;
	}
	public void setPointX(String pointX) {
		this.pointX = pointX;
	}
	public String getPointY() {
		return pointY;
	}
	public void setPointY(String pointY) {
		this.pointY = pointY;
	}
}
