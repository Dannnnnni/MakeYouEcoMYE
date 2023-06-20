package mye.makeyoueco.model;

public class Order {

	private int id;
	private int quantity;
	private String date;
	private double totalCost;
	private String status;
	private int user_id;
	private int address_id;
	private int payment_id;

	public Order() {
	}

	public Order(int id, int quantity, String date, double totalCost, String status, int user_id, int address_id,
			int payment_id) {
		this.id = id;
		this.quantity = quantity;
		this.date = date;
		this.totalCost = totalCost;
		this.status = status;
		this.user_id = user_id;
		this.address_id = address_id;
		this.payment_id = payment_id;
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

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getAddress_id() {
		return address_id;
	}

	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}

	public int getPayment_id() {
		return payment_id;
	}

	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}

	@Override
	public String toString() {
		return "Order [id=" + id + ", quantity=" + quantity + ", date=" + date + ", totalCost=" + totalCost
				+ ", status=" + status + ", user_id=" + user_id + ", address_id=" + address_id + ", payment_id="
				+ payment_id + "]";
	}

}