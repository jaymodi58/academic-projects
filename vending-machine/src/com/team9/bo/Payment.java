package com.team9.bo;

public class Payment {

	String status;

	public double makePayment(double itemAmount, double cash) {
		// Cash payment method invocation
		double changeAmount = cash - itemAmount;
		if (changeAmount >= 0) {
			return changeAmount;
		}

		return -1;	// returns -1 on payment failure.
	}

	public String makePayment(double itemAmount, String ccname) {
		// Card payment method invocation
		PaymentAuthorization paymentAuthorization = new PaymentAuthorization();
		String status = paymentAuthorization.authenticate(ccname);
		return status;	// returns the valid/invalid card status.

	}

}
