<!DOCTYPE HTML>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="java.util.List"%>
<%@page import="com.voidmain.pojo.Hospital"%>
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
					String treatmentid=request.getParameter("treatmentid");
					
					if (status != null) {
				%>
				<h3> <%=status%> </h3>
				<%
					} else {
				%>
				<h3>Add Treatment</h3>
				<%
					}
				%>
				
				<%
					if(treatmentid!=null)
					{
				%>

				<div class="form_settings">

					<form action="UploadDocumentServlet" method="post" enctype="multipart/form-data">
						
						<input type="hidden" name="redirect" value="uploaddocument.jsp">
						
						<input type="hidden" name="treatmentid" value="<%=treatmentid%>">
						
						<p>
							<span>Description</span><input class="contact" type="text"
								name="suggession" id="suggession" />
						</p>
						<p>
							<span>Upload</span><input class="contact" type="file"
								name="document" id="document" />
						</p>
						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Upload" />
						</p>
					</form>

				</div>
				
				<%
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
