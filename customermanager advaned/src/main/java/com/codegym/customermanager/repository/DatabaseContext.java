package com.codegym.customermanager.repository;

import com.codegym.customermanager.model.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public abstract class DatabaseContext<T>{
    protected  ModelMapper<T> modelMapper;
    protected String jdbcURL = "jdbc:mysql://localhost:3306/c8_customermanager";
    protected String jdbcUsername = "root";
    protected String jdbcPassword = "St180729!!";


    public Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return connection;
    }
    public void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

    public abstract List<T> getAll();
    public List<T> queryAll(String query, ModelMapper<T> modelMapper) {
        List<T> items = new ArrayList<>();
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            System.out.println(this.getClass() + " queryAll: " + preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                T item = modelMapper.mapperToModel(rs);
                items.add(item);
            }
        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
        return items;
    }
    public abstract T findById(long id);
    public T queryFindById(String query, ModelMapper<T> modelMapper, Object... parameters){
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            setParameter(preparedStatement, parameters);

            System.out.println(this.getClass() + " queryFindById: " + preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                T item = modelMapper.mapperToModel(rs);
                return item;
            }
        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
        return null;
    }
    private void setParameter(PreparedStatement statement, Object... parameters) {
        try {
            for (int i = 0; i < parameters.length; i++) {
                Object parameter = parameters[i];
                int index = i + 1;
                if (parameter instanceof Long) {
                    statement.setLong(index, (Long) parameter);
                } else if (parameter instanceof String) {
                    statement.setString(index, (String) parameter);
                } else if (parameter instanceof Integer) {
                    statement.setInt(index, (Integer) parameter);
                } else if (parameter instanceof Timestamp) {
                    statement.setTimestamp(index, (Timestamp) parameter);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public abstract void add(T obj);
    public abstract void update(T obj);
    public int queryDDL(String query, Object... parameters){
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            setParameter(preparedStatement, parameters);

            int result = preparedStatement.executeUpdate();
            connection.close();
            return result;
        }catch (SQLException sqlException){
            printSQLException(sqlException);
        }
        return -1;

    }

    public abstract void delete(long id);

    
}
