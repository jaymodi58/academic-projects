package com.team9.bo;

public class PaymentAuthorization {

	public String authenticate(String cardId) {
		// Payment authorization
		// For now, card payments are okay. No verification from the agent
		return "valid";
	}

}
