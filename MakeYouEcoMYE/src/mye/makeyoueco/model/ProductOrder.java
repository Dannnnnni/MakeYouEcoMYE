package mye.makeyoueco.model;

public class ProductOrder {

	private int product_id;
	private int order_id;
	private int quantity;
	private double price;
	private int iva;

	public ProductOrder() {
	}

	public ProductOrder(int product_id, int order_id, int quantity, double price, int iva) {
		super();
		this.product_id = product_id;
		this.order_id = order_id;
		this.quantity = quantity;
		this.price = price;
		this.iva = iva;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getOrder_id() {
		return order_id;
	}

	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getIva() {
		return iva;
	}

	public void setIva(int iva) {
		this.iva = iva;
	}

	@Override
	public String toString() {
		return "Product_Order [product_id=" + product_id + ", order_id=" + order_id + ", quantity=" + quantity
				+ ", price=" + price + ", iva=" + iva + "]";
	}

}
