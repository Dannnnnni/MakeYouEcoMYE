package mye.makeyoueco.model;

public class Payment {

	private int id;
	private String first_name;
	private String last_name;
	private int cardNumber;
	private int CVV;
	private int expiryMonth;
	private int expiryYear;
	private int user_id;

	public Payment() {
	}

	public Payment(int id, String first_name, String last_name, int cardNumber, int cVV, int expiryMonth,
			int expiryYear, int user_id) {
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.cardNumber = cardNumber;
		CVV = cVV;
		this.expiryMonth = expiryMonth;
		this.expiryYear = expiryYear;
		this.user_id = user_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public int getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(int cardNumber) {
		this.cardNumber = cardNumber;
	}

	public int getCVV() {
		return CVV;
	}

	public void setCVV(int cVV) {
		CVV = cVV;
	}

	public int getExpiryMonth() {
		return expiryMonth;
	}

	public void setExpiryMonth(int expiryMonth) {
		this.expiryMonth = expiryMonth;
	}

	public int getExpiryYear() {
		return expiryYear;
	}

	public void setExpiryYear(int expiryYear) {
		this.expiryYear = expiryYear;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	@Override
	public String toString() {
		return "Payment [id=" + id + ", first_name=" + first_name + ", last_name=" + last_name + ", cardNumber="
				+ cardNumber + ", CVV=" + CVV + ", expiryMonth=" + expiryMonth + ", expiryYear=" + expiryYear
				+ ", user_id=" + user_id + "]";
	}

}
