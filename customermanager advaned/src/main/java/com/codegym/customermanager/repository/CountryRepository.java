package com.codegym.customermanager.repository;

import com.codegym.customermanager.model.Country;
import com.codegym.customermanager.model.Customer;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CountryRepository extends DatabaseContext<Country>{
    public CountryRepository() {
        modelMapper = new ModelMapper<Country>() {
            @Override
            public Country mapperToModel(ResultSet rs) throws SQLException {
                int id = rs.getInt("id");
                String name = rs.getString("name");

                Country country = new Country(id, name);
                return country;
            }
        };
    }
    @Override
    public List<Country> getAll() {
        return queryAll("select * from country;", modelMapper);
    }
    @Override
    public Country findById(long id) {
        return queryFindById("select * from country where id = ?", modelMapper, Long.valueOf(id));
    }
    @Override
    public void add(Country obj) {
        queryDDL("INSERT INTO `country` (`name`) VALUES (?)", obj.getName());
    }
    @Override
    public void update(Country obj) {
        queryDDL("UPDATE `c8_customermanager`.`country` SET `name` = ? WHERE (`id` = ?)", obj.getName(), obj.getId());
    }
    @Override
    public void delete(long id) {
        queryDDL("DELETE FROM `country` WHERE (`id` = ?);", Long.valueOf(id));
    }
}
