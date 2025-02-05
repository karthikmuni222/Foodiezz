package com.tap.model;

import java.time.LocalDateTime;

public class User {
	
	private int userId;
	private String name;
	private String username;
	private String password;
	private String email;
	private String phone;
	private String address;
	private String role;
	private LocalDateTime createdDate;
	private LocalDateTime lastLogindate;
	
	public User() {
		
	}
	
	public User(int userId, String name, String username, String password, String email, String phone, String address,
			String role, LocalDateTime createdDate, LocalDateTime lastLogindate) {
		super();
		this.userId = userId;
		this.name = name;
		this.username = username;
		this.password = password;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.role = role;
		this.createdDate = createdDate;
		this.lastLogindate = lastLogindate;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getLastLogindate() {
		return lastLogindate;
	}

	public void setLastLogindate(LocalDateTime localDateTime) {
		this.lastLogindate = localDateTime;
	}


}
