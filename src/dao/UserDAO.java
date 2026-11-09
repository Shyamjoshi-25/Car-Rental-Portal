package dao;

import model.User;
import util.DBConnection;
import util.PasswordHash;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public int register(User user) {
        String checkSql = "SELECT user_id FROM users WHERE LOWER(email)=LOWER(?)";
        String sql="INSERT INTO users(full_name,email,phone,address,password) VALUES(?,?,?,?,?)";
        try(Connection con=DBConnection.getConnection();
            PreparedStatement check=con.prepareStatement(checkSql);
            PreparedStatement ps=con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            check.setString(1, user.getEmail());
            try(ResultSet existing = check.executeQuery()) {
                if (existing.next()) return -2;
            }
            ps.setString(1,user.getFullName());
            ps.setString(2,user.getEmail().trim().toLowerCase());
            ps.setString(3,user.getPhone());
            ps.setString(4,user.getAddress());
            ps.setString(5,PasswordHash.hash(user.getPassword()));
            if(ps.executeUpdate()==0)return -1;
            try(ResultSet rs=ps.getGeneratedKeys()){return rs.next()?rs.getInt(1):-1;}
        }catch(SQLException e){e.printStackTrace();return -1;}
    }

    public User getUser(String email,String password){
        String sql="SELECT user_id,full_name,email,phone,address,password,profile_photo FROM users WHERE email=?";
        try(Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(sql)){
            ps.setString(1,email.trim().toLowerCase());
            try(ResultSet rs=ps.executeQuery()){
                if(!rs.next())return null;
                String stored = rs.getString("password");
                boolean valid = PasswordHash.isHashed(stored)
                        ? PasswordHash.verify(password, stored)
                        : password.equals(stored); // one-time migration for older demo data
                if(!valid)return null;

                if(!PasswordHash.isHashed(stored)) {
                    try (PreparedStatement upgrade = con.prepareStatement(
                            "UPDATE users SET password=? WHERE user_id=?")) {
                        upgrade.setString(1, PasswordHash.hash(password));
                        upgrade.setInt(2, rs.getInt("user_id"));
                        upgrade.executeUpdate();
                    }
                }
                return map(rs);
            }
        } catch(SQLException e){e.printStackTrace();return null;}
    }

    public boolean updateProfile(User user){
        String sql="UPDATE users SET full_name=?,phone=?,address=? WHERE user_id=?";
        try(Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(sql)){
            ps.setString(1,user.getFullName());
            ps.setString(2,user.getPhone());
            ps.setString(3,user.getAddress());
            ps.setInt(4,user.getUserId());
            return ps.executeUpdate()==1;
        }catch(SQLException e){e.printStackTrace();return false;}
    }

    public boolean updateProfilePhoto(int userId, byte[] photo) {
        String sql="UPDATE users SET profile_photo=? WHERE user_id=?";
        try(Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(sql)){
            ps.setBytes(1, photo);
            ps.setInt(2, userId);
            return ps.executeUpdate()==1;
        } catch(SQLException e){e.printStackTrace();return false;}
    }

    public byte[] getProfilePhoto(int userId) {
        String sql="SELECT profile_photo FROM users WHERE user_id=?";
        try(Connection con=DBConnection.getConnection();
            PreparedStatement ps=con.prepareStatement(sql)){
            ps.setInt(1,userId);
            try(ResultSet rs=ps.executeQuery()){
                if(rs.next()) return rs.getBytes("profile_photo");
            }
        } catch(SQLException e){e.printStackTrace();}
        return null;
    }

    public List<User> getAllUsers(){
        List<User> list=new ArrayList<>();
        String sql="SELECT user_id,full_name,email,phone,address,password,profile_photo FROM users ORDER BY user_id";
        try(Connection c=DBConnection.getConnection();
            PreparedStatement p=c.prepareStatement(sql);
            ResultSet r=p.executeQuery()){
            while(r.next())list.add(map(r));
        }catch(SQLException e){e.printStackTrace();}
        return list;
    }

    public boolean deleteUser(int userId){
        String sql="DELETE FROM users WHERE user_id=?";
        try(Connection c=DBConnection.getConnection();
            PreparedStatement p=c.prepareStatement(sql)){
            p.setInt(1,userId);
            return p.executeUpdate()==1;
        }catch(SQLException e){e.printStackTrace();return false;}
    }

    private User map(ResultSet rs)throws SQLException{
        User u=new User();
        u.setUserId(rs.getInt("user_id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        // Password is never placed in the session/user model after authentication.
        u.setPassword(null);
        u.setProfilePhoto(rs.getBytes("profile_photo"));
        return u;
    }
}
