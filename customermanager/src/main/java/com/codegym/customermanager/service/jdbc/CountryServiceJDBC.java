package com.codegym.customermanager.service.jdbc;

import com.codegym.customermanager.model.Country;
import com.codegym.customermanager.service.ICountryService;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CountryServiceJDBC extends DatabaseContext implements ICountryService {
    private static final String SELECT_ALL_COUNTRY = "select * from country;";
    private static final String FIND_COUNTRY_BY_ID = "select * from country where id = ";
    private static final String SP_INSERTCOUNTRY = "call spInsertCountry(?, ?);";


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

    @Override
    public boolean insertCountryBySP(String nameCountry) {
        boolean check = false;
        try {
            // spInsertCountry(?, ?);
            Connection connection = getConnection();
            CallableStatement callableStatement = connection.prepareCall(SP_INSERTCOUNTRY);
            callableStatement.setString(1, nameCountry);
            callableStatement.registerOutParameter(2, Types.BOOLEAN);

            System.out.println(this.getClass() + " insertCountryBySP: " + callableStatement);
            callableStatement.execute();

            check = callableStatement.getBoolean(2);

        } catch (SQLException sqlException) {
            printSQLException(sqlException);


        }
        return check;
    }

    @Override
    public boolean testProcedure() {

        Connection connection = null;
        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO `country` (`id`, `name`) VALUES ('7', 'Anh123')");
            preparedStatement.executeUpdate();

            connection.prepareStatement("INSERT INTO `country` (`id`, `name`) VALUES ('7', 'Phap')");
            preparedStatement.executeUpdate();

            connection.commit();
            connection.close();
        } catch (SQLException sqlException) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            printSQLException(sqlException);

        }
        return false;
    }

}
