package light.board.service;

public class Criteria {
	/*현재페이지*/
	private int page;
	
	/*페이지당 출력되는 게시글 갯수*/
	private int perPageNum;
	private String productNum;
	
	/*주문 상품 날짜*/
	private String fromDate;
	private String toDate;
	
	
	
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public String getProductNum() {
		return productNum;
	}
	public void setProductNum(String productNum) {
		this.productNum = productNum;
	}

	/*1~6페이지 까지 표현*/
	public Criteria(){
		this.page = 1;
		this.perPageNum = 6;
	}
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if(page <= 0){
			this.page = 1;
			return;
		}
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
		
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100){
			this.perPageNum = 6;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	
	public int getPageStart(){
		return (this.page -1 ) * perPageNum;
	}
	
}
