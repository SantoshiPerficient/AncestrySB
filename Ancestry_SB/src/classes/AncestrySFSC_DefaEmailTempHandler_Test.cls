/*************************************************
Class: AncestrySFSC_DefaEmailTempHandler_Test.cls
Description: test class for AncestrySFSC_DefaultEmailTemplateHandler
Auther: Lisa Cheng
Date:   2/16/2016

Revision History:
----------------------------------------------------

***************************************************/
@isTest
public class AncestrySFSC_DefaEmailTempHandler_Test{
    static testmethod void DefaultCaseFeedEmailImplementor_SimpleTest()
    {
        Profile p = [select id from profile where name!='System Administrator' limit 1];
        User u = new User(Alias = 'ancesT', Email='ancest@testorg.com',
                            EmailEncodingKey='UTF-8', Firstname = 'Ancestry',LastName='Test', LanguageLocaleKey='en_US',
                            LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles',
                            UserName='ancest@testorg.com',Email_Template__c ='EO Template');
        insert u;
        EmailTemplate validEmailTemplate = new EmailTemplate();
        validEmailTemplate.isActive = true;
        validEmailTemplate.Name = 'EO Template';
        validEmailTemplate.DeveloperName = 'EO_Template';
        validEmailTemplate.TemplateType = 'text';
        validEmailTemplate.FolderId = [select id, name from folder  where developerName= : Label.AncestrySFSC_UserEmailTemplateFolder_DeveloperName].id;
         
        insert validEmailTemplate;    
                  
        System.runAs(u){
            //Create test data here
            Exception failureDuringExecution = null;
        
            List<Map<String, Object>> defaultSettingAsUntypedObject = new List<Map<String, Object>>
            {
              new Map<String, Object>
              {
                    'targetSObject' => new EmailMessage(),
                    'contextId' => '50011000005ZtcRAAS',
                    'actionType' => 'Email',
                    'actionName' => 'Case.Email',
                    'fromAddressList' => new List<String> { 'salesforce@test.com' }
              }
            };
            
            List<QuickAction.SendEmailQuickActionDefaults> defaultsSettings = 
                (List<QuickAction.SendEmailQuickActionDefaults>)JSON.deserialize(JSON.serialize(defaultSettingAsUntypedObject), List<QuickAction.SendEmailQuickActionDefaults>.class); 
                    Test.startTest();
            try { (new AncestrySFSC_DefaultEmailTemplateHandler()).onInitDefaults(defaultsSettings); }
            catch(Exception failure) { failureDuringExecution = failure; }
        
            Test.stopTest();
        
            System.assertEquals(null, failureDuringExecution, 'There was an exception thrown during the test!');
            //Make other assertions here
        }
    }
}