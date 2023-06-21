package mye.makeyoueco.model;

public class Address {

	private int id;
	private String street;
	private String zipCode;
	private String city;
	private String province;
	private String country;
	private String instructions;
	private int userId;

	public Address() {
	}

	public Address(int id, String street, String zipCode, String city, String province, String country,
			String instructions, int userId) {
		this.id = id;
		this.street = street;
		this.zipCode = zipCode;
		this.city = city;
		this.province = province;
		this.country = country;
		this.instructions = instructions;
		this.userId = userId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getInstructions() {
		return instructions;
	}

	public void setInstructions(String instructions) {
		this.instructions = instructions;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Address [id=" + id + ", street=" + street + ", zipCode=" + zipCode + ", city=" + city + ", province="
				+ province + ", country=" + country + ", instructions=" + instructions + ", userId=" + userId + "]";
	}

}
