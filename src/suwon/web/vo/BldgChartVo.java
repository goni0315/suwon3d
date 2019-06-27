package suwon.web.vo;

public class BldgChartVo {
	
	String bldg_year;
	String bldg_count;
	
	
	
	public BldgChartVo() {

	}
	public BldgChartVo(String bldg_year, String bldg_count) {
		this.bldg_year = bldg_year;
		this.bldg_count = bldg_count;
	}
	public String getBldg_year() {
		return bldg_year;
	}
	public void setBldg_year(String bldg_year) {
		this.bldg_year = bldg_year;
	}
	public String getBldg_count() {
		return bldg_count;
	}
	public void setBldg_count(String bldg_count) {
		this.bldg_count = bldg_count;
	}
	
	
	

}
