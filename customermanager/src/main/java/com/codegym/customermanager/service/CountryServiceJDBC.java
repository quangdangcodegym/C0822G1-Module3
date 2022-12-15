package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Country;
import com.codegym.customermanager.model.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CountryServiceJDBC extends DatabaseContext implements ICountryService{
    private static final String SELECT_ALL_COUNTRY = "select * from country;";
    private static final String FIND_COUNTRY_BY_ID = "select * from country where id = ";




    @Override
    public List<Country> getAllCountry() {
        List<Country> countries = new ArrayList<>();
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COUNTRY);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Country country = getCountryFromResulSet(rs);
                countries.add(country);
            }
            connection.close();
        } catch (SQLException exception) {
            printSQLException(exception);
        }
        return countries;
    }

    private Country getCountryFromResulSet(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");


        Country country = new Country(id, name);
        return country;
    }

    @Override
    public Country findCountryById(long id) {
        try{
            Connection connection = getConnection();

            Statement statement = connection.createStatement();
            String query = FIND_COUNTRY_BY_ID + id;
            ResultSet rs = statement.executeQuery(query);
            while (rs.next()) {
                Country country = getCountryFromResulSet(rs);
                return country;
            }
            connection.close();
        }catch (SQLException sqlException){
            printSQLException(sqlException);
        }
        return null;
    }

}
