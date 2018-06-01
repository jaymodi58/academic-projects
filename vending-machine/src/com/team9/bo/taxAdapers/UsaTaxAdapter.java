package com.team9.bo.taxAdapers;

public class UsaTaxAdapter implements TaxAdapterInterface {

	@Override
	public double getTax(double itemPrice) {
		// returns Usa sales tax.
		double salesTax = 6.5;

		return (itemPrice * salesTax / 100);
	}

}
