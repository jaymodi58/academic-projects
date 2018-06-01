package com.team9.bo;

import com.team9.vo.ItemDescription;
import com.team9.dao.DatabaseHandler;
import com.team9.bo.taxAdapers.TaxAdapterInterface;

public class Sale {
	// Singleton class
	public static Sale sale;

	private Sale() {

	}

	public static Sale getInstance() {
		if (sale == null) {
			sale = new Sale();
		}
		return sale;
	}

	public double enterItem(String itemId) {
		// Enters the item into current transaction
		// Returns the item detail
		DatabaseHandler databaseHandler = new DatabaseHandler();
		ItemDescription itemDescription = databaseHandler.getItemById(itemId);

		return itemDescription.getItemPrice();
	}

	public double endSale(double itemPrice) {
		// Returns the amount from the appropriate adapter

		// Get the name of adapter
		String className = System.getProperty("taxAdapter");
		TaxAdapterInterface taxAdapter = null;
		try {
			// Creating the particular adapter object from the class name
			taxAdapter = (TaxAdapterInterface) Class.forName(className).newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		// Get only tax
		double tax = taxAdapter.getTax(itemPrice);
		// returns addition of price and tax.
		return itemPrice + tax;
	}

	public double makePayment(double itemAmount, double cash) {
		// Cash payment handling
		Payment payment = new Payment();
		double changeAmount = payment.makePayment(itemAmount, cash);
		return changeAmount;
	}

	public String makePayment(double itemAmount, String ccnumber) {
		// Card payment handling
		Payment payment = new Payment();
		String status = payment.makePayment(itemAmount, ccnumber);
		return status;
	}

}
