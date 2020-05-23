<!DOCTYPE HTML>
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

					<li class="selected"><a href="insurancehome.jsp">Home</a></li>
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
							
							<li class="selected"><a href="insurancehome.jsp">Home</a></li>
							<li><a href="logout.jsp">Logout</a></li>
							
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">
				<div class="form_settings">
					
					<h3>View Patients</h3>

					<br /> <br /> <br /> <br />
					<table style="width: 100%; border-spacing: 0;">

						<tr>
							
							<th>Patient ID</th>
							<th>Name</th>
							<th>Age</th>
							<th>Gender</th>
							<th>Mobile</th>
							<th>Address</th>

						</tr>
						<%
							List<Patient> patients = DAO.getPatients();

							for (Patient patient : patients) {
								
						%>
						<tr>
							<td><%=patient.getPatientId()%></td>
							<td><%=patient.getName()%></td>
							<td><%=patient.getAge()%></td>
							<td><%=patient.getGender()%></td>
							<td><%=patient.getPhone()%></td>
							<td><%=patient.getAddress()%></td>
							
						</tr>
						<%
							}
						%>
					</table>
					
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
