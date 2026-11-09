package dao;

import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import model.Car;

public class CarDAO {
    private Car map(ResultSet rs) throws SQLException {
        Car car = new Car();
        car.setCarId(rs.getInt("car_id"));
        car.setCarName(rs.getString("car_name"));
        car.setBrand(rs.getString("brand"));
        car.setModel(rs.getString("model"));
        car.setFuelType(rs.getString("fuel_type"));
        car.setPricePerDay(rs.getDouble("price_per_day"));
        car.setStatus(rs.getString("status"));
        car.setImageData(rs.getBytes("image_data"));
        car.setImageContentType(rs.getString("image_content_type"));
        return car;
    }

    public boolean addCar(Car car) {
        String sql="INSERT INTO cars(car_name,brand,model,fuel_type,price_per_day,status,image_data,image_content_type) VALUES(?,?,?,?,?,?,?,?)";
        try(Connection con=DBConnection.getConnection(); PreparedStatement ps=con.prepareStatement(sql)) {
            ps.setString(1,car.getCarName()); ps.setString(2,car.getBrand()); ps.setString(3,car.getModel());
            ps.setString(4,car.getFuelType()); ps.setDouble(5,car.getPricePerDay()); ps.setString(6,car.getStatus()); ps.setBytes(7,car.getImageData()); ps.setString(8,car.getImageContentType());
            return ps.executeUpdate()==1;
        } catch(Exception e){e.printStackTrace();return false;}
    }

    public boolean updateCar(Car car) {
        String sql="UPDATE cars SET car_name=?,brand=?,model=?,fuel_type=?,price_per_day=?,status=?,image_data=COALESCE(?,image_data),image_content_type=COALESCE(?,image_content_type) WHERE car_id=?";
        try(Connection con=DBConnection.getConnection(); PreparedStatement ps=con.prepareStatement(sql)) {
            ps.setString(1,car.getCarName()); ps.setString(2,car.getBrand()); ps.setString(3,car.getModel());
            ps.setString(4,car.getFuelType()); ps.setDouble(5,car.getPricePerDay()); ps.setString(6,car.getStatus()); ps.setBytes(7,car.getImageData()); ps.setString(8,car.getImageContentType()); ps.setInt(9,car.getCarId());
            return ps.executeUpdate()==1;
        } catch(Exception e){e.printStackTrace();return false;}
    }

    public boolean deleteCar(int carId) {
        String sql="DELETE FROM cars WHERE car_id=? AND NOT EXISTS (SELECT 1 FROM bookings WHERE car_id=?)";
        try(Connection con=DBConnection.getConnection(); PreparedStatement ps=con.prepareStatement(sql)) {
            ps.setInt(1,carId);ps.setInt(2,carId);return ps.executeUpdate()==1;
        } catch(Exception e){e.printStackTrace();return false;}
    }

    // The car's database status is the fleet status. Date-specific booking conflicts
    // are checked when a customer submits a booking.
    public ArrayList<Car> getAllCars() {
        ArrayList<Car> list=new ArrayList<>();
        String sql="SELECT car_id,car_name,brand,model,fuel_type,price_per_day,status,image_data,image_content_type FROM cars ORDER BY car_id";
        try(Connection con=DBConnection.getConnection(); PreparedStatement ps=con.prepareStatement(sql); ResultSet rs=ps.executeQuery()) {
            while(rs.next()) list.add(map(rs));
        } catch(Exception e){e.printStackTrace();}
        return list;
    }

    public Car getCarById(int carId) {
        String sql="SELECT car_id,car_name,brand,model,fuel_type,price_per_day,status,image_data,image_content_type FROM cars WHERE car_id=?";
        try(Connection con=DBConnection.getConnection(); PreparedStatement ps=con.prepareStatement(sql)){
            ps.setInt(1,carId);
            try(ResultSet rs=ps.executeQuery()){return rs.next()?map(rs):null;}
        } catch(Exception e){e.printStackTrace();return null;}
    }
}
