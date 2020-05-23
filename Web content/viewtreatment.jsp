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
							class="logo_colour">Secure Patient Data Sharing</span></a></font>
				</div>
			</div>
			<div id="menubar">
				<ul id="menu">

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
				<div class="form_settings">

					<%
						String username = session.getAttribute("username").toString();
						String patientId = request.getParameter("patientId");
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
					<h3>View Treatments</h3>
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
							<%
								if(!role.equals("patient"))
								{
							%>
								<th>Upload Document</th>
													
							<%
								}
							%>
							
							<th>View Document</th>
							<th>Delete</th>

						</tr>
						<%
							if(patientId!=null)
							{
								System.out.println("in first 1");
										
								List<Treatment> treatments = DAO.getTreatments();

								for (Treatment treatment : treatments) {
									
									System.out.println("in for 1");
								
									System.out.println(treatment.getPatientId()+"\t"+patientId);

									if (treatment.getPatientId().equals(patientId)) {
										
										System.out.println("in if");
										
										List<BlockChain> blockChains=DAO.getBlockChains();
										
										for (BlockChain blockChain : blockChains) {
											
											System.out.println("in for");
											
											if(blockChain.getBlockChainId()==treatment.getBlockChainId()){
												
												System.out.println("block chain -->"+blockChain);
												
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
													<%
														if(!role.equals("patient"))
														{
													%>
													<td> <a href="uploaddocument.jsp?treatmentid=<%=treatment.getTreatmentId()%>">upload document</a> </td>
													
													<%
														}
													%>
													
													<td> <a href="viewdocument.jsp?treatmentid=<%=treatment.getTreatmentId()%>">View document</a> </td>
													<%
														String hospitalId=(DAO.getTeamById(DAO.getPatientById(patientId).getTeamId())).getHospitalid();
														
															if(hospitalId.equals(username))
															{
													%>
													
																<td><a href="viewtreatment.jsp?treatmentId=<%=treatment.getTreatmentId()%>">Delete</a></td>
													
						<%
															}
															else
															{
														%>
																<td><a href="#">No Access</a></td>
														<%		
																
															}
												%>
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

					<%
						String treatmentId = request.getParameter("treatmentId");

						if (treatmentId != null) {
							System.out.println("in if");
							if (HibernateTemplate.deleteObject(Treatment.class, Integer.parseInt(treatmentId)) == 1) {
								response.sendRedirect("hospitalhome.jsp?status=success");
							} else {
								response.sendRedirect("hospitalhome.jsp?status=failed");
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
