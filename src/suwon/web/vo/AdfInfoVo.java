package suwon.web.vo;

public class AdfInfoVo {
	
	private int ADF_SEQ; 		 //첨부파일 정보
	private int  BOD_SEQ;  		//공지사항 일련번호
	private  String ADF_NM;  	//파일명
	private  String ADF_TYP;	//확장자
	private  String REG_DAT;	//등록일
	
	
	public int getADF_SEQ() {
		return ADF_SEQ;
	}
	public void setADF_SEQ(int aDF_SEQ) {
		ADF_SEQ = aDF_SEQ;
	}
	public int getBOD_SEQ() {
		return BOD_SEQ;
	}
	public void setBOD_SEQ(int bOD_SEQ) {
		BOD_SEQ = bOD_SEQ;
	}
	public String getADF_NM() {
		return ADF_NM;
	}
	public void setADF_NM(String aDF_NM) {
		ADF_NM = aDF_NM;
	}
	public String getADF_TYP() {
		return ADF_TYP;
	}
	public void setADF_TYP(String aDF_TYP) {
		ADF_TYP = aDF_TYP;
	}
	public String getREG_DAT() {
		return REG_DAT;
	}
	public void setREG_DAT(String rEG_DAT) {
		REG_DAT = rEG_DAT;
	}
	
}


