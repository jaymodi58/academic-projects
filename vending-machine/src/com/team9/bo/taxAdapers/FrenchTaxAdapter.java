package com.team9.bo.taxAdapers;

public class FrenchTaxAdapter implements TaxAdapterInterface {

	@Override
	public double getTax(double itemPrice) {
		// returns French sales tax.
		double salesTax = 20.0;

		return (itemPrice * salesTax / 100);
	}

}
