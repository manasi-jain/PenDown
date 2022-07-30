package com.Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.UserDAO;
import com.DB.DBConnect;
import com.User.UserDetails;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		UserDetails us = new UserDetails();
		us.setEmail(email);
		us.setPassword(password);
		
		UserDAO dao = new UserDAO(DBConnect.getConn());
		UserDetails user = dao.loginUser(us);
		
		if(user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("userDetails", user);
			response.sendRedirect("main.jsp");
		}
		else {
			HttpSession session = request.getSession();
			session.setAttribute("login-failed", "Invalid username or password");
			response.sendRedirect("login.jsp");
		}
		
	}

}
