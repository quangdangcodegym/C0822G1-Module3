package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Customer;

import java.util.List;

public interface ICustomerService {
    List<Customer> getAllCustomers();
    void addCustomer(Customer customer);
    Customer findCustomerById(long id);
    void updateCustomer(Customer customer);
    void deleteCustomer(long id);

    List<Customer> getAllCustomerByIdCountry(long idCountry);
}
