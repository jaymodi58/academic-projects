package com.team9.bo.taxAdapers;

public class IndiaTaxAdapter implements TaxAdapterInterface {

	@Override
	public double getTax(double itemPrice) {
		// returns Indian sales tax.
		double salesTax = 14.5;

		return (itemPrice * salesTax / 100);
	}
}
