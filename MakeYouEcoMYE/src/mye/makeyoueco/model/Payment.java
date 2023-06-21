package mye.makeyoueco.model;

public class Payment {

	private int id;
	private String firstName;
	private String lastName;
	private int cardNumber;
	private int CVV;
	private int expiryMonth;
	private int expiryYear;
	private int userId;

	public Payment() {
	}

	public Payment(int id, String firstName, String lastName, int cardNumber, int cVV, int expiryMonth,
			int expiryYear, int userId) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.cardNumber = cardNumber;
		CVV = cVV;
		this.expiryMonth = expiryMonth;
		this.expiryYear = expiryYear;
		this.userId = userId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
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

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Payment [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", cardNumber="
				+ cardNumber + ", CVV=" + CVV + ", expiryMonth=" + expiryMonth + ", expiryYear=" + expiryYear
				+ ", userId=" + userId + "]";
	}

}
