package com.codegym.customermanager.repository;

import com.codegym.customermanager.model.Customer;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CustomerRepository extends DatabaseContext<Customer>{

    public CustomerRepository() {
        modelMapper = new ModelMapper<Customer>() {
            @Override
            public Customer mapperToModel(ResultSet rs) throws SQLException {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String address = rs.getString("address");
                int idCountry = rs.getInt("idCountry");

                Customer customer = new Customer(id, name, address, idCountry);
                return customer;
            }
        };
    }
    @Override
    public List<Customer> getAll() {

        return queryAll("select * from Customer", modelMapper);
    }

    @Override
    public List<Customer> getAllPagging(int offset, int numberOfPage) {
        return queryAllPagging("select * from Customer limit ? , ?", modelMapper, Long.valueOf(offset), Long.valueOf(numberOfPage));
    }

    public List<Customer> getAllPaggingByKwAndIdCountry(String kw, int idCountry, int offset, int numberOfPage) {
        if (idCountry == -1) {
            return queryAllPagging("select * from Customer name like ? limit ? , ?", modelMapper, "%" + kw + "%", Long.valueOf(offset), Long.valueOf(numberOfPage));
        }
        return queryAllPagging("select * from Customer name like ? and idcountry = ? limit ? , ?", modelMapper,"%" + kw + "%",Long.valueOf(idCountry), Long.valueOf(offset), Long.valueOf(numberOfPage));
    }

    @Override
    public Customer findById(long id) {
        return queryFindById("select * from Customer where id = ?", modelMapper, Long.valueOf(id));
    }
    @Override
    public void add(Customer obj) {
        queryDDL( "INSERT INTO `customer` (`name`, `address`, `idCountry`) VALUES (?, ?, ?);", obj.getName(), obj.getAddress(), obj.getIdCountry());
    }
    @Override
    public void update(Customer obj) {
        queryDDL("UPDATE `customer` SET `name` = ? WHERE (`id` = ?)", obj.getName(), obj.getId());
    }
    @Override
    public void delete(long id) {
        queryDDL("DELETE FROM `customer` WHERE (`id` = ?);", Long.valueOf(id));
    }
}
