package com.voidmain.service;

import java.net.*;
import java.io.*;

import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

public class SimpleFTPClient {

    /** The URL connection object */
    private URLConnection m_client;
    /** The FTP host/server to be connected */
    private String host;
    /** The FTP user */
    private String user;
    /** The FTP user’s password */
    private String password;
    /** The remote file that needs to be uploaded or downloaded */
    private String remoteFile;
    /** The previous error message triggered after a method is called */
    private String erMesg;
    /** The previous success message after any method is called */
    private String succMesg;
    
    static String mykey = "squirrel123"; // needs to be at least 8 characters for DES

    public SimpleFTPClient() {
    }

    /** Setter method for the FTP host/server */
    public void setHost(String host) {
        this.host = host;
    }

    /** Setter method for the FTP user */
    public void setUser(String user) {
        this.user = user;
    }

    /** Setter method for the FTP user’s password */
    public void setPassword(String p) {
        this.password = p;
    }

    /** Setter method for the remote file, this must include the sub-directory path relative
    to the user’s home directory, e.g you’e going to download a file that is within a sub directory
    called "sdir", and the file is named "d.txt", so you shall include the path as "sdir/d.txt"
     */
    public void setRemoteFile(String d) {
        this.remoteFile = d;
    }

    /** The method that returns the last message of success of any method call */
    public synchronized String getLastSuccessMessage() {
        if (succMesg == null) {
            return "";
        }
        return succMesg;
    }

    /** The method that returns the last message of error resulted from any exception of any method call */
    public synchronized String getLastErrorMessage() {
        if (erMesg == null) {
            return "";
        }
        return erMesg;
    }

   public synchronized boolean uploadFile(InputStream is) {
    //public synchronized boolean uploadFile(String localfilename) {
        try {

         //   InputStream is = new FileInputStream(localfilename);
            BufferedInputStream bis = new BufferedInputStream(is);
            OutputStream os = m_client.getOutputStream();
            BufferedOutputStream bos = new BufferedOutputStream(os);
            byte[] buffer = new byte[1024];
            int readCount;

            while ((readCount = bis.read(buffer)) > 0) {
                bos.write(buffer, 0, readCount);
            }
            bos.close();

            this.succMesg = "Uploaded!";

            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            StringWriter sw0 = new StringWriter();
            PrintWriter p0 = new PrintWriter(sw0, true);
            ex.printStackTrace(p0);
            erMesg = sw0.getBuffer().toString();

            return false;
        }
    }

    public synchronized boolean downloadFile(String localfilename) {
        try {
            InputStream is = m_client.getInputStream();
            BufferedInputStream bis = new BufferedInputStream(is);
            System.out.println(">>>>>>>>>>>"+localfilename);
            OutputStream os = new FileOutputStream(localfilename);
            BufferedOutputStream bos = new BufferedOutputStream(os);

            byte[] buffer = new byte[1024];
            int readCount;

            while ((readCount = bis.read(buffer)) > 0) {
                bos.write(buffer, 0, readCount);
            }
            bos.close();
            is.close(); // close the FTP inputstream
            this.succMesg = "Downloaded!";

            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            StringWriter sw0 = new StringWriter();
            PrintWriter p0 = new PrintWriter(sw0, true);
            ex.printStackTrace(p0);
            erMesg = sw0.getBuffer().toString();

            return false;
        }
    }

    
    public static void encrypt(InputStream is, OutputStream os) throws Throwable {
		encryptOrDecrypt(mykey, Cipher.ENCRYPT_MODE, is, os);
	}
    
    public static void decrypt(InputStream is, OutputStream os) throws Throwable {
		encryptOrDecrypt(mykey, Cipher.DECRYPT_MODE, is, os);
	}


	public static void encryptOrDecrypt(String key, int mode, InputStream is, OutputStream os) throws Throwable {

		DESKeySpec dks = new DESKeySpec(key.getBytes());
		SecretKeyFactory skf = SecretKeyFactory.getInstance("DES");
		SecretKey desKey = skf.generateSecret(dks);
		
		Cipher cipher = Cipher.getInstance("DES"); // DES/ECB/PKCS5Padding for SunJCE

		if (mode == Cipher.ENCRYPT_MODE) {
			cipher.init(Cipher.ENCRYPT_MODE, desKey);
			CipherInputStream cis = new CipherInputStream(is, cipher);
			doCopy(cis, os);
		} else if (mode == Cipher.DECRYPT_MODE) {
			System.out.println("in decripton");
			cipher.init(Cipher.DECRYPT_MODE, desKey);
			CipherOutputStream cos = new CipherOutputStream(os, cipher);
			doCopy(is, cos);
		}
	}

	public static void doCopy(InputStream is, OutputStream os) throws IOException {
		byte[] bytes = new byte[64];
		int numBytes;
		while ((numBytes = is.read(bytes)) != -1) {
			
			System.out.println("in while now ");
			os.write(bytes, 0, numBytes);
		}
		os.flush();
		os.close();
		is.close();
	}
	
	
    public synchronized boolean connect() {
        try {
            URL url = new URL("ftp://" + user + ":" + password + "@" + host + "/" + remoteFile + ";type=i");
            m_client = url.openConnection();
            System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.."+"ftp://" + user + ":" + password + "@" + host + "/" + remoteFile + ";type=i");
            return true;

        } catch (Exception ex) {
            ex.printStackTrace();
            StringWriter sw0 = new StringWriter();
            PrintWriter p0 = new PrintWriter(sw0, true);
            ex.printStackTrace(p0);
            erMesg = sw0.getBuffer().toString();
            return false;
        }
    }
 
}

