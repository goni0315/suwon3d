package suwon.web.vo;

public class BuildSearchVo {
	private int	   bul_man_no;
	private String bdtyp_cd;
	private String bd_mgt_sn;
	private int 	   bsi_int_sn;
	private int 	   bsi_zon_no;
	private int	   buld_mnnm;//건물본번
	private String buld_nm;//건물명
	private String buld_nm_dc;
	private String buld_se_cd;
	private int	   buld_slno;//건물부번
	private String buld_sttus;
	private String bul_dpn_se;
	private String bul_eng_nm;
	private String compet_de;
	private String emd_cd;
	private int	   eqb_man_sn;
	private String etc_bul_nm;
	private int	   gro_flo_co;
	private int	   ima_fil_sn;
	private String input_mthd;
	private String input_step;
	private String issu_yn;
	private String li_cd;
	private int	   lnbr_mnnm; //지번본번
	private int 	   lnbr_slno;	  //지번부번
	private String mntn_yn;
	private String mvmn_de;
	private String mvmn_resn;
	private String mvm_res_cd;
	private String ntfc_de;
	private String nti_trg_yn;
	private String opert_de;
	private String ope_man_id;
	private String pos_bul_nm;
	private String pos_bul_yn;
	private int 	  rds_man_no;
	private String rds_sig_cd;
	private String reg_pub_nm;
	private String rn_cd;
	private String sig_cd;
	private int 	   und_flo_co;
	private String zip;
	private String zip_ul_nm;
	private String zip_no;
	private String addr;//필드 추가 (주소 서브쿼리)
	private String sgg_nm;//필드 추가 (시군구명 서브쿼리)
	private String rn;	//필드추가 (도로명 서크붜리)
	private String emd_nm;//필드추가 (읍면동 서크붜리)
	private String jibun;//필드추가 (지번 서크붜리)
	private String pnu;//필드추가 (자바스크립트/대장)
	private String bldg_id;//필드추가
	
	public String getBldg_id() {
		return bldg_id;
	}
	public void setBldg_id(String bldg_id) {
		this.bldg_id = bldg_id;
	}
	public int getBul_man_no() {
		return bul_man_no;
	}
	public void setBul_man_no(int bul_man_no) {
		this.bul_man_no = bul_man_no;
	}
	public String getBdtyp_cd() {
		return bdtyp_cd;
	}
	public void setBdtyp_cd(String bdtyp_cd) {
		this.bdtyp_cd = bdtyp_cd;
	}
	public String getBd_mgt_sn() {
		return bd_mgt_sn;
	}
	public void setBd_mgt_sn(String bd_mgt_sn) {
		this.bd_mgt_sn = bd_mgt_sn;
	}
	public int getBsi_int_sn() {
		return bsi_int_sn;
	}
	public void setBsi_int_sn(int bsi_int_sn) {
		this.bsi_int_sn = bsi_int_sn;
	}
	public int getBsi_zon_no() {
		return bsi_zon_no;
	}
	public void setBsi_zon_no(int bsi_zon_no) {
		this.bsi_zon_no = bsi_zon_no;
	}
	public int getBuld_mnnm() {
		return buld_mnnm;
	}
	public void setBuld_mnnm(int buld_mnnm) {
		this.buld_mnnm = buld_mnnm;
	}
	public String getBuld_nm() {
		return buld_nm;
	}
	public void setBuld_nm(String buld_nm) {
		this.buld_nm = buld_nm;
	}
	public String getBuld_nm_dc() {
		return buld_nm_dc;
	}
	public void setBuld_nm_dc(String buld_nm_dc) {
		this.buld_nm_dc = buld_nm_dc;
	}
	public String getBuld_se_cd() {
		return buld_se_cd;
	}
	public void setBuld_se_cd(String buld_se_cd) {
		this.buld_se_cd = buld_se_cd;
	}
	public int getBuld_slno() {
		return buld_slno;
	}
	public void setBuld_slno(int buld_slno) {
		this.buld_slno = buld_slno;
	}
	public String getBuld_sttus() {
		return buld_sttus;
	}
	public void setBuld_sttus(String buld_sttus) {
		this.buld_sttus = buld_sttus;
	}
	public String getBul_dpn_se() {
		return bul_dpn_se;
	}
	public void setBul_dpn_se(String bul_dpn_se) {
		this.bul_dpn_se = bul_dpn_se;
	}
	public String getBul_eng_nm() {
		return bul_eng_nm;
	}
	public void setBul_eng_nm(String bul_eng_nm) {
		this.bul_eng_nm = bul_eng_nm;
	}
	public String getCompet_de() {
		return compet_de;
	}
	public void setCompet_de(String compet_de) {
		this.compet_de = compet_de;
	}
	public String getEmd_cd() {
		return emd_cd;
	}
	public void setEmd_cd(String emd_cd) {
		this.emd_cd = emd_cd;
	}
	public int getEqb_man_sn() {
		return eqb_man_sn;
	}
	public void setEqb_man_sn(int eqb_man_sn) {
		this.eqb_man_sn = eqb_man_sn;
	}
	public String getEtc_bul_nm() {
		return etc_bul_nm;
	}
	public void setEtc_bul_nm(String etc_bul_nm) {
		this.etc_bul_nm = etc_bul_nm;
	}
	public int getGro_flo_co() {
		return gro_flo_co;
	}
	public void setGro_flo_co(int gro_flo_co) {
		this.gro_flo_co = gro_flo_co;
	}
	public int getIma_fil_sn() {
		return ima_fil_sn;
	}
	public void setIma_fil_sn(int ima_fil_sn) {
		this.ima_fil_sn = ima_fil_sn;
	}
	public String getInput_mthd() {
		return input_mthd;
	}
	public void setInput_mthd(String input_mthd) {
		this.input_mthd = input_mthd;
	}
	public String getInput_step() {
		return input_step;
	}
	public void setInput_step(String input_step) {
		this.input_step = input_step;
	}
	public String getIssu_yn() {
		return issu_yn;
	}
	public void setIssu_yn(String issu_yn) {
		this.issu_yn = issu_yn;
	}
	public String getLi_cd() {
		return li_cd;
	}
	public void setLi_cd(String li_cd) {
		this.li_cd = li_cd;
	}
	public int getLnbr_mnnm() {
		return lnbr_mnnm;
	}
	public void setLnbr_mnnm(int lnbr_mnnm) {
		this.lnbr_mnnm = lnbr_mnnm;
	}
	public int getLnbr_slno() {
		return lnbr_slno;
	}
	public void setLnbr_slno(int lnbr_slno) {
		this.lnbr_slno = lnbr_slno;
	}
	public String getMntn_yn() {
		return mntn_yn;
	}
	public void setMntn_yn(String mntn_yn) {
		this.mntn_yn = mntn_yn;
	}
	public String getMvmn_de() {
		return mvmn_de;
	}
	public void setMvmn_de(String mvmn_de) {
		this.mvmn_de = mvmn_de;
	}
	public String getMvmn_resn() {
		return mvmn_resn;
	}
	public void setMvmn_resn(String mvmn_resn) {
		this.mvmn_resn = mvmn_resn;
	}
	public String getMvm_res_cd() {
		return mvm_res_cd;
	}
	public void setMvm_res_cd(String mvm_res_cd) {
		this.mvm_res_cd = mvm_res_cd;
	}
	public String getNtfc_de() {
		return ntfc_de;
	}
	public void setNtfc_de(String ntfc_de) {
		this.ntfc_de = ntfc_de;
	}
	public String getNti_trg_yn() {
		return nti_trg_yn;
	}
	public void setNti_trg_yn(String nti_trg_yn) {
		this.nti_trg_yn = nti_trg_yn;
	}
	public String getOpert_de() {
		return opert_de;
	}
	public void setOpert_de(String opert_de) {
		this.opert_de = opert_de;
	}
	public String getOpe_man_id() {
		return ope_man_id;
	}
	public void setOpe_man_id(String ope_man_id) {
		this.ope_man_id = ope_man_id;
	}
	public String getPos_bul_nm() {
		return pos_bul_nm;
	}
	public void setPos_bul_nm(String pos_bul_nm) {
		this.pos_bul_nm = pos_bul_nm;
	}
	public String getPos_bul_yn() {
		return pos_bul_yn;
	}
	public void setPos_bul_yn(String pos_bul_yn) {
		this.pos_bul_yn = pos_bul_yn;
	}
	public int getRds_man_no() {
		return rds_man_no;
	}
	public void setRds_man_no(int rds_man_no) {
		this.rds_man_no = rds_man_no;
	}
	public String getRds_sig_cd() {
		return rds_sig_cd;
	}
	public void setRds_sig_cd(String rds_sig_cd) {
		this.rds_sig_cd = rds_sig_cd;
	}
	public String getReg_pub_nm() {
		return reg_pub_nm;
	}
	public void setReg_pub_nm(String reg_pub_nm) {
		this.reg_pub_nm = reg_pub_nm;
	}
	public String getRn_cd() {
		return rn_cd;
	}
	public void setRn_cd(String rn_cd) {
		this.rn_cd = rn_cd;
	}
	public String getSig_cd() {
		return sig_cd;
	}
	public void setSig_cd(String sig_cd) {
		this.sig_cd = sig_cd;
	}
	public int getUnd_flo_co() {
		return und_flo_co;
	}
	public void setUnd_flo_co(int und_flo_co) {
		this.und_flo_co = und_flo_co;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getZip_ul_nm() {
		return zip_ul_nm;
	}
	public void setZip_ul_nm(String zip_ul_nm) {
		this.zip_ul_nm = zip_ul_nm;
	}
	public String getZip_no() {
		return zip_no;
	}
	public void setZip_no(String zip_no) {
		this.zip_no = zip_no;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getSgg_nm() {
		return sgg_nm;
	}
	public void setSgg_nm(String sgg_nm) {
		this.sgg_nm = sgg_nm;
	}
	public String getRn() {
		return rn;
	}
	public void setRn(String rn) {
		this.rn = rn;
	}
	public String getEmd_nm() {
		return emd_nm;
	}
	public void setEmd_nm(String emd_nm) {
		this.emd_nm = emd_nm;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}
	public String getPnu() {
		return pnu;
	}
	public void setPnu(String pnu) {
		this.pnu = pnu;
	}
	
	
	
}
