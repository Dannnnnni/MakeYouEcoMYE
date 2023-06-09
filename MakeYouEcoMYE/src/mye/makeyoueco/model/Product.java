package mye.makeyoueco.model;

import java.io.Serializable;

import com.mysql.cj.jdbc.Blob;

public class Product implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private String name;
	private String description;
	private Double price;
	private float weight;
	private String image;
	private int quantity;
	private int iva;

	public Product(int id, String name, String description, Double price, float weight, String image, int quantity,
			int iva) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.weight = weight;
		this.image = image;
		this.quantity = quantity;
		this.iva = iva;
	}

	public Product() {
		id = 0;
		name = "";
		description = "";
		price = 0.0;
		image = "";
		weight = 0;
		quantity = 0;
		iva = 0;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public float getWeight() {
		return weight;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getIva() {
		return iva;
	}

	public void setIva(int iva) {
		this.iva = iva;
	}

	@Override
	public String toString() {
		return "ProductBean [id=" + id + ", name=" + name + ", description=" + description + ", price=" + price
				+ ", weight=" + weight + ", image=" + image + ", quantity=" + quantity + ", iva=" + iva + "]";
	}

}
