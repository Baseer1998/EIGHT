package com.voidmain.pojo;

public class Treatment {

	private int treatmentId;
	private String patientId;
	private int blockChainId;
	
	public int getTreatmentId() {
		return treatmentId;
	}
	public void setTreatmentId(int treatmentId) {
		this.treatmentId = treatmentId;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public int getBlockChainId() {
		return blockChainId;
	}
	public void setBlockChainId(int blockChainId) {
		this.blockChainId = blockChainId;
	}
	
	@Override
	public String toString() {
		return "Treatment [treatmentId=" + treatmentId + ", patientId="
				+ patientId + ", blockChainId=" + blockChainId + "]";
	}
}
