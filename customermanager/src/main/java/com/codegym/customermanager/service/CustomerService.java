package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Customer;

import java.util.ArrayList;
import java.util.List;

public class CustomerService {
    private List<Customer> customers;


    public CustomerService() {
        customers = new ArrayList<>();
        customers.add(new Customer(1L, "Dang Van Quang", "28 NTP", 1));
        customers.add(new Customer(2L, "Dang Van Quý", "28 NTP", 1));
        customers.add(new Customer(3L, "Nguyen Quoc Cuong", "28 NTP", 2));
        customers.add(new Customer(4L, "Thuc Nguyen", "28 NTP", 2));
        customers.add(new Customer(5L, "Tan Dung", "28 NTP", 3));
    }

    public List<Customer> getAllCustomers() {
        return this.customers;
    }

    public void addCustomer(Customer customer) {
        customers.add(customer);
    }

    public Customer findCustomerById(long id) {
        for (Customer customer : customers) {
            if (customer.getId() == id) {
                return customer;
            }
        }
        return null;
    }

    public void updateCustomer(Customer customer) {
        for (Customer c : customers) {
            if (c.getId() == customer.getId()) {
                c.setName(customer.getName());
                c.setAddress(customer.getAddress());
                c.setIdCountry(customer.getIdCountry());
            }
        }
    }

    public void deleteCustomer(long id) {
        for (Customer c : customers) {
            if (c.getId() == id) {
                customers.remove(c);
                return;
            }
        }
    }
}
