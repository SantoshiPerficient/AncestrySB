/**
 * Author - Santoshi (Perficient)
 * Purpose - This class will act as a domain class and basis for all the DML operations.
 */
public virtual without sharing class PRFT_DomainLayer
{
	public List<SObject> Records { get; private set;}
	
	public Schema.DescribeSObjectResult SObjectDescribe {get; private set;}
			
	public static ErrorFactory Errors  {get; private set;}
	
	public static TestFactory Test  {get; private set;}
	
	public  User CurrentUserInfo  {get ; private set;}
	
	static
	{
		Errors = new ErrorFactory();
		
		Test = new TestFactory();
	}
	
	public PRFT_DomainLayer(List<SObject> sObjectList)
	{
		Records = sObjectList;
		
		SObjectDescribe = Records.getSObjectType().getDescribe();
	}
	
	public PRFT_DomainLayer()
	{
		retrieveUserInfo();
	}
	
	
	// Class processing query.
	public class QueryEditor{
		public String QUERY_WHERE {get;private set;}
		public string objName {get; private set;}
		public string QUERY_SELECT {get;private set;}
		public string QUERY_FROM {get;private set;}
		public List<SObject> ResultSet { get; private set;}
		public QueryEditor(String obName , String whereQuery , String querySelect){
			objName = obName;
			QUERY_WHERE = whereQuery;
			QUERY_SELECT = 'Select ';
			QUERY_FROM = ' FROM ';
			ResultSet = executeQuery();
		}
		
		// Retrievs the field definition for a given object.
		public List<Schema.DescribeFieldResult> getFieldMap(){
			List<Schema.DescribeFieldResult> fields = new List<Schema.DescribeFieldResult>();
			SObjectType accountType = Schema.getGlobalDescribe().get(objName);
			Map<String,Schema.SObjectField> mfields = accountType.getDescribe().fields.getMap();
			for(Schema.SObjectField sof : mfields.values())
            {
               fields.add(sof.getDescribe());
            } 
            
            return fields;
		}
		
		//Build the Query String
	    private String buildQueryAllString()
	    {
	        String query = QUERY_SELECT;
	        List<Schema.DescribeFieldResult> queryFields = getFieldMap();
	        for(Schema.DescribeFieldResult dfr : queryFields)
	        {
	            query = query + dfr.getName() + ',';
	        }
	        query = query.subString(0,query.length() - 1);
	        query = query + QUERY_FROM + ' ';
	        query = query + objName + ' ';
	        query = query + QUERY_WHERE;
	         system.debug('Build Query == ' + query);
	        return query;
	    }
	    
	    //Build the Query String
	    private List<SObject> executeQuery()
	    {
	       
	       List<SObject> recList =  Database.query(buildQueryAllString());
	       return recList;
	    }
	    
	}
	
	
	/**
	 * Override this to create ActivityHistory records
	 **/
	public virtual void createActivityHistory() { }
	
	/**
	 * Override this to checkAccess for logged in user
	 **/
	public virtual Boolean checkAccess() { 
		
		return false;
	}
	
	/**
	 * Accesses current user records.
	 **/
	public virtual void retrieveUserInfo() { 
	    String userId = UserInfo.getUserId();
		QueryEditor qr = new QueryEditor('User','WHERE Id = \''+userId+'\' ','Select');
		CurrentUserInfo = (User) qr.ResultSet[0];
	}
	
	public class DomainException extends Exception
	{
	} 

	public String error(String message, SObject record)
	{
		return Errors.error(this, message, record);	
	}
	
	public String error(String message, SObject record, SObjectField field)
	{
		return Errors.error(this, message, record, field);	
	}
	public interface IConstructable
	{
		PRFT_DomainLayer construct(List<SObject> sObjectList);  
	}
	public class ErrorFactory
	{
		private List<Error> errorList = new List<Error>(); 
		
		private ErrorFactory()
		{
			
		}
		
		public String error(String message, SObject record)
		{
			return error(null, message, record);	
		}

		private String error(PRFT_DomainLayer domain, String message, SObject record)
		{
			ObjectError objectError = new ObjectError();
			objectError.domain = domain;
			objectError.message = message;
			objectError.record = record;
			errorList.add(objectError);
			return message;	
		}
		
		public String error(String message, SObject record, SObjectField field)
		{
			return error(null, message, record, field);	
		}

		private String error(PRFT_DomainLayer domain, String message, SObject record, SObjectField field)
		{
			FieldError fieldError = new FieldError();
			fieldError.domain = domain;
			fieldError.message = message;
			fieldError.record = record;
			fieldError.field = field;
			errorList.add(fieldError);
			return message;	
		}	
			
		public List<Error> getAll()
		{ 
			return errorList.clone();
		}
		
		public void clearAll()
		{
			errorList.clear();
		}					
	}
	
	public class FieldError extends ObjectError
	{
		public SObjectField field;
		
		private FieldError()
		{		
			
		}
	}
	
	public virtual class ObjectError extends Error
	{
		public SObject record;
		
		private ObjectError()
		{
		
		}
	}
	
	public abstract class Error
	{
		public String message;
		public PRFT_DomainLayer domain;
	}
	
	public class TestFactory
	{
		
		 
		private TestFactory()
		{		
			
		} 
	}
	
	
}