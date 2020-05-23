<!DOCTYPE HTML>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="com.voidmain.pojo.Team"%>
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
						<th>Team ID</th>
						<th>Name</th>
						<th>Speciality</th>
						<th>Hospital</th>
						<th>Delete</th>
						
					</tr>
					<%
						List<Team> teams=DAO.getTeams();
					
						for(Team team : teams)
						{
					%>
					<tr>
						<td><%=team.getTeamId()%></td>
						<td><%=team.getName()%></td>
						<td><%=team.getSpeciality()%></td>
						<td><%=team.getHospitalid()%></td>
						<td> <a href="viewteams.jsp?teamId=<%=team.getTeamId()%>">delete</a></td>
					</tr>
					<%
						}
					%>
				</table>
				
				<%
					String teamId=request.getParameter("teamId");
					
					if(teamId!=null)
					{
						if(HibernateTemplate.deleteObject(Team.class,Integer.parseInt(teamId))==1)
						{
							response.sendRedirect("viewteams.jsp?status=success");
						}
						else
						{
							response.sendRedirect("viewteams.jsp?status=failed");
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
