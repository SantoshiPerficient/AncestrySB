/*************************************************
Class: AncestrySFSC_ContactUsCtrl_Test.cls
Description: Test class for controller class AncestrySFSC_ContactUsController
Auther: JoJo Zhao(Perficient)
Date:   5/24/2016

Revision History:
----------------------------------------------------
***************************************************/ 
@IsTest
public class AncestrySFSC_ContactUsCtrl_Test {
    @IsTest
    public static void testAncestrySFSC_ContactUs() {
        List<String> networkIds = new  List<String>();    
        List<String> networkNames = new  List<String>();    
        //create custom setting AncestrySFSC_CommunityToLocaleMap__c
        //create custom setting AncestrySFSC_CategoryMapping__c
        //create article with data category
        
        for(Network n: [Select Id,name from Network limit 1]){
            networkIds.add(n.id);
            networkNames.add(n.name);
        }
        List<String> titleNames = new List<String>{'topic1','topic2','topic3'};
            List<Topic> topics = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{
                'NetworkId' => networkIds[0],
                    'name' => titleNames}, 'Topic');
        System.debug('>>>topics'+topics);
        System.debug('>>>networkNames'+networkNames);
        
        createContactUsAsso(networkIds,topics);
        User u = AncestrySFSC_TestUtil.prepareUser('person@test2.com');
        //get the network membership to get the correct network ID
        System.runAs(u){
            Test.startTest();
            String urlFR='/FR/s/';
            List<Contact_Us_Configurations__c> confsFR = AncestrySFSC_ContactUsController.getContactUsConfs(urlFR); 
            System.assertEquals(confsFR.size(), 3);
            System.assertEquals(confsFR[0].Configuration_Type__c, 'Live Chat');            
            
            String url='/s/';
            List<Contact_Us_Configurations__c> confs = AncestrySFSC_ContactUsController.getContactUsConfs(url); 
            System.assertEquals(confs.size(), 3);
            System.assertEquals(confs[0].Configuration_Type__c, 'Live Chat');            
            
            String urlTopic='/s/topic/'+topics[0].id+'/Accounts%20%26%20Billing';            
            List<Contact_Us_Configurations__c> confsTopic = AncestrySFSC_ContactUsController.getContactUsConfs(urlTopic);             
            System.assertEquals(confsTopic.size(), 3);
            System.assertEquals(confsTopic[1].Configuration_Type__c, 'Case');
            
            String urlSearchTopic='/s/search/'+topics[2].id+'/Accounts%20%26%20Billing/aaa';            
            List<Contact_Us_Configurations__c> confsSearchTopic = AncestrySFSC_ContactUsController.getContactUsConfs(urlSearchTopic);            
            System.assertEquals(confsSearchTopic.size(), 3);
            System.assertEquals(confsSearchTopic[2].Configuration_Type__c, 'Phone');
            
            String urlSearchTopic2='/s/search/'+topics[1].id+'/Accounts%20%26%20Billing/aaa';            
            List<Contact_Us_Configurations__c> confsSearchTopic2 = AncestrySFSC_ContactUsController.getContactUsConfs(urlSearchTopic2);             
            System.assertEquals(confsSearchTopic2.size(), 0);
            
            String urlGlobalSearch='/s/search/All/Home/aaa';            
            List<Contact_Us_Configurations__c> confsGlobalSearch = AncestrySFSC_ContactUsController.getContactUsConfs(urlGlobalSearch);             
            System.assertEquals(confsGlobalSearch.size(), 3);
            System.assertEquals(confsGlobalSearch[1].Configuration_Type__c, 'Case');
            
            String urlQuestionTopic='/s/question/0D51700000J6fkkCAB';            
            List<Contact_Us_Configurations__c> confsQuestionTopic = AncestrySFSC_ContactUsController.getContactUsConfs(urlQuestionTopic);             
            System.assertEquals(confsQuestionTopic.size(), 3);
            
            Test.stopTest();
        }
    }
    @IsTest
    public static void testAncestrySFSC_ArticleContactUs() {
        List<String> networkIds = new  List<String>();    
        List<String> networkNames = new  List<String>();    
        
        for(Network n: [Select Id,name from Network limit 1]){
            networkIds.add(n.id);
            networkNames.add(n.name);
        }
        List<String> titleNames = new List<String>{'topic1','topic2','topic3'};
            List<Topic> topics = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{
                'NetworkId' => networkIds[0],
                    'name' => titleNames}, 'Topic');
        System.debug('>>>topics'+topics);
        System.debug('>>>networkNames'+networkNames);
        //create custom setting AncestrySFSC_CategoryMapping__c       
        createDataCategoryCustomSetting();
        //create article with data category      
        creatArticle();
        //create article without data category      
        creatArticleWithoutDataCategory();
        
        createContactUsAsso(networkIds,topics);
        
        Test.startTest();
        
        //Test article with date category
        String urlArticle='/s/article/Title1';            
        List<Contact_Us_Configurations__c> confsArticle = AncestrySFSC_ContactUsController.getContactUsConfs(urlArticle);             
        System.assertEquals(confsArticle.size(), 0);
        
        //Test article without date category
        String urlArticleWithoutDateCategory='/s/article/Title4';            
        List<Contact_Us_Configurations__c> confsArticleWithoutDateCategory = AncestrySFSC_ContactUsController.getContactUsConfs(urlArticleWithoutDateCategory);             
        System.assertEquals(confsArticleWithoutDateCategory.size(), 3);
        
        Test.stopTest();
    }
    @IsTest
    public static void testAncestrySFSC_ContactUsChannelOrder() {
        List<String> networkIds = new  List<String>();    
        List<String> networkNames = new  List<String>();    
        
        for(Network n: [Select Id,name from Network limit 1]){
            networkIds.add(n.id);
            networkNames.add(n.name);
        }
        List<String> titleNames = new List<String>{'topic1','topic2','topic3'};
            List<Topic> topics = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{
                'NetworkId' => networkIds[0],
                    'name' => titleNames}, 'Topic');
        System.debug('>>>topics'+topics);
        System.debug('>>>networkNames'+networkNames);
        
        createContactUsAssoDesc(networkIds,topics);
        User u = AncestrySFSC_TestUtil.prepareUser('person@test2.com');
        //get the network membership to get the correct network ID
        System.runAs(u){
            
            Test.startTest();
            
            String url='/s/';
            List<Contact_Us_Configurations__c> confs = AncestrySFSC_ContactUsController.getContactUsConfs(url); 
            System.assertEquals(confs.size(), 3);
            System.assertEquals(confs[2].Configuration_Type__c, 'Live Chat'); 
            System.assertEquals(confs[1].Configuration_Type__c, 'Case');
            System.assertEquals(confs[0].Configuration_Type__c, 'Phone');
            Test.stopTest();
        }
    }
    private static void createContactUsAsso(List<String> networkNames, List<Topic> topics){
        List<Contact_Us_Setting__c> settings = createContactUSSetting(networkNames, topics);
        List<Contact_Us_Configurations__c> configurations = createContactUSConfigurations(networkNames);
        List<Contact_Us_Association__c> assos =  new List<Contact_Us_Association__c>();
        
        for(Contact_Us_Setting__c setting: settings){
            Integer index=1;
            for(Contact_Us_Configurations__c conf: configurations){
                
                Contact_Us_Association__c asso = new Contact_Us_Association__c();
                asso.Contact_Us_Configuration__c = conf.id;
                asso.Contact_Us_Setting__c =setting.Id;
                asso.Sequence__c =index;
                index++;
                assos.add(asso);
            }
        }
        insert assos;
        System.debug('>>>assos'+assos);
    }
    private static void createContactUsAssoDesc(List<String> networkNames, List<Topic> topics){
        List<Contact_Us_Setting__c> settings = createContactUSSetting(networkNames, topics);
        List<Contact_Us_Configurations__c> configurations = createContactUSConfigurations(networkNames);
        List<Contact_Us_Association__c> assos =  new List<Contact_Us_Association__c>();
        
        for(Contact_Us_Setting__c setting: settings){
            Integer index=3;
            for(Contact_Us_Configurations__c conf: configurations){
                
                Contact_Us_Association__c asso = new Contact_Us_Association__c();
                asso.Contact_Us_Configuration__c = conf.id;
                asso.Contact_Us_Setting__c =setting.Id;
                asso.Sequence__c =index;
                index--;
                assos.add(asso);
            }
        }
        insert assos;
        System.debug('>>>assos'+assos);
    }
    private static List<Contact_Us_Setting__c> createContactUSSetting(List<String> networkNames, List<Topic> topics){
        //List<ID> topicIds = new List<ID>{topics[0].id,null,null,null,topics[2].id,null};
        List<String> topicNames = new List<String>{topics[0].name,null,null,null,topics[2].name,null};
            
            List<String> pageNames = new List<String>{'Topic Detail','Article Detail','Question Detail','General Search','Topic Search','Home'};
                List<String> settingNames = new List<String>{'Topic Setting','Article Setting','Question Setting','General Search Setting' ,'Topic Search Setting','Home Setting'};
                    List<Contact_Us_Setting__c> settings = AncestrySFSC_TestUtil.createSobjects(6, true, new Map<String, Object>{
                        'Name'=>settingNames,            
                            'Community_Topic__c' => topicNames,
                            'Page_Name__c' => pageNames,
                            'Community__c' => 'AncestrySupport'}, 'Contact_Us_Setting__c');
        return settings;
        
    }
    private static List<Contact_Us_Configurations__c> createContactUSConfigurations(List<String> networkNames){
        List<String> names = new List<String>{'Live Chat 1','Case 1','Phone 1'};
            List<String> ConfigurationTypes = new List<String>{'Live Chat','Case','Phone'};
                List<String> OptionSubTexts = new List<String>{'live chat sub text','Case sub text','Phone sub text'};
                    List<String> OptionLinks = new List<String>{'','https://fulltest-ancestry.cs21.force.com/s/contactsupport','https://support.ancestry.com/s/phonesupport'};
                        List<String> OptionLinkTargets = new List<String>{'','_blank','_self'};
                            List<String> OptionLinkTexts= new List<String>{'Chat Now','Contact Support','View regional numbers and TTY details'};
                                List<String> OptionLabels = new List<String>{'Chat with our Agent directly','Create a case form','Call us at 1-800-401-1601'};
                                    List<String> Icons = new List<String>{'fa-commenting','fa-phone-square','fa-phone-square'};
                                        List<String> LiveChatOrgIds = new List<String>{'00D17000000BSOP','',''};
                                            List<String> LiveChatInitialLinks = new List<String>{'https://d.la3-c2cs-was.salesforceliveagent.com/chat','',''};
                                                List<String> LiveChatDeploymentIds = new List<String>{'57215000000TTbD','',''};
                                                    List<String> LiveChatButtonIds = new List<String>{'573170000008OaV','',''};
                                                        
                                                        List<Contact_Us_Configurations__c> configurations = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{
                                                            'Name'=> names,
                                                                'Option_Sub_Text__c'=>OptionSubTexts,            
                                                                'Option_Link__c' => OptionLinks,
                                                                'Option_Link_Target__c' => OptionLinkTargets,
                                                                'Option_Link_Text__c' => OptionLinkTexts,
                                                                'Option_Label__c' => OptionLabels,
                                                                'LiveChatOrgId__c' => LiveChatOrgIds,
                                                                'LiveChatInitialLink__c' => LiveChatInitialLinks,
                                                                'LiveChatDeploymentId__c' => LiveChatDeploymentIds,
                                                                'LiveChatButtonId__c' => LiveChatButtonIds,
                                                                'Icon__c' => Icons,
                                                                'Configuration_Type__c' => ConfigurationTypes,
                                                                'Community__c' =>'AncestrySupport'
                                                                
                                                                }, 'Contact_Us_Configurations__c');
        return configurations;
    }
    
    private static void creatArticle(){
        
        
        List<String> titles = new List<String>{'Title1','Ttile2','Title3'};
            List<String> urlNames = new List<String>{'Title1','Ttile2','Title3'};
                List<Support_Site__kav> supportSites = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{'Title' => titles,
                    'Language' => 'en_US',
                    'UrlName'=> urlNames,
                    'IsVisibleInPkb' => true,
                    'IsVisibleInPrm'=> true}, 'Support_Site__kav');
        supportSites = [SELECT Id, KnowledgeArticleId FROM Support_Site__kav WHERE Id IN :supportSites];
        System.debug('>>>>supportSites size'+supportSites.size());
        for (Support_Site__kav dArticle : supportSites) {
            String articleId =  dArticle.KnowledgeArticleId;
            try{
                KbManagement.PublishingService.publishArticle(articleId, true);  
            }
            catch(exception e){
                //nothing to do here, draft existed 
            }          
            
        }
        List<Support_Site__kav> publishedSupportSites = [SELECT id,UrlName  FROM Support_Site__kav where UrlName in :titles and PublishStatus='Online' and Language='en_US'];
        System.debug('>>>publishedSupportSites' + publishedSupportSites);
        
        List<String> parentIds = new List<String>{publishedSupportSites[0].id,publishedSupportSites[1].id,publishedSupportSites[2].id};
            List<String> categoryNames = new List<String>{'Accounts_Billing','Member_Trees','Search_Records'};
                
                List<Support_Site__DataCategorySelection> supportSiteDataCategories = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{'ParentId' => parentIds,
                    'DataCategoryName' => categoryNames,
                    'DataCategoryGroupName' => 'Support_Site'}, 'Support_Site__DataCategorySelection');
        System.debug('>>>supportSiteDataCategories' + supportSiteDataCategories);
        
        
    } 
    private static void creatArticleWithoutDataCategory(){
        
        
        List<String> titles = new List<String>{'Title4','Ttile5','Title6'};
            List<String> urlNames = new List<String>{'Title4','Ttile5','Title6'};
                List<Support_Site__kav> supportSites = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{'Title' => titles,
                    'Language' => 'en_US',
                    'UrlName'=> urlNames,
                    'IsVisibleInPkb' => true}, 'Support_Site__kav');
        List<String> parentIds = new List<String>{supportSites[0].id,supportSites[1].id,supportSites[2].id};
            
            supportSites = [SELECT Id, KnowledgeArticleId FROM Support_Site__kav WHERE Id IN :supportSites];
        System.debug('>>>>supportSites size'+supportSites.size());
        for (Support_Site__kav dArticle : supportSites) {
            String articleId =  dArticle.KnowledgeArticleId;
            try{
                KbManagement.PublishingService.publishArticle(articleId, true);  
            }
            catch(exception e){
                //nothing to do here, draft existed 
            }          
            
        }
        
    } 
    
    private static void createDataCategoryCustomSetting(){
        
        List<String> names = new List<String>{'DC000001','DC000002','DC000003'};
            List<String> categoryApiNames = new List<String>{'Accounts_Billing','Member_Trees','Search_Records'};
                List<String> categoryLableNames = new List<String>{'Accounts & Billing','Member Trees','Search Records'};
                    
                    List<String> titleNames = new List<String>{'topic1','topic2','topic3'};
                        List<String> communityName = new List<String>();
        
        for(Network n: [Select Id, name from Network limit 1]){
            communityName.add(n.name);
        }  
        List<AncestrySFSC_CategoryMapping__c> supportSites = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{
            'Name' => names,
                'Language_Code__c' => 'en_US',
                'Data_Category_Group__c' => 'Support_Site',
                'Data_Category_API_Name__c'=> categoryApiNames,
                'Data_Category__c'=> categoryLableNames,
                'Community_Topic__c' => titleNames,
                'Community_Name__c' => communityName[0]}, 'AncestrySFSC_CategoryMapping__c');
        
    }
    
}