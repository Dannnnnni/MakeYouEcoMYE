package mye.makeyoueco.model;

public class ProductOrder {

	private int productId;
	private int orderId;
	private int quantity;
	private double price;
	private int iva;

	public ProductOrder() {
	}

	public ProductOrder(int productId, int orderId, int quantity, double price, int iva) {
		super();
		this.productId = productId;
		this.orderId = orderId;
		this.quantity = quantity;
		this.price = price;
		this.iva = iva;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
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
		return "Product_Order [productId=" + productId + ", orderId=" + orderId + ", quantity=" + quantity
				+ ", price=" + price + ", iva=" + iva + "]";
	}

}
