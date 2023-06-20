package mye.makeyoueco.model;

public class Cart extends Product {
	private int quantity;
	private double price;
	private int iva;

	public Cart() {
	}

	@Override
	public int getQuantity() {
		return quantity;
	}

	@Override
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public Double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	@Override
	public int getIva() {
		return iva;
	}
	
	@Override
	public void setIva(int iva) {
		this.iva = iva;
	}



}