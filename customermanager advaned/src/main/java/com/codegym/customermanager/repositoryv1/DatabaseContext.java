package com.codegym.customermanager.repositoryv1;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public abstract class DatabaseContext<T>{
    protected ModelMapper<T> modelMapper;
    private Class<T> tClass;
    protected String jdbcURL = "jdbc:mysql://localhost:3306/c8_customermanager";
    protected String jdbcUsername = "root";
    protected String jdbcPassword = "St180729!!";


    public DatabaseContext(Class<T> tClass) {
        this.tClass = tClass;
    }


    protected Connection getConnection() {
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

    public List<T> getAll(){
        System.out.println(tClass.getSimpleName());
        System.out.println(tClass.getSimpleName().toLowerCase());
        System.out.println(tClass.getName());
        System.out.println(tClass.getPackage());
        String queryGetAllT = String.format("select * from %s", tClass.getSimpleName().toLowerCase());
        return queryAll(queryGetAllT, modelMapper);
    }
    public List<T> getAllPagging(int offset, int numberOfPage){
        String queryGetAllPaggingT = String.format("select * from %s limit ? , ?", tClass.getSimpleName().toLowerCase());
        return queryAllPagging(queryGetAllPaggingT, modelMapper, Long.valueOf(offset), Long.valueOf(numberOfPage));
    }
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


    public List<T> queryAllPagging(String query, ModelMapper<T> modelMapper, Object ...parameters) {
        List<T> items = new ArrayList<>();
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            setParameter(preparedStatement, parameters);
            System.out.println(this.getClass() + " queryAllPagging: " + preparedStatement);
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
    public T findById(long id){
        String queryFindByIdT = String.format("select * from `%s` where id = ?", tClass.getSimpleName().toLowerCase());
        return queryFindById(queryFindByIdT, modelMapper, Long.valueOf(id));
    }
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

    public abstract void addCustom(T obj);
    public void add(T obj){
        //queryDDL( "INSERT INTO `customer` (`name`, `address`, `idCountry`) VALUES (?, ?, ?);", obj.getName(), obj.getAddress(), obj.getIdCountry());
        //String queryAddT = "INSERT INTO `customer` (`name`, `address`, `idCountry`) VALUES (?, ?, ?);";


        Field[] fields = queryFields(tClass);
        String strQueryFields = convertToQueryFields(fields);

        Method[] methods = queryMethodOfFields(obj);
        Object[] params = getValueMethodOfFields(methods, obj);

        String strQueryAskSymbol = converToQueryAskSymbol(params);

        String queryAddT = String.format("INSERT INTO `%s` (%s) VALUES (%s);",tClass.getSimpleName().toLowerCase(), strQueryFields, strQueryAskSymbol);
        System.out.println(queryAddT);
        queryDDL(queryAddT, params);

    }

    private String converToQueryAskSymbol(Object[] params) {
        String str = "";
        for (int i = 0; i < params.length; i++) {
            str += "?";
            if (i != params.length - 1) {
                str += ",";
            }
        }
        return str;
    }

    private String convertToQueryFields(Field[] fields) {
        String str = "";
        for (int i = 0; i < fields.length; i++) {
            str += fields[i].getName();
            if (i != fields.length - 1) {
                str += ",";
            }
        }
        return str;
    }

    private Method[] queryMethodOfFields(T obj) {
        ArrayList<Method> list = new ArrayList<>();
        for (int i = 0; i < tClass.getDeclaredFields().length; i++) {
            Method m1 = findMethod("get", tClass.getDeclaredFields()[i].getName());
            if (m1.getName().equals("getId")) {
                continue;
            }
            list.add(m1);
        }
        Method[] items = new Method[list.size()];
        for (int i = 0; i < items.length; i++) {
            items[i] = list.get(i);
        }
        return items;
    }

    private Object[] getValueMethodOfFields(Method[] methods, T obj) {
        Object[] objects = new Object[methods.length];
        for (int i = 0; i < methods.length; i++) {
            try {
                objects[i] = methods[i].invoke(obj);
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            } catch (InvocationTargetException e) {
                throw new RuntimeException(e);
            }
        }
        return objects;
    }
    private Field[] queryFields(Class<T> tClass) {
        List<Field> fields = new ArrayList<>();
        for (int i = 0; i < tClass.getDeclaredFields().length; i++) {
            if (tClass.getDeclaredFields()[i].getName().equals("id")) {
                continue;
            }
            fields.add(tClass.getDeclaredFields()[i]);
        }
        Field[] items = new Field[fields.size()];
        for (int i = 0; i < items.length; i++) {
            items[i] = fields.get(i);
        }
        return items;
    }

    public Method findMethod(String prefix, String name) {
        for (Method m : tClass.getDeclaredMethods()) {
            if (m.getName().contains(prefix) && m.getName().toUpperCase().contains(name.toUpperCase())) {
                return m;
            }
        }
        return null;
    }

    public abstract void updateCustom(T obj);

    public void update(T obj, long id) {
        //UPDATE `c8_customermanager`.`customer` SET `name` = ' vdav', `address` = 'addad âv', `idCountry` = '2' WHERE (`id` = '7');
        //queryDDL("UPDATE `customer` SET `name` = ? WHERE (`id` = ?)", obj.getName(), obj.getId());
//        String queryUpdateT = "UPDATE `%s` SET `name` = ?, `address` = ? WHERE (`id` = ?)";

        Field[] fields = queryFields(tClass);
        String strQueryUpdateFields = getQueryUpdateFields(fields);

        Method[] methods = queryMethodOfFields(obj);
        Object[] params = getValueMethodOfFields(methods, obj);


        String queryAddT = String.format("UPDATE `%s` SET %s WHERE (`id` = ?)",tClass.getSimpleName().toLowerCase(), strQueryUpdateFields);
        System.out.println(queryAddT);
        params = Arrays.copyOf(params, params.length + 1);
        params[params.length - 1] = Long.valueOf(id);
        queryDDL(queryAddT, params);
    }

    private String getQueryUpdateFields(Field[] fields) {
        String str = "";
        for (int i = 0; i < fields.length; i++) {
            str += String.format("`%s` = ?", fields[i].getName());
            if (i != fields.length - 1) {
                str += ",";
            }
        }
        return str;
    }

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

    public void delete(long id){
        String queryDeleteT = String.format("DELETE FROM `%s` WHERE (`id` = ?);", tClass.getSimpleName());
        queryDDL(queryDeleteT, Long.valueOf(id));
    }

    
}
