package com.team9.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "item_description")
public class ItemDescription {
	// Item attributes
	public ItemDescription() {
		super();
	}

	public ItemDescription(String itemId, String itemName, int itemPrice) {
		super();
		this.itemId = itemId;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
	}

	@Id
	@Column(name = "item_id")
	// @GeneratedValue(strategy = GenerationType.IDENTITY)
	private String itemId;

	@Column(name = "item_name")
	private String itemName;

	@Column(name = "item_price")
	private int itemPrice;

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}
}