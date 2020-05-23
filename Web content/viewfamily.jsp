<!DOCTYPE HTML>
<%@page import="com.voidmain.pojo.Family"%>
<%@page import="com.voidmain.pojo.Transaction"%>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="com.voidmain.pojo.Patient"%>
<%@page import="java.util.List"%>
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

					<li class="selected"><a href="patienthome.jsp">Home</a></li>
					
					<%
						String role=(String)request.getSession().getAttribute("role");
							
						if(role.equals("patient"))
						{
					%>
							<li><a href="viewrequest.jsp">View Requests</a></li>
					<%		
						}
					%>
					
					<li class="selected"><a href="addfamily.jsp">Add Family</a></li>
					<li class="selected"><a href="viewfamily.jsp">View Family</a></li>
					
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
							<li class="selected"><a href="patienthome.jsp">Home</a></li>
					
								<%	
									if(role.equals("patient"))
									{
								%>
										<li><a href="viewrequest.jsp">View Requests</a></li>
								<%		
									}
								%>
								
								<li class="selected"><a href="addfamily.jsp">Add Family</a></li>
								<li class="selected"><a href="viewfamily.jsp">View Family</a></li>
								
								<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">
				<div class="form_settings">

					<%
						String username = session.getAttribute("username").toString();
					%>
					<%
						String status = request.getParameter("status");

						if (status != null) {
					%>
					<h3>
						<%=status%>
					</h3>
					<%
						} else {
					%>
					<h3>View Family</h3>
					<%
						}
					%>

					<br /> <br /> <br /> <br />
					<table style="width: 100%; border-spacing: 0;">

						<tr>
							<th>Name</th>
							<th>User Name</th>
							<th>Email</th>
							<th>Mobile</th>
							<th>Address</th>
							<th>Relaton</th>
							<th>Delete</th>

						</tr>
						<%
							List<Family> familys = DAO.getFamilys();

							for (Family family : familys) {
								
								if (family.getPatientid().equals(username)) {
						%>
						<tr>
							<td><%=family.getName()%></td>
							<td><%=family.getUsername()%></td>
							<td><%=family.getEmail()%></td>
							<td><%=family.getMobile()%></td>
							<td><%=family.getAddress()%></td>
							<td><%=family.getRelation()%></td>
							<td><a href="viewfamily.jsp?familyId=<%=family.getUsername()%>">Delete</a></td>
						</tr>
						<%
							}
							}
						%>
					</table>

					<%
						String familyId = request.getParameter("familyId");

						if (familyId != null) {
							if (HibernateTemplate.deleteObject(Family.class,familyId) == 1) {
								response.sendRedirect("viewfamily.jsp?status=success");
							} else {
								response.sendRedirect("viewfamily.jsp?status=failed");
							}

						}
					%>

				</div>
			</div>
		</div>
		<br /> <br /> <br /> <br /> <br />
		<div id="content_footer"></div>
		<div id="footer">
			<p>Copyright &copy; Voidmain Technologies</p>
		</div>
	</div>
</body>
</html>
