/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.voidmain.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import com.voidmain.dao.HibernateTemplate;
import com.voidmain.pojo.PatientDocument;
import com.voidmain.service.*;
import com.voidmain.util.Constants;

@WebServlet("/UploadDocumentServlet")
public class UploadDocumentServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String treatmentId="";
		String uploadFilename = "";

		boolean isUploaded = false;

		// Check that we have a file upload request
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if(isMultipart) {
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();

			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);

			try {

				// Parse the request
				List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));

				for (int i=0;i<items.size();i++)
				{
					// processes only fields that are not form fields

					FileItem item=items.get(i);

					if (!item.isFormField()) {
					
						uploadFilename = item.getName();

						System.out.println("file name is :"+uploadFilename);

						try {
							File savedFile = new File(Constants.FILES_PATH+uploadFilename);
							item.write(savedFile);
							isUploaded = true;
						} catch(Exception e) {
							e.printStackTrace();
							isUploaded = false;
						}						
					}
					else
					{
						String fieldname = item.getFieldName();
						String fieldvalue = item.getString();

						if (fieldname.equals("treatmentid")) {
							treatmentId=fieldvalue;
						}
					}
				}
			}//try
			catch (FileUploadException e) {
				e.printStackTrace();
			} 

			if(isUploaded){

				SimpleFTPClient client=new SimpleFTPClient();
				
				client = new SimpleFTPClient();
				client.setHost("ftp.drivehq.com");
				client.setUser("liveieee");
				client.setPassword("Nagasrinu");
				client.setRemoteFile(uploadFilename);
				
				FileInputStream fis=new FileInputStream(Constants.FILES_PATH+uploadFilename);
				FileOutputStream fos=new FileOutputStream(Constants.ENCRYPTION_PATH+uploadFilename);
				
				boolean isCloudConnected = client.connect();
				
				if(isCloudConnected)
				{
					try {
						
						SimpleFTPClient.encrypt(fis,fos);
						
						if(client.uploadFile(new FileInputStream(Constants.ENCRYPTION_PATH+uploadFilename)))
						{
							
							PatientDocument patientDocument=new PatientDocument();
							patientDocument.setTreatmentId(Integer.parseInt(treatmentId));
							patientDocument.setDocumentName(uploadFilename);
							
							if(HibernateTemplate.addObject(patientDocument)==1)
							{
								response.sendRedirect("uploaddocument.jsp?status=Success");
							}
							else
							{
								response.sendRedirect("uploaddocument.jsp?status=failed");
							}
						}
						
					} catch (Throwable th) {
						
						th.printStackTrace();
					}
				}
			}
			else
			{
				response.sendRedirect("uploaddocument.jsp?status=failed");
			}
		}
	}
}
