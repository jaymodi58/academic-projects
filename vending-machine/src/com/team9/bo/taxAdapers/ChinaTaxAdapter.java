package com.team9.bo.taxAdapers;

public class ChinaTaxAdapter implements TaxAdapterInterface {

	@Override
	public double getTax(double itemPrice) {
		// returns China sales tax.
		double salesTax = 17.0;

		return (itemPrice * salesTax / 100);
	}

}