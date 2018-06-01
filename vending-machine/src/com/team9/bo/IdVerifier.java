package com.team9.bo;

import com.team9.dao.DatabaseHandler;
import com.team9.vo.CustomerDetail;

public class IdVerifier {

	public CustomerDetail verifyId(String customerId) {
		// Returns the customer detail if found.
		// otherwise returns null.
		DatabaseHandler databaseHandler = new DatabaseHandler();
		CustomerDetail customerDetail = null;
		customerDetail = databaseHandler.getCustomerById(customerId);

		return customerDetail;
	}
}
