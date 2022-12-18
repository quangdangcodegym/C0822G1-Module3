package com.codegym.customermanager.repositoryv1;

import com.codegym.customermanager.model.Customer;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CustomerRepository extends DatabaseContext<Customer> {

    public CustomerRepository() {
        super(Customer.class);
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

    public List<Customer> getAllPaggingByKwAndIdCountry(String kw, int idCountry, int offset, int numberOfPage) {
        if (idCountry == -1) {
            return queryAllPagging("select * from Customer name like ? limit ? , ?", modelMapper, "%" + kw + "%", Long.valueOf(offset), Long.valueOf(numberOfPage));
        }
        return queryAllPagging("select * from Customer name like ? and idcountry = ? limit ? , ?", modelMapper,"%" + kw + "%",Long.valueOf(idCountry), Long.valueOf(offset), Long.valueOf(numberOfPage));
    }

    @Override
    public void addCustom(Customer obj) {
        queryDDL( "INSERT INTO `customer` (`name`, `idCountry`) VALUES (?, ?);", obj.getName(), obj.getIdCountry());
    }
    @Override
    public void updateCustom(Customer obj) {
        queryDDL("UPDATE `customer` SET `name` = ? WHERE (`id` = ?)", obj.getName(), obj.getId());
    }
}
