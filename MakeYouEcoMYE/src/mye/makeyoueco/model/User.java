package mye.makeyoueco.model;

public class User {

	private int id;
	private String name;
	private String surname;
	private String email;
	private String password;
	private String date_registration;
	private String telephone;
	private boolean administrator;

	public User(int id, String name, String surname, String email, String password, String date_registration,
			String telephone, boolean administrator) {
		super();
		this.id = id;
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.password = password;
		this.date_registration = date_registration;
		this.telephone = telephone;
		this.administrator = administrator;
	}

	public User() {
		id = 0;
		name = "";
		surname = "";
		email = "";
		password = "";
		date_registration = "";
		telephone = "";
		administrator = false;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDate_registration() {
		return date_registration;
	}

	public void setDate_registration(String date_registration) {
		this.date_registration = date_registration;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public boolean isAdministrator() {
		return administrator;
	}

	public void setAdministrator(boolean administrator) {
		this.administrator = administrator;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", surname=" + surname + ", email=" + email + ", password="
				+ password + ", date_registration=" + date_registration + ", telephone=" + telephone
				+ ", administrator=" + administrator + "]";
	}

}
