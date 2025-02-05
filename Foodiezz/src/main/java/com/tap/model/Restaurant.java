package com.tap.model;

import java.time.LocalTime;

public class Restaurant {
	
	private int restaurantId;
	private String name;
	private String address;
	private String phone;
	private float rating;
	private String cuisineType;
	private boolean isActive;
	private int estimatedTimeArrival;
	private int adminUserId;
	private String imagePath;
	
	public Restaurant() {
		
	}
	
	public Restaurant(int restaurantId, String name, String address, String phone, float rating, String cuisineType,
			boolean isActive, int estimatedTimeArrival, int adminUserId, String imagePath) {
		super();
		this.restaurantId = restaurantId;
		this.name = name;
		this.address = address;
		this.phone = phone;
		this.rating = rating;
		this.cuisineType = cuisineType;
		this.isActive = isActive;
		this.estimatedTimeArrival = estimatedTimeArrival;
		this.adminUserId = adminUserId;
		this.imagePath = imagePath;
	}

	public int getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public String getCuisisneType() {
		return cuisineType;
	}

	public void setCuisisneType(String cuisisneType) {
		this.cuisineType = cuisisneType;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public int getEstimatedTimeArrival() {
		return estimatedTimeArrival;
	}

	public void setEstimatedTimeArrival(int estimatedTimeArrival) {
		this.estimatedTimeArrival = estimatedTimeArrival;
	}

	public int getAdminUserId() {
		return adminUserId;
	}

	public void setAdminUserId(int adminUserId) {
		this.adminUserId = adminUserId;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	@Override
	public String toString() {
		return "Restaurant [restaurantId=" + restaurantId + ", name=" + name + ", address=" + address + ", phone=" + phone
				+ ", rating=" + rating + ", cuisineType=" + cuisineType + ", isActive=" + isActive
				+ ", estimatedTimeArrival=" + estimatedTimeArrival + ", adminUserId=" + adminUserId + ", imagePath="
				+ imagePath + "]";
	}
}
