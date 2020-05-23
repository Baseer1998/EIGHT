<!DOCTYPE HTML>
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
					<li class="selected"><a href="index.jsp">Home</a></li>
					<li><a href="registration.jsp">Hospital Registration</a></li>
					<li><a href="insuranceregistration.jsp">Insurance Company Registration</a></li>
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
							<li class="selected"><a href="index.jsp">Home</a></li>
							<li><a href="registration.jsp">Hospital Registration</a></li>
							<li><a href="insuranceregistration.jsp">Insurance Company Registration</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">

				<%
					String status=request.getParameter("status");
					
					if (status != null) {
				%>
				<h3> <%=status%> </h3>
				<%
					} else {
				%>
				<h3>Insurance Company Registration</h3>
				<%
					}
				%>

				<div class="form_settings">

					<form action="VoidmainServlet" method="post">
						
						<input type="hidden" name="operation" value="add"> 
						<input type="hidden" name="type" value="InsuranceCompany"> 
						<input type="hidden" name="redirect" value="insuranceregistration.jsp">
						
						<p>
							<span>Company Name</span><input class="contact" type="text"
								name="name" id="name" />
						</p>
						<p>
							<span>User Name</span><input class="contact" type="text"
								name="userName" id="userName" />
						</p>
						<p>
							<span>Password</span><input class="contact" type="password"
								name="password" id="password" />
						</p>
						<p>
							<span>E-Mail</span><input class="contact" type="text"
								name="email" id="mail" />
						</p>
						<p>
							<span>Mobile</span><input class="contact" type="text"
								name="mobile" id="mobile" />
						</p>
						<p>
							<span>Address</span><input class="contact" type="text"
								name="address" id="address" />
						</p>

						<p style="padding-top: 15px">
							<span>&nbsp;</span><input class="submit" type="submit"
								name="contact_submitted" value="Register" />
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
