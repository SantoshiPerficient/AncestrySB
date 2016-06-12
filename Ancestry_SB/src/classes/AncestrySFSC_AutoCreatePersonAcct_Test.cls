/*************************************************
Class: AncestrySFSC_AutoCreatePersonAcct_Test.cls
Description: test class for AncestrySFSC_AutoCreatePersonAccuont trigger
Auther: Lisa Cheng
Date:   2/16/2015

Revision History:
----------------------------------------------------

***************************************************/ 
@isTest
public class AncestrySFSC_AutoCreatePersonAcct_Test{
      static testMethod void testPopulateAccount(){
        Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();        
        Account acc = new Account(LastName='Person Acc',PersonEmail = 'person@test.com',phone='3456667891',recordtypeId = personAccountId);
        insert acc;
        
        Case c = new Case(Community_Last_Name__c='Person Acc',SuppliedEmail='person@test.com',SuppliedPhone='3456667891',Web_Category__c='Accounts & Billing',
                          Web_Sub_Category__c='Account Settings',Subject='Test Web Case',Description='Test Desc',Origin='Support Center (North America)',Status='New');
        insert c;
        Account inserted = [select id, PersonContactId from account where id =:acc.id];
        c = [select id, accountId, contactId from case where id =:c.id];
        System.assertEquals(c.accountId, inserted.id);
        System.assertEquals(c.contactId, inserted.PersonContactId); 
    }
    static testMethod void testCreateNewAccount(){
        Case c = new Case(Community_Last_Name__c='New Person Acc',SuppliedEmail='person@test2.com',SuppliedPhone='3456667891',Web_Category__c='Accounts & Billing',
                          Web_Sub_Category__c='Account Settings',Subject='Test Web Case',Description='Test Desc',Origin='Support Center (North America)',Status='New');
        insert c; 
        List<Account> inserted = [select id, PersonContactId from account];
        c = [select id, accountId, contactId from case where id =:c.id];
        System.assertEquals(c.accountId, inserted[0].id);
        System.assertEquals(c.contactId, inserted[0].PersonContactId);                    
        
    }
    static testMethod void testCreateNewAccountException(){
        User u = AncestrySFSC_TestUtil.prepareSpecialEmailUser('person@test2.com');
        System.runAs(u){
            Case c = new Case(Community_Last_Name__c='New Person Acc',SuppliedEmail='person@test2.com',SuppliedPhone='3456667891',Web_Category__c='Accounts & Billing',
                              Web_Sub_Category__c='Account Settings',Subject='Test Web Case',Description='Test Desc',Origin='Support Center (North America)',Status='New');
            insert c; 
            List<Account> inserted = [select id, PersonContactId from account];
            c = [select id,SuppliedEmail, accountId, contactId from case where id =:c.id];
             System.assertEquals('person@test2.com',c.SuppliedEmail);
            System.assertEquals(c.accountId, inserted[0].id);
            System.assertEquals(c.contactId, inserted[0].PersonContactId);                    
        }
    }
    static testMethod void testMultiAccounts(){
        Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();  
        
        Account acc = new Account(FirstName='Test',LastName='Person Acc',PersonEmail = 'person@test0.com',phone='3456667891',recordtypeId = personAccountId);
        insert acc;
        Account acc2 = new Account(FirstName='Test',LastName='Person Acc2',PersonEmail = 'person@test2.com',phone='3456667891',recordtypeId = personAccountId);
        insert acc2;
        List<Case> caselst = new List<Case>();
        for(Integer i=0;i<5;i++){
            Case c = new Case(Community_Last_Name__c='Person Acc'+i,SuppliedEmail='person@test'+i+'.com',SuppliedPhone='3456667891',Web_Category__c='Accounts & Billing',
                              Web_Sub_Category__c='Account Settings',Subject='Test Web Case',Description='Test Desc',Origin='Support Center (North America)',Status='New');
            caselst.add(c);                
        }
        insert caselst;
        
        List<Account> inserted = [select id, PersonContactId,firstname,lastName,PersonEmail  from account];
        System.assertEquals(5, inserted.size()); 
        
        caselst = [select id, accountId, contactId,SuppliedEmail from case];
        for(Integer i=0;i<5;i++){
            if(caselst.get(i).SuppliedEmail == 'person@test0.com'){
                System.assertEquals(caselst.get(i).accountId, acc.id);
            }else if(caselst.get(i).SuppliedEmail == 'person@test2.com'){
                System.assertEquals(caselst.get(i).accountId, acc2.id);
            }
        }
    }
    
        //Add test when SuppliedEmail has upper letter,  JoJo Zhao 5/18/2016
    static testMethod void testUpperLetterSuppliedEmail(){
        Case c = new Case(Community_Last_Name__c='New Person Acc',SuppliedEmail='Person@test2.com',SuppliedPhone='3456667891',Web_Category__c='Accounts & Billing',
                          Web_Sub_Category__c='Account Settings',Subject='Test Web Case',Description='Test Desc',Origin='Support Center (North America)',Status='New');
        insert c; 
        List<Account> inserted = [select id, PersonContactId from account];
        c = [select id, accountId, contactId from case where id =:c.id];
        System.assertEquals(c.accountId, inserted[0].id);
        System.assertEquals(c.contactId, inserted[0].PersonContactId);                    
        
    }
    //Add test when SuppliedEmail has upper letter,  JoJo Zhao 5/18/2016
    static testMethod void testUpperLetterSuppliedEmailForHelper(){
        List<Case> newList = new List<Case>();
        Case c = new Case(Community_Last_Name__c='New Person Acc',SuppliedEmail='Person@test2.com',SuppliedPhone='3456667891',Web_Category__c='Accounts & Billing',
                          Web_Sub_Category__c='Account Settings',Subject='Test Web Case',Description='Test Desc',Origin='Support Center (North America)',Status='New');
        
        newList.add(c);
        AncestrySFSC_AutoCreatePersonAcctHelper helper = new AncestrySFSC_AutoCreatePersonAcctHelper();
        helper.autoCreatePersonAccount(newList);
        
        List<Account> inserted = [select id, PersonContactId from account];
        
        System.assertEquals(c.accountId, inserted[0].id);
        System.assertEquals(c.contactId, inserted[0].PersonContactId);                    
        
    }
}