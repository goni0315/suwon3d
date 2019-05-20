package util;

//페이징 클래스

public class Paging {
	 private int totalCount; // 전체 게시물 개수
	 private	int pageNum; // 현제 페이지 번호
	 private	int contentNum; // 한 페이지에 몇 개 게시물 표시할지
	 private	int startPage=1; // 현재 페이지 블록의 시작 페이지 번호
	 private	int endPage=5; // 현재 페이지 블록의 끝 페이지 번호
	 private	boolean prev=false; // 이전 페이지
	 private	boolean next; // 다음 페이지
	 private	int currentBlock; // 현재 페이지 블록
	 private	int lastBlock; // 마지막 페이지 블록

	// 몇 페이지까지 있는지, 총 페이지 수
	// 125 / 10 > 12.5 > 5
	// 13
	public int calcPage(int totalCount, int contentNum) {
		int totalPage = totalCount / contentNum;
		if (totalCount % contentNum > 0) {
			totalPage++;
		}
		return totalPage;
	}

	// 페이지 화살표 보여주기 유무
	// 첫페이지는 이전이 보이면 안되고 마지막 페이지는 다음이 보이면 안됨
	public void prevnext(int pageNum) {
		if (pageNum > 0 && pageNum < 6) {
			setPrev(false);
			setNext(true);
		} else if (getCurrentBlock() == getLastBlock()) {
			setPrev(true);
			setNext(false);
		} else {
			setPrev(true);
			setNext(true);
		}
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getContentNum() {
		return contentNum;
	}

	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}

	public int getStartPage() {

		return startPage;
	}

	public void setStartPage(int currentBlock) {
		this.startPage = (currentBlock * 5) - 4;
	}
	// 1//1 2 3 4 5
	// 2//6 7 8 9 10
	// 2*5-4 페이지 블록2의 시작 페이지는 6

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int getLastBlock, int getCurrentBlock) {
		if (getLastBlock == getCurrentBlock) {
			this.endPage = calcPage(getTotalCount(), getContentNum());
		} else {
			this.endPage = getStartPage() + 4;
		}

	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getCurrentBlock() {
		return currentBlock;
	}

	public void setCurrentBlock(int pageNum) {
		// 페이지 번호 / 페이지 블록안의 페이지 개수
		// 1p 1 / 5 > 0.2 0

		this.currentBlock = pageNum / 5;
		if (pageNum % 5 > 0) {
			this.currentBlock++;
		}
	}

	public int getLastBlock() {
		return lastBlock;
	}

	public void setLastBlock(int totalCount) {
		// 전체 게시물 나누기 한 블록당 게시물수 > 마지막 블록
		// 125 나누기 50 2.5 나머지 5기때문에 +1 마지막 블록 3
		this.lastBlock = totalCount / (5 * this.contentNum);
		if (totalCount % (5 * this.contentNum) > 0) {
			this.lastBlock++;
		}
	}
}
