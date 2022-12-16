package com.codegym.customermanager.service.jdbc;

import com.codegym.customermanager.model.Customer;
import com.codegym.customermanager.service.ICustomerService;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerServiceJDBC extends DatabaseContext implements ICustomerService {
    private static final String SELECT_ALL_CUSTOMER = "select * from customer;";
    private static final String INSERT_CUSTOMER = "INSERT INTO `customer` (`name`, `address`, `idCountry`) VALUES (?, ?, ?);";
    private static final String FIND_BY_ID = "select * from customer where id = ";
    private static final String SP_GETALLCUSTOMER_BYIDCOUNTRY = "call spGetAllCustomerByIdCountry(?);";
    private static final String DELETE_CUSTOMER = "DELETE FROM `customer` WHERE (`id` = ?);";
    private static final String SELECT_CUSTOMERS_BY_KW_IDCOUNTRY = "SELECT * FROM customer where idCountry = ? and name like ?;";
    private static final String SELECT_CUSTOMERS_BY_KW_ALLCOUNTRY = "SELECT * FROM customer where name like ?;";

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

    @Override
    public List<Customer> getAllCustomersByKwAndIdCountry(String kw, long idCountry) {
        List<Customer> customers = new ArrayList<>();
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement;
            if (idCountry == -1) {
                //SELECT * FROM customer where name like ?";
                preparedStatement = connection.prepareStatement(SELECT_CUSTOMERS_BY_KW_ALLCOUNTRY);
                preparedStatement.setString(1, "%" + kw + "%");
            }else{
                //SELECT * FROM customer where idCountry = ? and name like ?;";
                preparedStatement = connection.prepareStatement(SELECT_CUSTOMERS_BY_KW_IDCOUNTRY);
                preparedStatement.setLong(1, idCountry);
                preparedStatement.setString(2,"%" + kw + "%");
            }
            System.out.println(this.getClass() + " getAllCustomersByKwAndIdCountry: " + preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Customer customer = getCustomerFromResulset(rs);
                customers.add(customer);
            }

            connection.close();
        } catch (SQLException sqlException) {
            
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
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CUSTOMER);
            preparedStatement.setLong(1, id);

            System.out.println(this.getClass() + " deleteCustomer: " + preparedStatement);

            preparedStatement.executeUpdate();
            connection.close();
        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
    }

    @Override
    public List<Customer> getAllCustomerByIdCountry(long idCountry) {
        // ?,?
        List<Customer> customers = new ArrayList<>();
        try {
            Connection connection  = getConnection();
            CallableStatement callableStatement = connection.prepareCall(SP_GETALLCUSTOMER_BYIDCOUNTRY);
            callableStatement.setLong(1, idCountry);

            System.out.println(this.getClass() + " getAllCustomerByIdCountry: " + callableStatement);
            ResultSet rs = callableStatement.executeQuery();
            while (rs.next()) {
                Customer customer = getCustomerFromResulset(rs);
                customers.add(customer);
            }
            connection.close();
        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
        return customers;
    }
}
