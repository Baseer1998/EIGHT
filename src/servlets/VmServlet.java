package com.voidmain.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.voidmain.dao.DAO;
import com.voidmain.dao.HibernateTemplate;
import com.voidmain.pojo.Block;
import com.voidmain.pojo.BlockChain;
import com.voidmain.pojo.Family;
import com.voidmain.pojo.Hospital;
import com.voidmain.pojo.InsuranceCompany;
import com.voidmain.pojo.Patient;
import com.voidmain.pojo.Team;
import com.voidmain.pojo.Transaction;
import com.voidmain.pojo.Treatment;
import com.voidmain.service.AppService;

@WebServlet("/VoidmainServlet")
public class VoidmainServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	HttpServletRequest request;
	HttpServletResponse response;
	
	Class c=null;
	Object obj=null;
	String redirect=null;
	String type;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.request=request;
		this.response=response;
		
		try {
			
			String operation=request.getParameter("operation");
			type=request.getParameter("type");
			redirect=request.getParameter("redirect");
			
			System.out.println(operation+"\t"+type+"\t"+redirect);
			
			if(type!=null && operation!=null && redirect!=null)
			{
				if(type.equals("Hospital"))
				{
					c=Hospital.class;
					
				}else if(type.equals("Patient"))
				{
					c=Patient.class;
				}else if(type.equals("Team"))
				{
					c=Team.class;
				}else if(type.equals("Transaction"))
				{
					c=Transaction.class;
				}else if(type.equals("Treatment"))
				{
					c=Treatment.class;
				}
				else if(type.equals("Family"))
				{
					c=Family.class;
				}
				else if(type.equals("InsuranceCompany"))
				{
					c=InsuranceCompany.class;
				}
				
				//======================================================
				
				obj=c.newInstance();
				
				//======================================================
				
				if(operation.equals("add"))
				{
					addObject();
				}
				else if(operation.equals("update"))
				{
					updateObject();
				}
				else if(operation.equals("delete"))
				{
					deleteObject();
					
				}
				
			}
		
			//======================================================
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}
	
	public void addObject() throws Exception
	{	
		if(type.equals("Treatment"))
		{
			try {
				
				String patientId=request.getParameter("patientId");
				
				System.out.println("suggession :\t"+request.getParameter("suggession"));
				
				Block one = new Block(request.getParameter("disease"),0);
		        Block two = new Block(request.getParameter("suggession"),one.getHash());
		        Block three = new Block(request.getParameter("medication"),two.getHash());
		        
		        BlockChain blockChain=new BlockChain();
		      
		        HibernateTemplate.addObject(one);
		        blockChain.setOne(DAO.getBlocks().size());
		        
		        HibernateTemplate.addObject(two);
		        blockChain.setTwo(DAO.getBlocks().size());
		        
		        HibernateTemplate.addObject(three);
		        blockChain.setThree(DAO.getBlocks().size());
		       
		        HibernateTemplate.addObject(blockChain);
		        
		        Treatment treatment=new Treatment();
		        treatment.setBlockChainId(DAO.getBlockChains().size());
		        treatment.setPatientId(patientId);
		        
		        HibernateTemplate.addObject(treatment);
		        
		        response.sendRedirect(redirect+"?status=success");
		        
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else
		{
			Object object=HttpRequestParser.parseRequest(request, obj);
			
			if(type.equals("Patient"))
			{
				Patient patient=(Patient)object;
				
				String password=AppService.getGeneratedPassword();
				patient.setPassword(password);
				
				AppService.mailsend("Your User ID: "+patient.getPatientId()+" and Password is "+password,"From Patient Security",patient.getPatientId());
				
				System.out.println(patient);
				
				if(HibernateTemplate.addObject(patient)==1)
				{
					System.out.println("in if");
					
					response.sendRedirect(redirect+"?status=success");
				}
				else
				{
					response.sendRedirect(redirect+"?status=failed");
				}
				
			}
			else
			{
				System.out.println(object.getClass());
				
				if(HibernateTemplate.addObject(object)==1)
				{
					response.sendRedirect(redirect+"?status=success");
				}
				else
				{
					response.sendRedirect(redirect+"?status=failed");
				}
			}
		}
	}
	
	public void deleteObject() throws Exception
	{
		if(HibernateTemplate.deleteObject(c,Integer.parseInt(request.getParameter("userId")))==1)
		{
			response.sendRedirect(redirect+"?status=success");
		}
		else
		{
			response.sendRedirect(redirect+"?status=failed");
		}
	}
	
	public void updateObject() throws Exception
	{
		Object object=HttpRequestParser.parseRequest(request,obj);
		
		if(HibernateTemplate.updateObject(object)==1)
		{
			response.sendRedirect(redirect+"?status=success");
		}
		else
		{
			response.sendRedirect(redirect+"?status=failed");
		}
	}
}
