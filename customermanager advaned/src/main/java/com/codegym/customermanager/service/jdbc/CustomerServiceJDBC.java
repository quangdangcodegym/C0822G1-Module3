package com.codegym.customermanager.service.jdbc;

import com.codegym.customermanager.model.Customer;
import com.codegym.customermanager.repository.CustomerRepository;
import com.codegym.customermanager.service.ICustomerService;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerServiceJDBC  implements ICustomerService {



    private CustomerRepository customerRepository;
    public CustomerServiceJDBC() {
        customerRepository = new CustomerRepository();
    }
    @Override
    public List<Customer> getAllCustomers() {
        return  customerRepository.getAll();
    }
    @Override
    public void addCustomer(Customer customer) {
        customerRepository.add(customer);
    }

    @Override
    public Customer findCustomerById(long id) {
        return customerRepository.findById(id);
    }

    @Override
    public void updateCustomer(Customer customer) {

    }

    @Override
    public void deleteCustomer(long id) {

    }
}
