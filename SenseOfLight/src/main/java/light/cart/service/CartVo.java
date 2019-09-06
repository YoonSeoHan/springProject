package light.cart.service;

public class CartVo {
	private int productNum;
	private String productName;
	private String productAccount;
	private String productPrice;
	private String productDiscount;
	private String productPriceTotal;
	private String productOption1;
	private String productOption2;
	private String productMileage;
	private String imgList;
	private int productCount;
	private String productAmount;
	private String memId;
	
	
	public String getProductAmount() {
		return productAmount;
	}

	public void setProductAmount(String productAmount) {
		this.productAmount = productAmount;
	}

	public String getProductPriceTotal() {
		return productPriceTotal;
	}

	public void setProductPriceTotal(String productPriceTotal) {
		this.productPriceTotal = productPriceTotal;
	}

	public CartVo() {
		this.productCount = 0;
	}
	
	public String getProductDiscount() {
		return productDiscount;
	}

	public void setProductDiscount(String productDiscount) {
		this.productDiscount = productDiscount;
	}

	public String getProductOption1() {
		return productOption1;
	}

	public void setProductOption1(String productOption1) {
		this.productOption1 = productOption1;
	}

	public String getProductOption2() {
		return productOption2;
	}

	public void setProductOption2(String productOption2) {
		this.productOption2 = productOption2;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductAccount() {
		return productAccount;
	}
	public void setProductAccount(String productAccount) {
		this.productAccount = productAccount;
	}
	public String getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductMileage() {
		return productMileage;
	}
	public void setProductMileage(String productMileage) {
		this.productMileage = productMileage;
	}
	public String getImgList() {
		return imgList;
	}
	public void setImgList(String imgList) {
		this.imgList = imgList;
	}
	public int getProductCount() {
		return productCount;
	}
	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}
	
	
}
