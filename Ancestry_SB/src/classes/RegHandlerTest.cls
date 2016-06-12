@isTest(SeeAllData = true)
public class RegHandlerTest {

    @isTest private static void verifyInsertChatterFreeUser() {
        Profile p = [SELECT id 
                     FROM profile 
                     WHERE name != 'Ancestry Support User' limit 1];
       UserRole role = [SELECT Id,Name FROM UserRole limit 1];
        
        User user = new User(alias = 'chfree33',
                           email = 'chatterfreeuser122@testorg.com',
                           emailencodingkey = 'UTF-8',
                           lastname = 'Testing22',
                           companyname = 'testorg',
                           languagelocalekey = 'en_US',
                           localesidkey = 'en_US',
                           profileId = p.Id,
                           userRoleId = role.Id,
                           timezonesidkey = 'America/Los_Angeles',
                           username = 'chatterfreeuser122@testorg.com');
        insert user;
        System.runAs(user){
        Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();        
        Account acc = new Account(LastName='Person Acc',PersonEmail = 'person@test.com',phone='3456667891',recordtypeId = personAccountId);
        insert acc;
         Account inserted = [select id, PersonContactId from account where id =:acc.id];
        //CREATE CHATTER FREE TEST USER
        p = [SELECT id 
                     FROM profile 
                     WHERE name = 'Ancestry Support User'];
        User u1 = new User(alias = 'chfree01',
                           email = 'chatterfreeuser101@testorg.com',
                           emailencodingkey = 'UTF-8',
                           lastname = 'Testing',
                           companyname = 'testorg',
                           languagelocalekey = 'en_US',
                           localesidkey = 'en_US',
                           profileId = p.Id,
                           contactId = inserted.PersonContactId,
                           timezonesidkey = 'America/Los_Angeles',
                           username = 'chatterfreeuser101@testorg.com');
        insert u1;
        // perform some assertions regarding expected state of user after insert

      }
    }

    @isTest 
    private static void verifyUpdateChatterFreeUser() {
  Profile p = [SELECT id 
                     FROM profile 
                     WHERE name != 'Ancestry Support User' limit 1];
       UserRole role = [SELECT Id,Name FROM UserRole limit 1];
        
        User user = new User(alias = 'chfree33',
                           email = 'chatterfreeuser122@testorg.com',
                           emailencodingkey = 'UTF-8',
                           lastname = 'Testing22',
                           companyname = 'testorg',
                           languagelocalekey = 'en_US',
                           localesidkey = 'en_US',
                           profileId = p.Id,
                           userRoleId = role.Id,
                           timezonesidkey = 'America/Los_Angeles',
                           username = 'chatterfreeuser122@testorg.com');
        insert user;
        System.runAs(user){
     Id personAccountId= Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Person Account').getRecordTypeId();        
        Account acc = new Account(LastName='Person Acc',PersonEmail = 'person@test.com',phone='3456667891',recordtypeId = personAccountId);
        insert acc;
         Account inserted = [select id, PersonContactId from account where id =:acc.id];
        //CREATE CHATTER FREE TEST USER
        p = [SELECT id 
                     FROM profile 
                     WHERE name = 'Ancestry Support User'];
        User u1 = new User(alias = 'chfree01',
                           email = 'chatterfreeuser101@testorg.com',
                           emailencodingkey = 'UTF-8',
                           lastname = 'Testing',
                           companyname = 'testorg',
                           languagelocalekey = 'en_US',
                           localesidkey = 'en_US',
                           profileId = p.Id,
                           contactId = inserted.PersonContactId,
                           timezonesidkey = 'America/Los_Angeles',
                           username = 'chatterfreeuser101@testorg.com');
        insert u1;
        // perform some assertion regarding expected state of user after insert

        // change something on user
        u1.email = 'test.chatter.free@gmail.com';
        update u1;

        // perform some assertions regarding expected state of user after update
        // System.assertEquals('expected value', u1.field);
}

    }

}