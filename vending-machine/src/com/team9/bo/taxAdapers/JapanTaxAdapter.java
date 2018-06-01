package com.team9.bo.taxAdapers;

public class JapanTaxAdapter implements TaxAdapterInterface {

	@Override
	public double getTax(double itemPrice) {
		// returns Japan sales tax.
		double salesTax = 8.0;

		return (itemPrice * salesTax / 100);
	}

}
