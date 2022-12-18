package com.codegym.customermanager.repositoryv1;

import com.codegym.customermanager.model.Country;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CountryRepository extends DatabaseContext<Country> {
    public CountryRepository() {
        super(Country.class);
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
    public void addCustom(Country obj) {
        queryDDL("INSERT INTO `country` (`name`) VALUES (?)", obj.getName());
    }
    @Override
    public void updateCustom(Country obj) {
        queryDDL("UPDATE `c8_customermanager`.`country` SET `name` = ? WHERE (`id` = ?)", obj.getName(), obj.getId());
    }
}
