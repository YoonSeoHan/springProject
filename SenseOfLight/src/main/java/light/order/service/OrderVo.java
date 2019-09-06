package light.order.service;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import light.common.service.Reflect_Vo;

public class OrderVo implements Reflect_Vo{
	/*주문 상품 리스트*/
	private String memId;
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
	private String productMileageAmount;
	
	
	/*주문 정보*/
	private int orderNum;
	private int orderDtlnum;
	private String orderName;
	private String orderPaddr;
	private String orderDaddr;
	private String orderRaddr;
	private String orderLandline;
	private String orderPhone;
	private String orderEmail;
	
	/*주문 시간*/
	@DateTimeFormat(pattern="yyyyMMddHH")
	private LocalDate orderDate;
	
	/*배송 정보*/
	private String recipientName;
	private String recipientPaddr;
	private String recipientDaddr;
	private String recipientRaddr;
	private String recipientLandline;
	private String recipientPhone;
	private String recipientMessage;
	
	/*주문 상태*/
	private String orderStatus;
	private String codeId;
	private String codeValue;
	
	public String getCodeValue() {
		return codeValue;
	}
	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}
	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public int getOrderDtlnum() {
		return orderDtlnum;
	}
	public void setOrderDtlnum(int orderDtlnum) {
		this.orderDtlnum = orderDtlnum;
	}
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public LocalDate getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getOrderPaddr() {
		return orderPaddr;
	}
	public void setOrderPaddr(String orderPaddr) {
		this.orderPaddr = orderPaddr;
	}
	public String getOrderDaddr() {
		return orderDaddr;
	}
	public void setOrderDaddr(String orderDaddr) {
		this.orderDaddr = orderDaddr;
	}
	public String getOrderRaddr() {
		return orderRaddr;
	}
	public void setOrderRaddr(String orderRaddr) {
		this.orderRaddr = orderRaddr;
	}
	public String getOrderLandline() {
		return orderLandline;
	}
	public void setOrderLandline(String orderLandline) {
		this.orderLandline = orderLandline;
	}
	public String getOrderPhone() {
		return orderPhone;
	}
	public void setOrderPhone(String orderPhone) {
		this.orderPhone = orderPhone;
	}
	public String getOrderEmail() {
		return orderEmail;
	}
	public void setOrderEmail(String orderEmail) {
		this.orderEmail = orderEmail;
	}
	public String getRecipientName() {
		return recipientName;
	}
	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	public String getRecipientPaddr() {
		return recipientPaddr;
	}
	public void setRecipientPaddr(String recipientPaddr) {
		this.recipientPaddr = recipientPaddr;
	}
	public String getRecipientDaddr() {
		return recipientDaddr;
	}
	public void setRecipientDaddr(String recipientDaddr) {
		this.recipientDaddr = recipientDaddr;
	}
	public String getRecipientRaddr() {
		return recipientRaddr;
	}
	public void setRecipientRaddr(String recipientRaddr) {
		this.recipientRaddr = recipientRaddr;
	}
	public String getRecipientLandline() {
		return recipientLandline;
	}
	public void setRecipientLandline(String recipientLandline) {
		this.recipientLandline = recipientLandline;
	}
	public String getRecipientPhone() {
		return recipientPhone;
	}
	public void setRecipientPhone(String recipientPhone) {
		this.recipientPhone = recipientPhone;
	}
	public String getRecipientMessage() {
		return recipientMessage;
	}
	
	
	public void setRecipientMessage(String recipientMessage) {
		this.recipientMessage = recipientMessage;
	}
	public String getProductMileageAmount() {
		return productMileageAmount;
	}
	public void setProductMileageAmount(String productMileageAmount) {
		this.productMileageAmount = productMileageAmount;
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
	public String getProductDiscount() {
		return productDiscount;
	}
	public void setProductDiscount(String productDiscount) {
		this.productDiscount = productDiscount;
	}
	public String getProductPriceTotal() {
		return productPriceTotal;
	}
	public void setProductPriceTotal(String productPriceTotal) {
		this.productPriceTotal = productPriceTotal;
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
	public String getProductAmount() {
		return productAmount;
	}
	public void setProductAmount(String productAmount) {
		this.productAmount = productAmount;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	
}
