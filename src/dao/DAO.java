package com.voidmain.dao;

import java.util.List;

import com.voidmain.pojo.Block;
import com.voidmain.pojo.BlockChain;
import com.voidmain.pojo.Family;
import com.voidmain.pojo.PatientDocument;
import com.voidmain.pojo.Team;
import com.voidmain.pojo.Transaction;
import com.voidmain.pojo.Treatment;
import com.voidmain.pojo.Hospital;
import com.voidmain.pojo.InsuranceCompany;
import com.voidmain.pojo.Patient;

public class DAO {

	public static boolean isValidUser(String username,String password)
	{
		boolean isValid=false;

		Hospital user=getHospitalById(username);

		if(user!=null && user.getPassword().equals(password) && user.getStatus().equals("yes"))
		{
			isValid=true;
		}

		return isValid;
	}

	public static boolean isValidPatinet(String username,String password)
	{
		boolean isValid=false;

		Patient user=getPatientById(username);

		if(user!=null && user.getPassword().equals(password))
		{
			isValid=true;
		}

		return isValid;
	}

	public static boolean isValidFamily(String username,String password)
	{
		boolean isValid=false;

		Family family=getFamilyById(username);

		if(family!=null && family.getPassword().equals(password))
		{
			isValid=true;
		}

		return isValid;
	}
	
	public static boolean isValidInsurance(String username,String password)
	{
		boolean isValid=false;

		InsuranceCompany insuranceCompany=getInsuranceCompanyById(username);

		if(insuranceCompany!=null && insuranceCompany.getPassword().equals(password) && insuranceCompany.getStatus().equals("yes"))
		{
			isValid=true;
		}

		return isValid;
	}

	//============================================================================

	public static Hospital getHospitalById(String id)
	{
		return (Hospital)HibernateTemplate.getObject(Hospital.class,id);
	}

	public static int deleteHospital(int id)
	{
		return HibernateTemplate.deleteObject(Hospital.class,id);
	}

	public static List<Hospital> getHospitals()
	{
		List<Hospital> hospitals=(List)HibernateTemplate.getObjectListByQuery("From Hospital");

		return hospitals;
	}

	//=========================================================================

	public static Treatment getTreatmentById(int id)
	{
		return (Treatment)HibernateTemplate.getObject(Treatment.class,new Integer(id));
	}

	public static int deleteTreatment(int id)
	{
		return HibernateTemplate.deleteObject(Treatment.class,new Integer(id));
	}

	public static List<Treatment> getTreatments()
	{
		List<Treatment> treatments=(List)HibernateTemplate.getObjectListByQuery("From Treatment");

		return treatments;
	}

	//==================================================================

	public static Transaction getTransactionById(int id)
	{
		return (Transaction)HibernateTemplate.getObject(Transaction.class,new Integer(id));
	}

	public static int deleteTransaction(int id)
	{
		return HibernateTemplate.deleteObject(Transaction.class,new Integer(id));
	}

	public static List<Transaction> getTransactions()
	{	
		List<Transaction> transactions=(List)HibernateTemplate.getObjectListByQuery("From Transaction");

		return transactions;
	}

	//======================================================================

	public static Team getTeamById(int id)
	{
		return (Team)HibernateTemplate.getObject(Team.class,new Integer(id));
	}

	public static int deleteTeam(int id)
	{
		return HibernateTemplate.deleteObject(Team.class,new Integer(id));
	}

	public static List<Team> getTeams()
	{
		List<Team> teams=(List)HibernateTemplate.getObjectListByQuery("From Team");

		return teams;
	}

	//======================================================================

	public static Patient getPatientById(String id)
	{
		return (Patient)HibernateTemplate.getObject(Patient.class,id);
	}

	public static int deletePatient(int id)
	{
		return HibernateTemplate.deleteObject(Patient.class,id);
	}

	public static List<Patient> getPatients()
	{
		List<Patient> patients=(List)HibernateTemplate.getObjectListByQuery("From Patient");

		return patients;
	}

	//======================================================================

	public static Block getBlockById(int id)
	{
		return (Block)HibernateTemplate.getObject(Block.class,new Integer(id));
	}

	public static int deleteBlock(int id)
	{
		return HibernateTemplate.deleteObject(Block.class,new Integer(id));
	}

	public static List<Block> getBlocks()
	{
		List<Block> blocks=(List)HibernateTemplate.getObjectListByQuery("From Block");

		return blocks;
	}

	//======================================================================

	public static BlockChain getBlockChainById(int id)
	{
		return (BlockChain)HibernateTemplate.getObject(BlockChain.class,new Integer(id));
	}

	public static int deleteBlockChain(int id)
	{
		return HibernateTemplate.deleteObject(BlockChain.class,new Integer(id));
	}

	public static List<BlockChain> getBlockChains()
	{
		List<BlockChain> blockChains=(List)HibernateTemplate.getObjectListByQuery("From BlockChain");

		return blockChains;
	}

	//============================================================================

	public static PatientDocument getPatientDocumentsById(int id)
	{
		return (PatientDocument)HibernateTemplate.getObject(PatientDocument.class,new Integer(id));
	}

	public static int deletePatientDocuments(int id)
	{
		return HibernateTemplate.deleteObject(PatientDocument.class,new Integer(id));
	}

	public static List<PatientDocument> getPatientDocuments()
	{
		List<PatientDocument> patientDocuments=(List)HibernateTemplate.getObjectListByQuery("From PatientDocument");

		return patientDocuments;
	}

	//==================================================================

	public static Family getFamilyById(String id)
	{
		return (Family)HibernateTemplate.getObject(Family.class,id);
	}

	public static int deleteFamily(String id)
	{
		return HibernateTemplate.deleteObject(Family.class,id);
	}

	public static List<Family> getFamilys()
	{	
		List<Family> familys=(List)HibernateTemplate.getObjectListByQuery("From Family");

		return familys;
	}
	
	//============================================================================

	public static InsuranceCompany getInsuranceCompanyById(String id)
	{
		return (InsuranceCompany)HibernateTemplate.getObject(InsuranceCompany.class,id);
	}

	public static int deleteInsuranceCompany(int id)
	{
		return HibernateTemplate.deleteObject(InsuranceCompany.class,id);
	}

	public static List<InsuranceCompany> getInsuranceCompanys()
	{
		List<InsuranceCompany> insuranceCompanys=(List)HibernateTemplate.getObjectListByQuery("From InsuranceCompany");

		return insuranceCompanys;
	}
}
