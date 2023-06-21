package mye.makeyoueco.model;

public class Order {

	private int id;
	private int quantity;
	private String date;
	private double totalCost;
	private String status;
	private int userId;
	private int addressId;
	private int paymentId;

	public Order() {
	}

	public Order(int id, int quantity, String date, double totalCost, String status, int userId, int addressId,
			int paymentId) {
		this.id = id;
		this.quantity = quantity;
		this.date = date;
		this.totalCost = totalCost;
		this.status = status;
		this.userId = userId;
		this.addressId = addressId;
		this.paymentId = paymentId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public int getPaymentId() {
		return paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	@Override
	public String toString() {
		return "Order [id=" + id + ", quantity=" + quantity + ", date=" + date + ", totalCost=" + totalCost
				+ ", status=" + status + ", userId=" + userId + ", addressId=" + addressId + ", paymentId="
				+ paymentId + "]";
	}

}