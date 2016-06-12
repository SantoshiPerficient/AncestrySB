@IsTest
public class AncestrySFSC_TopicAssignToArticleTest {
    @IsTest
    public static void testAncestrySFSC_TopicAssignToArticle() {
        createTopics();
        createDataCategoryCustomSetting();
        creatArticle();
        creatArticleWithoutDataCategory();
        Test.startTest();
        AncestrySFSC_ServiceAgent serviceAgent = new AncestrySFSC_ServiceAgent();
        serviceAgent.ExecuteBusinessProcs(); 
        List<TopicAssignment> topicAssigns =  [Select Id from TopicAssignment];
        System.assert(topicAssigns.size()>0);
        Test.stopTest();
    }
    private static void creatArticle(){
        
        
        List<String> titles = new List<String>{'Title1','Ttile2','Title3'};
            List<String> urlNames = new List<String>{'Title1','Ttile2','Title3'};
                List<Support_Site__kav> supportSites = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{'Title' => titles,
                    'Language' => 'en_US',
                    'UrlName'=> urlNames,
                    'IsVisibleInPkb' => true}, 'Support_Site__kav');
        List<String> parentIds = new List<String>{supportSites[0].id,supportSites[1].id,supportSites[2].id};
            List<String> categoryNames = new List<String>{'Accounts_Billing','Member_Trees','Search_Records'};
                
                List<Support_Site__DataCategorySelection> supportSiteDataCategories = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{'ParentId' => parentIds,
                    'DataCategoryName' => categoryNames,
                    'DataCategoryGroupName' => 'Support_Site'}, 'Support_Site__DataCategorySelection');
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
    private static void createTopics(){
        
        List<String> networkIds = new  List<String>();    
        List<String> titleNames = new List<String>{'topic1','topic2','topic3'};
            for(Network n: [Select Id from Network limit 1]){
                networkIds.add(n.id);
            }
        
        List<Topic> topics = AncestrySFSC_TestUtil.createSobjects(3, true, new Map<String, Object>{
            'NetworkId' => networkIds[0],
                'name' => titleNames}, 'Topic');
        
    }
    @isTest
    public static void testSchedulableClass(){
        // CRON expression: midnight on March 15.
        // Because this is a test, job executes
        // immediately after Test.stopTest().
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduleApexClassTest',
                                       CRON_EXP,
                                       new AncestrySFSC_ServiceAgentSchedular());
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered,
                          NextFireTime
                          FROM CronTrigger WHERE id = :jobId];
        // Verify the expressions are the same
        System.assertEquals(CRON_EXP,
                            ct.CronExpression);
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        // Verify the next time the job will run
        System.assertEquals('2022-03-15 00:00:00',
                            String.valueOf(ct.NextFireTime));
        // Verify the scheduled job hasn't run yet.
        
        Test.stopTest();
        // Now that the scheduled job has executed after Test.stopTest(),
        //   fetch the new merchandise that got added.
    }
     @IsTest
    public static void testAncestrySFSC_ArticleCategoryCheck() {
        createTopics();
        createDataCategoryCustomSetting();
        creatArticle();
        Test.startTest();
        AncestrySFSC_EmptyCategoryArticleCtr ctrl = new AncestrySFSC_EmptyCategoryArticleCtr();
        Map<Id, Set<String>> articleCategoryMap = ctrl.getArticleCategoryMap(); 
       
        System.assert(articleCategoryMap.size()>0);
        Test.stopTest();
    }
}