package suwon.web.vo;

public class EmdVo {
	private String emd_cd;
	private String emd_nm;
	private String pnu;
	private String jibun;
	private String bchk;
	private String sggName;//ajax읍면동조회할 필드
	
	public String getEmd_cd() {
		return emd_cd;
	}
	public void setEmd_cd(String emd_cd) {
		this.emd_cd = emd_cd;
	}
	public String getEmd_nm() {
		return emd_nm;
	}
	public void setEmd_nm(String emd_nm) {
		this.emd_nm = emd_nm;
	}
	public String getPnu() {
		return pnu;
	}
	public void setPnu(String pnu) {
		this.pnu = pnu;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}
	public String getBchk() {
		return bchk;
	}
	public void setBchk(String bchk) {
		this.bchk = bchk;
	}
	public String getSggName() {
		return sggName;
	}
	public void setSggName(String sggName) {
		this.sggName = sggName;
	}
	
	
}
