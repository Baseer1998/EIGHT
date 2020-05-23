<!DOCTYPE HTML>
<%@page import="java.util.Date"%>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="java.util.List"%>
<%@page import="com.voidmain.pojo.Patient"%>
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
					<!-- put class="selected" in the li tag for the selected page - to highlight which page you're on -->
					<li class="selected"><a href="hospitalhome.jsp">Home</a></li>
					<li><a href="sendrequest.jsp">Send Requests</a></li>
					<%
						String role=(String)request.getSession().getAttribute("role");
							
						if(role.equals("patient"))
						{
					%>
							<li><a href="viewrequest.jsp">View Requests</a></li>
					<%		
						}
					%>
					<li><a href="viewrequestedpatients.jsp">View Requested Patients</a></li>
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
							<li class="selected"><a href="hospitalhome.jsp">Home</a></li>
							<li><a href="sendrequest.jsp">Send Requests</a></li>
							<li><a href="viewrequest.jsp">View Requests</a></li>
							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">

				<%
					String status=request.getParameter("status");
					String patientId=request.getParameter("patientId");
					String username=(String)request.getSession().getAttribute("username");		
					
					
					if (status != null) {
				%>
				<h3> <%=status%> </h3>
				<%
					} else {
				%>
				<h3>Send Request</h3>
				<%
					}
				%>

				<div class="form_settings">

					<form action="VoidmainServlet" method="post">
						
						<input type="hidden" name="operation" value="add"> 
						<input type="hidden" name="type" value="Transaction"> 
						<input type="hidden" name="redirect" value="sendrequest.jsp">
						
						<input type="hidden" name="requestedHospital" value="<%=username%>">
						<input type="hidden" name="date" value="<%=new Date().toString()%>">
						<input type="hidden" name="status" value="sent">
						
						<p>
							
							<span>Select Patient</span>
							
							<select name="patientId">
							
							<%
								List<Patient> patients=DAO.getPatients();
							
								for(Patient patient : patients)
								{
									System.out.println(patient);
									
									String patientHospital=DAO.getHospitalById(DAO.getTeamById(patient.getTeamId()).getHospitalid()).getName();
									
									if(!patientHospital.equals(username))
									{
							%>
									<option value="<%=patient.getPatientId()%>"><%=patient.getPatientId()%>-<%=patientHospital%></option>
							<%
									}
								}
							%>
		
							</select>
							
						</p>
						
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Send Request" />
						</p>
						
					</form>

				</div>
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
