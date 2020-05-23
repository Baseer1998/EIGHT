<!DOCTYPE HTML>
<%@page import="com.voidmain.service.BlockChainService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.voidmain.pojo.Block"%>
<%@page import="com.voidmain.pojo.BlockChain"%>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.DAO"%>
<%@page import="com.voidmain.pojo.Treatment"%>
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
							class="logo_colour">Secure Family Data Sharing</span></a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">

					<li class="selected"><a href="familyhome.jsp">Home</a></li>
					
					<%
						String role=(String)request.getSession().getAttribute("role");
							
						if(role.equals("family"))
						{
					%>
							<li><a href="viewrequest.jsp">View Requests</a></li>
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
							<li class="selected"><a href="familyhome.jsp">Home</a></li>
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
						String username = session.getAttribute("username").toString();
						String patientid = session.getAttribute("patientid").toString();
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
					<h3>View Treatments</h3> of <%=patientid%>
					<%
						}
					%>

					<br /> <br /> <br /> <br />
					<table style="width: 100%; border-spacing: 0;">

						<tr>
							<th>Treatment ID</th>
							<th>Patient ID</th>
							<th>Disease</th>
							<th>Suggestion</th>
							<th>Medicine</th>
							<th>View Document</th>

						</tr>
						<%
							if(username!=null && patientid!=null)
							{		
								List<Treatment> treatments = DAO.getTreatments();

								for (Treatment treatment : treatments) {
									
									if (treatment.getPatientId().equals(patientid)) {
									
										List<BlockChain> blockChains=DAO.getBlockChains();
										
										for (BlockChain blockChain : blockChains) {
											
											if(blockChain.getBlockChainId()==treatment.getBlockChainId()){
												
												int blockId1=blockChain.getOne();
												int blockId2=blockChain.getTwo();
												int blockId3=blockChain.getThree();
												
												Block b1=DAO.getBlockById(blockId1);
												Block b2=DAO.getBlockById(blockId2);
												Block b3=DAO.getBlockById(blockId3);
												
												List<Block> blockList=new ArrayList<Block>();
												
												blockList.add(b1);
												blockList.add(b2);
												blockList.add(b3);
												
												System.out.println("b1-->"+b1);
												System.out.println("b2-->"+b2);
												System.out.println("b3-->"+b3);
												
												boolean isValid=BlockChainService.validate(blockList);
												
												System.out.println("block chain validation \t"+isValid);
												
												if(isValid)
												{
												
						%>
												<tr>
													<td><%=treatment.getTreatmentId()%></td>
													<td><%=treatment.getPatientId()%></td>
													<td><%=b1.getData()%></td>
													<td><%=b2.getData()%></td>
													<td><%=b3.getData()%></td>
													<td> <a href="viewdocument.jsp?treatmentid=<%=treatment.getTreatmentId()%>">View document</a> </td>
												</tr>
												<%
												
												}
											}
										}
									}
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
