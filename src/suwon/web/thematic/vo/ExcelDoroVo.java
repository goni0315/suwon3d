package suwon.web.thematic.vo;

import org.springframework.web.multipart.MultipartFile;

public class ExcelDoroVo {	
	
	private String name;
	private String sggNm;
	private String doroName;
	private String buldBonCd;
	private String buldBooCd;
	private String color;
	private String numSize;
	private String info;
	private String bd_mgt_sn;
	private String rds_man_no;
	private MultipartFile fileUrl;
	
	
	public ExcelDoroVo(String name,String sggNm,String doroName, String buldBonCd, String buldBooCd, String color, String numSize, String bd_mgt_sn){
		setName(name);		
		setSggNm(sggNm);
		setDoroName(doroName);
		setBuldBonCd(buldBonCd);
		setBuldBooCd(buldBooCd);
		setColor(color);
		setNumSize(numSize);
		setBd_mgt_sn(bd_mgt_sn);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSggNm() {
		return sggNm;
	}

	public void setSggNm(String sggNm) {
		this.sggNm = sggNm;
	}

	public String getDoroName() {
		return doroName;
	}

	public void setDoroName(String doroName) {
		this.doroName = doroName;
	}

	public String getBuldBonCd() {
		return buldBonCd;
	}

	public void setBuldBonCd(String buldBonCd) {
		this.buldBonCd = buldBonCd;
	}

	public String getBuldBooCd() {
		return buldBooCd;
	}

	public void setBuldBooCd(String buldBooCd) {
		this.buldBooCd = buldBooCd;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getNumSize() {
		return numSize;
	}

	public void setNumSize(String numSize) {
		this.numSize = numSize;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getRds_man_no() {
		return rds_man_no;
	}

	public void setRds_man_no(String rds_man_no) {
		this.rds_man_no = rds_man_no;
	}

	public String getBd_mgt_sn() {
		return bd_mgt_sn;
	}

	public void setBd_mgt_sn(String bd_mgt_sn) {
		this.bd_mgt_sn = bd_mgt_sn;
	}

	public MultipartFile getFileUrl() {
		return fileUrl;
	}

	public void setFileUrl(MultipartFile fileUrl) {
		this.fileUrl = fileUrl;
	}
	
	}


