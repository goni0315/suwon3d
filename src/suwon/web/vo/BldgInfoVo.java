package suwon.web.vo;

public class BldgInfoVo {
	
	String utl3d_type;
	String utl3d_bad;
	String utl3d_bn;
	String utl_3d_rna;
	String pnu;
	String bldg_year;
	public BldgInfoVo() {
	}
	public BldgInfoVo(String utl3d_type, String utl3d_bad, String utl3d_bn, String utl_3d_rna, String pnu,
			String bldg_year) {
		this.utl3d_type = utl3d_type;
		this.utl3d_bad = utl3d_bad;
		this.utl3d_bn = utl3d_bn;
		this.utl_3d_rna = utl_3d_rna;
		this.pnu = pnu;
		this.bldg_year = bldg_year;
		
	}
	public String getUtl3d_type() {
		return utl3d_type;
	}
	public void setUtl3d_type(String utl3d_type) {
		this.utl3d_type = utl3d_type;
	}
	public String getUtl3d_bad() {
		return utl3d_bad;
	}
	public void setUtl3d_bad(String utl3d_bad) {
		this.utl3d_bad = utl3d_bad;
	}
	public String getUtl3d_bn() {
		return utl3d_bn;
	}
	public void setUtl3d_bn(String utl3d_bn) {
		this.utl3d_bn = utl3d_bn;
	}
	public String getUtl_3d_rna() {
		return utl_3d_rna;
	}
	public void setUtl_3d_rna(String utl_3d_rna) {
		this.utl_3d_rna = utl_3d_rna;
	}
	public String getPnu() {
		return pnu;
	}
	public void setPnu(String pnu) {
		this.pnu = pnu;
	}
	public String getBldg_year() {
		return bldg_year;
	}
	public void setBldg_year(String bldg_year) {
		this.bldg_year = bldg_year;
	}
	
	
	
	
	
	

}
