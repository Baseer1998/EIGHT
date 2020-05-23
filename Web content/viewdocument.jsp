<!DOCTYPE HTML>
<%@page import="com.voidmain.pojo.PatientDocument"%>
<%@page import="com.voidmain.pojo.Transaction"%>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="com.voidmain.pojo.PatientDocument"%>
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
							class="logo_colour">Secure patientDocumentDocument Data Sharing</span></a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">

					<%
						String role=(String)request.getSession().getAttribute("role");
							
						if(role.equals("patient"))
						{
					%>
							<li class="selected"><a href="patienthome.jsp">Home</a></li>
							<li><a href="viewrequest.jsp">View Requests</a></li>
					<%		
						}
						else if(role.equals("family"))
						{
					%>
							<li class="selected"><a href="familyhome.jsp">Home</a></li>
							<li><a href="viewrequest.jsp">View Requests</a></li>
					<%		
						}
						else
						{
					%>
							<li class="selected"><a href="hospitalhome.jsp">Home</a></li>
							<li><a href="sendrequest.jsp">Send Requests</a></li>
							<li><a href="viewrequestedpatients.jsp">View Requested Patients</a></li>
					<%	
						}
					%>
					
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
						    <%
								if(role.equals("patient"))
								{
							%>
									<li class="selected"><a href="patienthome.jsp">Home</a></li>
									<li><a href="viewrequest.jsp">View Requests</a></li>
							<%		
								}else if(role.equals("family"))
								{
									%>
											<li class="selected"><a href="familyhome.jsp">Home</a></li>
											<li><a href="viewrequest.jsp">View Requests</a></li>
									<%		
								}
								else
								{
							%>
									<li class="selected"><a href="hospitalhome.jsp">Home</a></li>
									<li><a href="sendrequest.jsp">Send Requests</a></li>
									<li><a href="viewrequestedpatients.jsp">View Requested patients</a></li>
							<%	
								}
							%>
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
						String treatmentid = request.getParameter("treatmentid");
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
					<h3>View patientDocumentDocuments</h3>
					<%
						}
					%>

					<br /> <br /> <br /> <br />
					<table style="width: 100%; border-spacing: 0;">

						<tr>
							<th>Document ID</th>
							<th>Treatment ID</th>
							<th>Download</th>

						</tr>
						<%
							List<PatientDocument> patientDocuments = DAO.getPatientDocuments();

							for (PatientDocument patientDocument : patientDocuments) {

								if (patientDocument.getTreatmentId() == Integer.parseInt(treatmentid)) {
						%>
						<tr>
							<td><%=patientDocument.getDocumentId()%></td>
							<td><%=patientDocument.getTreatmentId()%></td>
							<td><a href="DownloadServlet?filename=<%=patientDocument.getDocumentName()%>">Download</a></td>
						</tr>
						<%
								}
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
