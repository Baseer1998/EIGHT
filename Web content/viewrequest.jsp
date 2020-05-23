<!DOCTYPE HTML>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="com.voidmain.pojo.Transaction"%>
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

					<%
						String role = (String) request.getSession().getAttribute("role");
					%>

					<%
						if (role.equals("patient")) {
					%>
					<li class="selected"><a href="patienthome.jsp">Home</a></li>
					<%
						}
					%>

					<%
						if (role.equals("family")) {
					%>
					<li class="selected"><a href="familyhome.jsp">Home</a></li>
					<%
						}
					%>

					<li><a href="viewrequest.jsp">View Requests</a></li>

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
								if (role.equals("patient")) {
							%>
							<li class="selected"><a href="patienthome.jsp">Home</a></li>
							<%
								}
							%>

							<%
								if (role.equals("family")) {
							%>
							<li class="selected"><a href="familyhome.jsp">Home</a></li>
							<%
								}
							%>

							<li><a href="viewrequest.jsp">View Requests</a></li>

							<li><a href="logout.jsp">Logout</a></li>
						</ul>
					</div>
					<div class="sidebar_base"></div>
				</div>
			</div>
			<div id="content">
				<div class="form_settings">

					<%
						String pusername = "";
						
						if(role.equals("patient"))
						{
							pusername=session.getAttribute("username").toString();
						}
						else if(role.equals("family"))
						{
							pusername=session.getAttribute("patientid").toString();
						}
					
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
					<h3>View Requests</h3>
					<%
						}
					%>

					<br /> <br /> <br /> <br />
					<table style="width: 100%; border-spacing: 0;">

						<tr>
							<th>Transaction ID</th>
							<th>Patient ID</th>
							<th>Requested Hospital</th>
							<th>Date</th>
							<th>Status</th>
							<th>Approve</th>
							<th>Reject</th>
							<%
								if (role.equals("patient")) {
							%>
							<th>Delete</th>
							<%
								}
							%>

						</tr>
						<%
							List<Transaction> transactions = DAO.getTransactions();

							for (Transaction transaction : transactions) {

								if (transaction.getPatientId().equals(pusername)) {
						%>
						<tr>
							<td><%=transaction.getTransactionId()%></td>
							<td><%=transaction.getPatientId()%></td>
							<td><%=transaction.getRequestedHospital()%></td>
							<td><%=transaction.getDate()%></td>
							<td><%=transaction.getStatus()%></td>
							<td><a
								href="viewrequest.jsp?transactionId=<%=transaction.getTransactionId()%>&reqstatus=approved">Approve</a></td>
							<td><a
								href="viewrequest.jsp?transactionId=<%=transaction.getTransactionId()%>&reqstatus=rejected">Reject</a></td>

							<%
								if (role.equals("patient")) {
							%>
							<td><a
								href="viewrequest.jsp?transactionId=<%=transaction.getTransactionId()%>&reqstatus=delete">Delete</a></td>
							<%
								}
							%>

						</tr>
						<%
							}

							}
						%>
					</table>

					<%
						String transactionId = request.getParameter("transactionId");
						String reqStatus = request.getParameter("reqstatus");

						if (transactionId != null && reqStatus != null) {

							if (reqStatus.equals("delete")) {
								if (HibernateTemplate.deleteObject(Transaction.class, Integer.parseInt(transactionId)) == 1) {
									response.sendRedirect("viewrequest.jsp?status=success");
								} else {
									response.sendRedirect("viewrequest.jsp?status=failed");
								}
							} else {
								Transaction transaction = DAO.getTransactionById(Integer.parseInt(transactionId));

								transaction.setStatus(reqStatus);

								if (HibernateTemplate.updateObject(transaction) == 1) {
									response.sendRedirect("viewrequest.jsp?status=success");
								} else {
									response.sendRedirect("viewrequest.jsp?status=failed");
								}
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
