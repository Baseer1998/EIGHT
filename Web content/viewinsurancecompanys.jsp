<!DOCTYPE HTML>
<%@page import="com.voidmain.pojo.InsuranceCompany"%>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="com.voidmain.pojo.Hospital"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<html>

<head>
<title>Hospital</title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type"
	content="text/html; charset=windows-1252" />
<link rel="stylesheet" type="text/css" href="style/style.css" />

</head>

<body>
	<div id="main">
		<div id="header">
			<div id="logo">
				<div id="logo_text">
					<br /> <br /> <font size="5"><a href="index.html"><span
							class="logo_colour">Secure Patient Data Sharing</span></a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">

					<li class="selected"><a href="adminhome.jsp">Home</a></li>
					<li><a href="addteam.jsp">Add Teams</a></li>
					<li><a href="viewteams.jsp">View Teams</a></li>
					<li><a href="logout.jsp">Logout</a></li>

				</ul>
			</div>
		</div>
		<div id="content_header"></div>
		<div id="site_content">
			<div id="sidebar_container">
				<br /> <br /> <br /> <br />
				<div class="sidebar">
					<div class="sidebar_top"></div>
					<div class="sidebar_item">
						<h3>Useful Links</h3>
						<ul>
							<li class="selected"><a href="adminhome.jsp">Home</a></li>
							<li><a href="viewinsurancecompanys.jsp">Insurance Companys</a></li>
							<li><a href="addteam.jsp">Add Teams</a></li>
							<li><a href="viewteams.jsp">View Teams</a></li>
							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">
				
				<br/><br/><br/><br/>
				<table style="width: 100%; border-spacing: 0;">
					<tr>
						<th>Insurance ID</th>
						<th>Name</th>
						<th>Email</th>
						<th>Mobile</th>
						<th>Address</th>
						<th>Status</th>
						<th>Activate</th>
						<th>De-Activate</th>
						
					</tr>
					<%
						List<InsuranceCompany> insurances=DAO.getInsuranceCompanys();
					
						for(InsuranceCompany insuranceCompany : insurances)
						{
					%>
					<tr>
						<td><%=insuranceCompany.getUserName()%></td>
						<td><%=insuranceCompany.getName()%></td>
						<td><%=insuranceCompany.getEmail()%></td>
						<td><%=insuranceCompany.getMobile()%></td>
						<td><%=insuranceCompany.getAddress()%></td>
						<td><%=insuranceCompany.getStatus()%></td>
						<td> <a href="viewinsurancecompanys.jsp?insuranceId=<%=insuranceCompany.getUserName()%>&action=yes">Activate</a></td>
						<td> <a href="viewinsurancecompanys.jsp?insuranceId=<%=insuranceCompany.getUserName()%>&action=no">De-Activate</a></td>
					</tr>
					<%
						}
					%>
				</table>
				
				<%
					String action=request.getParameter("action");
					String insuranceId=request.getParameter("insuranceId");
					
					if(action!=null && insuranceId!=null)
					{
						InsuranceCompany insuranceCompany=DAO.getInsuranceCompanyById(insuranceId);
						insuranceCompany.setStatus(action);
						
						if(HibernateTemplate.updateObject(insuranceCompany)==1)
						{
							response.sendRedirect("viewinsurancecompanys.jsp?status=success");
						}
						else
						{
							response.sendRedirect("viewinsurancecompanys.jsp?status=failed");
						}
						
					}
				%>
			</div>
		</div>
		<br /> <br /> <br /> <br />
		<div id="content_footer"></div>
		<div id="footer">
			<p>Copyright &copy; Voidmain Technologies</p>
		</div>
	</div>
</body>
</html>
