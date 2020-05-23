package com.voidmain.pojo;

public class Patient {

	private String patientId;
	private String name;
	private String password;
	private int age;
	private String gender;
	private String phone;
	private String address;
	private int teamId;
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setAge(String age) {
		this.age = Integer.parseInt(age);
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(String teamId) {
		this.teamId = Integer.parseInt(teamId);
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	@Override
	public String toString() {
		return "Patient [patientId=" + patientId + ", name=" + name
				+ ", password=" + password + ", age=" + age + ", gender="
				+ gender + ", phone=" + phone + ", address=" + address
				+ ", teamId=" + teamId + "]";
	}
		
}
