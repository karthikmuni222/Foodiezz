package com.tap.daoImplementation;

import java.util.List;

import com.tap.model.Restaurant;

public class Main {

	public static void main(String[] args) {
		
		RestaurantDAOImpl rdi = new RestaurantDAOImpl();
//		List<Restaurant> allRestaurants = rdi.getAllRestaurants();
//		
//		for( Restaurant r : allRestaurants) {
//			System.out.println(r);
//		}
		Restaurant restaurant = rdi.getRestaurant(1);
		System.out.println(restaurant);
	}

}
