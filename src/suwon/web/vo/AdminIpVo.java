package suwon.web.vo;

public class AdminIpVo {
	String usrid;
	String conip;	
	
	public AdminIpVo() {
	}
	
	public AdminIpVo(String usrid, String conip) {
		this.usrid = usrid;
		this.conip = conip;
	}
	public String getUsrid() {
		return usrid;
	}
	public void setUsrid(String usrid) {
		this.usrid = usrid;
	}
	public String getConip() {
		return conip;
	}
	public void setConip(String conip) {
		this.conip = conip;
	}
	

}
