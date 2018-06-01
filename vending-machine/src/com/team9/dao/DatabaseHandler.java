package com.team9.dao;

//import java.util.Iterator;

//import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.team9.vo.CustomerDetail;
import com.team9.vo.ItemDescription;
import com.team9.util.HibernateUtil;

public class DatabaseHandler {
	public static boolean updateFlag = false;

	public String insertCustomerRecord(CustomerDetail customerDetail) {
		// Inserts the customer details in the database.
		Session session = HibernateUtil.getSessionFactory().openSession();

		Transaction tx = session.beginTransaction();
		String id = (String) session.save(customerDetail);
		tx.commit();
		session.close();

		return id;
	}

	public CustomerDetail getCustomerById(String customerId) {
		// Get the customer details by customer id.
		Session session = null;
		CustomerDetail customerDetail = null;

		try {
			session = HibernateUtil.getSessionFactory().openSession();
			customerDetail = (CustomerDetail) session.get(CustomerDetail.class, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null && session.isOpen()) {
				session.close();
			}
		}
		return customerDetail;
	}

	public ItemDescription getItemById(String itemId) {
		// Get the item details by item id.
		Session session = null;
		ItemDescription itemDescription = null;

		try {
			session = HibernateUtil.getSessionFactory().openSession();
			itemDescription = (ItemDescription) session.get(ItemDescription.class, itemId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null && session.isOpen()) {
				session.close();
			}
		}
		return itemDescription;
	}

	public void updateRemainingLimit(String id, double itemPrice) {
		// Update the remaining limit of customer.
		Session session = HibernateUtil.getSessionFactory().openSession();

		// Getting the object for id
		CustomerDetail customerDetail2 = (CustomerDetail) session.load(CustomerDetail.class, new String(id));
		// Setting the new values in object which we got
		customerDetail2.setRemainingLimit(customerDetail2.getRemainingLimit() - itemPrice);

		Transaction tx = session.beginTransaction();
		session.update(customerDetail2);
		tx.commit();
		session.close();
	}

}
