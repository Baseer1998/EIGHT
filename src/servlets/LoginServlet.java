package com.voidmain.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Hibernate;

import com.voidmain.dao.DAO;
import com.voidmain.pojo.Family;
import com.voidmain.pojo.InsuranceCompany;
import com.voidmain.pojo.Patient;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String username=request.getParameter("username").trim();
		String password=request.getParameter("password").trim();
		
		if(username.equals("admin") && password.equals("admin"))
		{
			response.sendRedirect("adminhome.jsp");
		}
		else
		{
			if(DAO.isValidUser(username, password))
			{
				request.getSession().setAttribute("username",username.toLowerCase());
				request.getSession().setAttribute("role","hospital");
				response.sendRedirect("hospitalhome.jsp");
			}
			else
			{
				if(DAO.isValidPatinet(username, password))
				{
					request.getSession().setAttribute("username",username.toLowerCase());
					request.getSession().setAttribute("role","patient");
					response.sendRedirect("patienthome.jsp");
				}
				else
				{
					if(DAO.isValidFamily(username, password))
					{
						request.getSession().setAttribute("username",username.toLowerCase());
						request.getSession().setAttribute("role","family");
						
						Family family=DAO.getFamilyById(username);
						
						request.getSession().setAttribute("patientid",family.getPatientid());
						response.sendRedirect("familyhome.jsp");
					}
					else if(DAO.isValidInsurance(username, password))
					{
						request.getSession().setAttribute("username",username.toLowerCase());
						request.getSession().setAttribute("role","insurance");
						
						response.sendRedirect("insurancehome.jsp");
					}
					else
					{
						response.sendRedirect("index.jsp?status=Invalid Username and Password");
					}
				}
			}
		}
	}
}
