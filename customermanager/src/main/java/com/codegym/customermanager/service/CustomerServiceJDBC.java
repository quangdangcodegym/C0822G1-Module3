package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Customer;

import javax.xml.transform.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerServiceJDBC extends DatabaseContext implements ICustomerService{
    private static final String SELECT_ALL_CUSTOMER = "select * from customer;";
    private static final String INSERT_CUSTOMER = "INSERT INTO `customer` (`name`, `address`, `idCountry`) VALUES (?, ?, ?);";
    private static final String FIND_BY_ID = "select * from customer where id = ";




    @Override
    public List<Customer> getAllCustomers() {

        List<Customer> customers = new ArrayList<>();
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CUSTOMER);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Customer customer = getCustomerFromResulset(rs);
                customers.add(customer);
            }
            connection.close();
        } catch (SQLException exception) {
            printSQLException(exception);
        }
        return customers;
    }

    private Customer getCustomerFromResulset(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String address = rs.getString("address");
        int idCountry = rs.getInt("idCountry");

        Customer customer = new Customer(id, name, address, idCountry);
        return customer;
    }



    @Override
    public void addCustomer(Customer customer) {
        try {
            //INSERT INTO `customer` (`name`, `address`, `idCountry`) VALUES (?, ?, ?);";
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CUSTOMER);
            preparedStatement.setString(1, customer.getName());
            preparedStatement.setString(2, customer.getAddress());
            preparedStatement.setLong(3, customer.getIdCountry());

            preparedStatement.executeUpdate();

            connection.close();
        }catch (SQLException sqlException){
            printSQLException(sqlException);
        }


    }

    @Override
    public Customer findCustomerById(long id) {

        try{
            Connection connection = getConnection();

            Statement statement = connection.createStatement();
            String query = FIND_BY_ID + id;
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()) {
                Customer customer = getCustomerFromResulset(rs);
                return customer;
            }
            connection.close();
        }catch (SQLException sqlException){
            printSQLException(sqlException);
        }
        return null;
    }

    @Override
    public void updateCustomer(Customer customer) {

    }

    @Override
    public void deleteCustomer(long id) {

    }
}
