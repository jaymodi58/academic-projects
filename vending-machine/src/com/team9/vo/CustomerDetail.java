package com.team9.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "customer_detail")
public class CustomerDetail {
	// Customer attributes
	@Id
	@Column(name = "customer_id")
	@NotEmpty(message="Please specify Customer Id.")
	private String customerId;

	@Column(name = "name")
	@NotEmpty(message="Please specify Customer name.")
	private String name;

	@Column(name = "remaining_limit")
	private double remainingLimit;
	
	public CustomerDetail() {
		super();
	}

	public CustomerDetail(String customerId, String name, double remainingLimit) {
		super();
		this.customerId = customerId;
		this.name = name;
		this.remainingLimit = remainingLimit;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getRemainingLimit() {
		return remainingLimit;
	}

	public void setRemainingLimit(double remainingLimit) {
		this.remainingLimit = remainingLimit;
	}
}
