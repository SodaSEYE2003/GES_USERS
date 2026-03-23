package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.User;

public class UserDao {
	private static String jdbcURL= "jdbc:mysql://localhost:3307/users_db?useSSL=false&serverTimezone=UTC";
	private static String jdbcUsername= "root";
	private static String jdbcPassword= "";
	
	private static final String INSERT_USERS_SQL= "INSERT INTO users" + " (nom, prenom, login, password) VALUES "
			+ "(?, ?, ?, ?);";
	private static final String SELECT_USER_BY_ID= "SELECT id,nom,prenom,login,password from users where id=?;";
	private static final String SELECT_ALL_USERS= "SELECT * from users;";
	private static final String DELETE_USERS_SQL= "DELETE from users where id=?;";
	private static final String UPDATE_USERS_SQL= "UPDATE users set nom=?, prenom=?, login=?, password=? where id=?;";

	protected static Connection getConnection()  {
		Connection connection = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch(ClassNotFoundException e){
			e.printStackTrace();
		}
		return connection;
	}
    //CREATE OR INSERT USER
		public static void insertUser(User user) throws SQLException {
			try(Connection connection = getConnection();
					PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL)){
				preparedStatement.setString(1, user.getNom());
				preparedStatement.setString(2, user.getPrenom());
				preparedStatement.setString(3, user.getLogin());
				preparedStatement.setString(4, user.getPassword());
				preparedStatement.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
			} 
		}
	//UPDATE USER
		public static boolean updateUser(User user) throws SQLException {
			boolean rowUpdated =false;
			try(Connection connection = getConnection();
					PreparedStatement statement = connection.prepareStatement(UPDATE_USERS_SQL)){
				statement.setString(1, user.getNom());
				statement.setString(2, user.getPrenom());
				statement.setString(3, user.getLogin());
				statement.setString(4, user.getPassword());
				statement.setInt(5, user.getId());
				
				rowUpdated = statement.executeUpdate() >0 ;
				
			}
			return rowUpdated;
		}
	//SELECT USER BY ID
		public User selectUser(int id){
			User user = null;
			//Step 1: Establishing a Connection
			try(Connection connection = getConnection();
					//Step 2: Create a statement using connection object
					PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID)){
				preparedStatement.setInt(1, id);
				System.out.println(preparedStatement);
				
				//Step 3: Execute the query or update query
				ResultSet rs = preparedStatement.executeQuery();
				
				//Step 4: Process the ResultSet object
				while(rs.next()) {
					String nom = rs.getString("nom");
					String prenom = rs.getString("prenom");
					String login = rs.getString("login");
					String password = rs.getString("password");
					user= new User(id, nom, prenom, login,  password);
				}
			}catch(Exception e){
				e.printStackTrace();
			} 
			return user;
		}
	//SELECT USERS
		public List<User> selectAllUsers(){
			List<User> users = new ArrayList<>();
			//Step 1: Establishing a Connection
			try(Connection connection = getConnection();
					//Step 2: Create a statement using connection object
					PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS)){
				System.out.println(preparedStatement);
				
				//Step 3: Execute the query or update query
				ResultSet rs = preparedStatement.executeQuery();
				
				//Step 4: Process the ResultSet object
				while(rs.next()) {
					int id = rs.getInt("id");
					String nom = rs.getString("nom");
					String prenom = rs.getString("prenom");
					String login = rs.getString("login");
					String password = rs.getString("password");
					users.add(new User(id, nom, prenom, login,  password));
				}
			}catch(Exception e){
				e.printStackTrace();
			} 
			return users;
		}
	//DELETE USER
		public static boolean deleteUser(int id)throws SQLException{
			boolean rowDeleted;
			//Step 1: Establishing a Connection
			try(Connection connection = getConnection();
					//Step 2: Create a statement using connection object
					PreparedStatement statement = connection.prepareStatement(DELETE_USERS_SQL)){
				statement.setInt(1, id);
				rowDeleted = statement.executeUpdate() > 0;
			} 
			return rowDeleted;
		}
	// FIND USER BY LOGIN AND PASSWORD
		public User findByLoginAndPassword(String login, String password) {
		    User user = null;
		    String sql = "SELECT * FROM users WHERE login=? AND password=?";
		    try(Connection connection = getConnection();
		            PreparedStatement preparedStatement = connection.prepareStatement(sql)){
		        preparedStatement.setString(1, login);
		        preparedStatement.setString(2, password);
		        ResultSet rs = preparedStatement.executeQuery();
		        while(rs.next()) {
		            int id = rs.getInt("id");
		            String nom = rs.getString("nom");
		            String prenom = rs.getString("prenom");
		            user = new User(id, nom, prenom, login, password);
		        }
		    } catch(Exception e){
		        e.printStackTrace();
		    }
		    return user;
		}
}
