package mye.makeyoueco.model;

public class Address {

	private int id;
	private String street;
	private String zip_code;
	private String city;
	private String province;
	private String country;
	private String instructions;
	private int user_id;

	public Address() {
	}

	public Address(int id, String street, String zip_code, String city, String province, String country,
			String instructions, int user_id) {
		this.id = id;
		this.street = street;
		this.zip_code = zip_code;
		this.city = city;
		this.province = province;
		this.country = country;
		this.instructions = instructions;
		this.user_id = user_id;
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

	public String getZip_code() {
		return zip_code;
	}

	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
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

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	@Override
	public String toString() {
		return "Address [id=" + id + ", street=" + street + ", zip_code=" + zip_code + ", city=" + city + ", province="
				+ province + ", country=" + country + ", instructions=" + instructions + ", user_id=" + user_id + "]";
	}

}
