@istest
public class AncestrySFSC_TestUtil {
    
    //create record
    public static List<sobject> createSobjects( Integer numToInsert, Boolean doInsert, Map<String, Object> nameValueMap , String sobjType){
        List<Sobject> objList = new List<sobject>();
        for( Integer i=0; i< numToInsert; i++ ){
            Sobject obj = Schema.getGlobalDescribe().get(sobjType).newSObject();
            
            objList.add( obj );
        }
        return createRecords( objList, doInsert, nameValueMap );
    }
    public static List<SObject> createRecords( List<SObject> records, Boolean doInsert, Map<String, Object> attributes ){
        
        Integer i = 0;
        if( attributes != null ){
            for ( Integer j =0; j < records.size(); j ++ ) {
                Sobject record = records[j];
                for (String key : attributes.keySet()) {
                    Object value = attributes.get(key);
                    if (value instanceof List<Object>) {
                        object obj =  ((List<Object>) value).get(i);
                        if( obj instanceof Sobject ){
                            Id sObjectId = ((SObject) obj).Id;
                            record.put( key,sObjectId );
                        }
                        else {
                            record.put(key,obj);
                        }
                    } else {
                        record.put(key, value);
                    }
                }
                i++;
            }
        }
        
        if (doInsert) {
            insert records;
        }
        return records;
    }
    public static User prepareUser(String email){
        
      Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
    
        Account acc = createPersonAccounts(1, true, new Map<String,Object>{
            'PersonEmail'=> email,
            'recordTypeId' => personAccountId
            })[0];
         
        Account accFetch = [select PersonContactId from Account where id= :acc.id];
        Contact con = [select id, ownerId from contact where id = :accFetch.PersonContactId];
        String profileName ='Ancestry Support User';
        Profile p = [SELECT Id FROM Profile WHERE NAME = :profileName LIMIT 1];
        System.debug('>>>createUserProfile'+ p);
        
        User u = createSpecialEmailUsers(1, true,email, new Map<String, Object>{'ProfileId' => p.Id, 'ContactId' =>  accFetch.PersonContactId})[0];
        return u;
    }
    
    
    public static User prepareSpecialEmailUser(String email){
        
      Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
    
        Account acc = createPersonAccounts(1, true, new Map<String,Object>{
            'PersonEmail'=> 'incorrect.' + email,
            'recordTypeId' => personAccountId
            })[0];
         
        Account accFetch = [select PersonContactId from Account where id= :acc.id];
        Contact con = [select id, ownerId from contact where id = :accFetch.PersonContactId];
        String profileName ='Ancestry Support User';
        Profile p = [SELECT Id FROM Profile WHERE NAME = :profileName LIMIT 1];
        System.debug('>>>createUserProfile'+ p);
        
        User u = createSpecialEmailUsers(1, true,email, new Map<String, Object>{'ProfileId' => p.Id, 'ContactId' =>  accFetch.PersonContactId})[0];
        return u;
    }
    
    // create user
    public static List<User> createSpecialEmailUsers( Integer numToInsert, Boolean doInsert, String email, Map<String, Object> nameValueMap ){
        List<User> usersToInsert = new List<User>();
        for( Integer i=0; i< numToInsert; i++ ){
            User u = new User();
            U.CompanyName='test company';
            // u.BU_Name__c ='test BU';
            u.Alias = 'tUser' + i; 
            u.Email = email;
            u.EmailEncodingKey = 'UTF-8';
            u.LastName = 'TestName' + i;
            u.LanguageLocaleKey = 'en_US';
            u.LocaleSidKey = 'en_US';
            u.TimeZoneSidKey = 'America/Los_Angeles';
            u.UserName = 'testUserus' + i + '@testorg.com.us';
            usersToInsert.add( u );
        }
        return createRecords( usersToInsert, doInsert, nameValueMap );
    }
    
     // create account
    public static List<Account> createPersonAccounts( Integer numToInsert, Boolean doInsert, Map<String, Object> nameValueMap ){
        List<Account> accountsToInsert = new List<Account>();
        for( Integer i=0; i< numToInsert; i++ ){
            Account acc = new Account();
            acc.LastName = 'TestRecord-Account-' + i;
            accountsToInsert.add( acc );
        }
        return createRecords( accountsToInsert, doInsert, nameValueMap );
    }
    
    // create contact
    public static List<Contact> createContacts( Integer numToInsert, Boolean doInsert, Map<String, Object> nameValueMap ){
        List<Contact> consToInsert = new List<Contact>();
        for( Integer i=0; i< numToInsert; i++ ){
            Contact con = new Contact();
            con.LastName = 'TestLastName' + i;
            con.FirstName = 'TestFirstName' + i;
            consToInsert.add( con );
        }
        return createRecords( consToInsert, doInsert, nameValueMap );
    }
    
    
}