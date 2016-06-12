@isTest(SeeAlldata=true)
public class AncestrySFSC_LightningSelfRegCtrl_Test{
    static testMethod void testSelfRegister(){
        Profile p = [SELECT id 
                     FROM profile 
                     WHERE name != 'Ancestry Support User' limit 1];
        UserRole role = [SELECT Id,Name FROM UserRole limit 1];
        
        User user = new User(alias = 'selfReg',
                           email = 'selfReg@testorg.com',
                           emailencodingkey = 'UTF-8',
                           lastname = 'TestSelfReg',
                           companyname = 'testorg',
                           languagelocalekey = 'en_US',
                           localesidkey = 'en_US',
                           profileId = p.Id,
                           userRoleId = role.Id,
                           timezonesidkey = 'America/Los_Angeles',
                           username = 'selfReg@testorg.com');
        insert user;
        System.runAs(user){
            Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();        
            Account acc = new Account(LastName='Person Acc',PersonEmail = 'person@test.com',phone='3456667891',recordtypeId = personAccountId);
            insert acc;
            Account inserted = [select id, PersonContactId from account where id =:acc.id];
            
            String extraFields  = '[{"fieldPath":"Alias","value":"testComU"}]';
            AncestrySFSC_LightningSelfRegisterCtrl ctrl = new AncestrySFSC_LightningSelfRegisterCtrl();
            Test.startTest();
            AncestrySFSC_LightningSelfRegisterCtrl.selfRegister('TestComln12','TestComfn12','comuser12@test.com','ab1234cde','ab1234cde',acc.id,'www.google.com',extraFields,'www.ancestry.com',true);
            AncestrySFSC_LightningSelfRegisterCtrl.getExtraFields('Test');
            AncestrySFSC_LightningSelfRegisterCtrl.selfRegister('','TestComfn','comuser@test.com','Test12345!','Test12345!',acc.id,'www.google.com',extraFields,'www.ancestry.com',false);
            AncestrySFSC_LightningSelfRegisterCtrl.selfRegister('TestComln','TestComfn','','Test12345!','Test12345!',acc.id,'www.google.com',extraFields,'www.ancestry.com',false);
            AncestrySFSC_LightningSelfRegisterCtrl.selfRegister('TestComln12','TestComfn12','comuser12@test.com','Test12345!','Test12345!',acc.id,'www.google.com',extraFields,'www.ancestry.com',false);
            
            Test.stopTest();
        }
        
    }
}