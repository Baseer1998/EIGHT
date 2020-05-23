package com.voidmain.pojo;

public class Transaction {

	private int transactionId;
	private String patientId;
	private String requestedHospital;
	private String date;
	private String status;
	
	public int getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getRequestedHospital() {
		return requestedHospital;
	}
	public void setRequestedHospital(String requestedHospital) {
		this.requestedHospital = requestedHospital;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
