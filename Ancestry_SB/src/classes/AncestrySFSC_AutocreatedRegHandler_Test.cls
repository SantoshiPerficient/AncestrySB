@isTest(SeeAllData=true)
global class AncestrySFSC_AutocreatedRegHandler_Test{
    static testMethod void testAutocreatedRegHandler(){
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
            Id networkId = [select id from network where name like 'Ancestry%' limit 1].Id;
            Map<String,String> attributeMap = new Map<String,String>{'sfdc_networkid'=>networkId};
            Auth.UserData userData = new Auth.UserData('','testFCFN','testFCLN','testFCFN FCLN','testFC@acc.com','','testFC','','FaceBook','',attributeMap);
            AncestrySFSC_AutocreatedRegHandler handler = new AncestrySFSC_AutocreatedRegHandler();
            User u = handler.createUser(networkId, userData);
            System.assertEquals('testFC@acc.com.US', u.username);
            
            //Test create standard user
            attributeMap = new Map<String,String>();
            userData = new Auth.UserData('','testFCFN2','testFCLN2','testFCFN FCLN2','testFC2@acc.com','','testFC2','','FaceBook','',attributeMap);
            u = handler.createUser(networkId, userData);
            p = [SELECT Id FROM profile WHERE name='Standard User'];
            System.assertEquals(p.id, u.profileId);
            
            //Test update partner user
            p = [SELECT Id FROM profile WHERE name='Ancestry Support User'];
            userData = new Auth.UserData('','testUPFN','testUPLN','testFCFN FCLN','testFC@acc.com','','testFC','','FaceBook','',attributeMap);
            List<User> users = [select id, firstname from user where profileId=:p.id limit 10];
            If(users.size()>0){
                handler.updateUser(users[0].id, networkId, userData);
            }
        } 
    
    }
}