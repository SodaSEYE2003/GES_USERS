package servlets;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import beans.User;
import dao.UserDao;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        this.userDao = new UserDao();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
	        String login = request.getParameter("login");
	        String password = request.getParameter("password");

	        User user = userDao.findByLoginAndPassword(login, password);

	        if(user != null) {
	            // Credentials corrects => créer la session
	            HttpSession session = request.getSession();
	            session.setAttribute("userConnecte", user);
	            response.sendRedirect("list");
	        } else {
	            // Credentials incorrects => retour login avec erreur
	            request.setAttribute("error", "Login ou mot de passe incorrect");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
	            dispatcher.forward(request, response);
	        }
	    }
	}
