/*************************************************
Class: AncestrySFSC_AutoCreatePersonAcctHelper.cls
Description: helper class for AncestrySFSC_AutoCreatePersonAccuont trigger
Auther: Lisa Cheng
Date:   2/15/2015

Revision History:
----------------------------------------------------
Populate the value of Account and Contact when case is created from Web  - Lisa Cheng 2/15/2016

Fix the issue when SuppliedEmail has upper letter, failed to link contact id to case.
Because System will convert person account email and case email into low case, so operate all map's Email key to low case   - JoJo Zhao 5/18/2016

Update to use split up FirstName and LastName by custom fields.  -JoJo Zhao 5/19/2016
***************************************************/ 
public class AncestrySFSC_AutoCreatePersonAcctHelper {
     //Populate the value of Account and Contact when case is created from Web
    public void autoCreatePersonAccount(List<Case> newList){
        Set<String> caseOriginSet = new Set<String>{'Support Center (North America)','Support Center (UK)','Support Center (Canada)','Support Center (French)','Support Center (Australia)',
                                                    'Support Center (French Canada)','Support Center (Italian)','Support Center (Mexico)','Support Center (Swedish)','Support Center (German)',
                                                    'RootsWeb','Ancestry Library','Ancestry Health','Find a Grave','Archives (All)'};
        Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Map<String, Account> emailToNewAccMap = new Map<String, Account>();
        List<Case> caselst = new List<Case>();
        Set<String> emails = new Set<String>();
        for(Case c: newList){            
            if(caseOriginSet.contains(c.Origin)&&c.SuppliedEmail!=null&&c.Community_Last_Name__c!=null){
                Account acc = new Account();
                acc.FirstName =  c.Community_First_Name__c;
                acc.LastName = c.Community_Last_Name__c;
                acc.PersonEmail = c.SuppliedEmail.toLowerCase();
                acc.Phone = c.SuppliedPhone;
                acc.recordTypeId = personAccountId;
                emailToNewAccMap.put(c.SuppliedEmail.toLowerCase(),acc);
                emails.add(c.SuppliedEmail.toLowerCase());
                caselst.add(c);
            }
        }
        if(!emails.isEmpty()){
            Map<String,Account> emailToExistAccMap = new Map<String, Account>();
            for(Account a : [select id,PersonEmail,PersonContactId from account where PersonEmail in:emails and recordtypeId=:personAccountId ]){
                emailToExistAccMap.put(a.PersonEmail.toLowerCase(), a);  
                if(emailToNewAccMap.containsKey(a.personEmail.toLowerCase())){
                    emailToNewAccMap.remove(a.personEmail.toLowerCase());
                }          
            }
            
            if(!emailToNewAccMap.isEmpty()){
                try{
                	insert emailToNewAccMap.values();
                } catch(Exception ex)
                {
                    System.debug(ex);
                }  
                for(Account a : [select id,PersonEmail,PersonContactId from account where PersonEmail in:emailToNewAccMap.keySet() and recordtypeId=:personAccountId ]){
                    emailToExistAccMap.put(a.PersonEmail.toLowerCase(), a);  
                }
            }
            
            for(Case c: caselst){
                if(emailToExistAccMap.containsKey(c.SuppliedEmail.toLowerCase())){
                    if(c.accountId == null){
                        c.accountId= emailToExistAccMap.get(c.SuppliedEmail.toLowerCase()).id;
                    }
                    if(c.contactId == null){
                        c.contactId= emailToExistAccMap.get(c.SuppliedEmail.toLowerCase()).PersonContactId;
                    }
                }
                
            }
            
        }
    }
}