public class AncestrySFSC_ServiceProc
{
    public static void assignTopicToArticleProcess(List<Support_Site__kav> RecentlyPublishedSupportSiteCollection){
        try
        {
            Set<Id> marterVersionIDSet= new Set<Id>();
            Map<Id, Support_Site__kav>  articleMap = new Map<Id, Support_Site__kav> ();
            for(Support_Site__kav s:RecentlyPublishedSupportSiteCollection){
                marterVersionIDSet.add(s.MasterVersionId);
            }
            List<Support_Site__DataCategorySelection> categoryCollection = new List<Support_Site__DataCategorySelection>();
            
            categoryCollection = [Select  Id,ParentId, DataCategoryName,DataCategoryGroupName 
                                  From Support_Site__DataCategorySelection 
                                  where ParentId in :marterVersionIDSet];
            Map<Id, Set<String>> articleKaCategoryMap = new Map<Id, Set<String>>();
            
            for(Support_Site__DataCategorySelection supportSiteArticleCategory: categoryCollection){
                if(articleKaCategoryMap.get(supportSiteArticleCategory.parentId)==null){
                    articleKaCategoryMap.put(supportSiteArticleCategory.parentId, new Set<String>{supportSiteArticleCategory.DataCategoryName});
                    
                }else{
                    
                    articleKaCategoryMap.get(supportSiteArticleCategory.parentId).add(supportSiteArticleCategory.DataCategoryName);
                }
                
            }     
            
            Map<Id, Set<String>> articleCategoryMap = new Map<Id, Set<String>>();
            Map<Id, String> articleLanguageMap = new Map<Id, String>();
            for(Support_Site__kav s:RecentlyPublishedSupportSiteCollection){
                articleCategoryMap.put(s.id, articleKaCategoryMap.get(s.MasterVersionId));
                
                articleLanguageMap.put(s.id, s.Language);
            }
            
            System.debug('>>>>articleLanguageMap' + articleLanguageMap);
            System.debug('>>>>articleCategoryMap' + articleCategoryMap);
            
            if(articleLanguageMap!=null && articleLanguageMap.size()>0){
                Map<String, Map<String, Topic>> topicNetWorkNameIdMap = getTopicNetWorkNameIdMap();
                Map<String, Network> networkMap =  getNetworkMap();
                System.debug('>>>>networkMap' + networkMap);
                List<TopicAssignment> topicAssigns = new List<TopicAssignment>();
                Map<String, List<AncestrySFSC_CategoryMapping__c>> categoryLanguageMapping  = getCategoryMapCustomSetting();
                
                for(Id articleId: articleLanguageMap.keySet()){
                    String languageType = articleLanguageMap.get(articleId);
                    System.debug('>>>>languageType' + languageType);
                    
                    Set<String> categoryTypes = articleCategoryMap.get(articleId);
                    System.debug('>>>>categoryTypes'+categoryTypes);
                    List<Topic> newTopics = new List<Topic>();
                    List<Topic> topicList = new List<Topic>();
                    if(categoryTypes!=null && categoryTypes.size()>0){
                        for(String categoryName : categoryTypes){
                            List<AncestrySFSC_CategoryMapping__c> categoryMappings = categoryLanguageMapping.get(categoryName+'_'+languageType);
                            if(categoryMappings!=null){
                                for(AncestrySFSC_CategoryMapping__c c: categoryMappings){
                                    String topicName = c.Community_Topic__c;
                                    String lowerCaseTopicName= topicName.toLowerCase();
                                    System.debug('>>>>c.Community_Name__c' + c.Community_Name__c);
                                    if(networkMap.get(c.Community_Name__c)!=null){
                                        String networkId = networkMap.get(c.Community_Name__c).id;
                                        Topic t;
                                        if(topicNetWorkNameIdMap.get(networkId)!=null)
                                            t =  topicNetWorkNameIdMap.get(networkId).get(lowerCaseTopicName);
                                        System.debug('>>>>t'+t);
                                        
                                        if(t==null){
                                            //create a topic for this language category
                                            t = new Topic();
                                            t.Name=topicName;
                                            t.Description='create topic:'+topicName +' with community:' +c.Community_Name__c;
                                            t.NetworkId = networkId;
                                            newTopics.add(t);
                                        }
                                        topicList.add(t); 
                                    }
                                }
                            }
                        }
                    }
                    System.debug('>>>>newTopics'+newTopics);
                    if(newTopics!=null && newTopics.size()>0){
                        insert newTopics;
                        topicNetWorkNameIdMap = getTopicNetWorkNameIdMap();
                    }
                    for(Topic t : topicList){
                        if(t!=null && t.Id!=null){
                            TopicAssignment topicAssign = new TopicAssignment();
                            topicAssign.EntityId=articleId;
                            topicAssign.NetworkId =t.Networkid;                        
                            topicAssign.TopicId = t.Id;
                            topicAssigns.add(topicAssign);
                        }
                    }
                }
                
                System.debug('>>>topicAssigns'+ topicAssigns);
                if(topicAssigns!=null && topicAssigns.size()>0){
                    insert topicAssigns;
                }
            }
        }
        catch(Exception ex)
        {
            System.debug('>>>3'+ex);
        } 
        try
        {
            //drop archived topicassignment
            List<Support_Site__kav>  unAssignTopicArticles=[Select id From Support_Site__kav s where id 
                                                            in (Select t.EntityId From TopicAssignment t) and s.PublishStatus!='Online'];
            Set<Id> unAssignTopicArticleIds= new Set<Id>();
            for(Support_Site__kav s:unAssignTopicArticles){
                unAssignTopicArticleIds.add(s.id);
            }
            List<TopicAssignment> dropTopicAssign = [Select id from topicAssignment where EntityId 
                                                     in :unAssignTopicArticleIds];
            System.debug('>>>dropTopicAssign'+ dropTopicAssign);
            if(dropTopicAssign!=null && dropTopicAssign.size()>0){
                delete dropTopicAssign;
            }
            
        }
        catch(Exception ex)
        {
            System.debug('>>>2'+ex);
        } 
    }
    private static Map<String, Network> getNetworkMap(){
        List<Network> networkList = [select Id, name from network];
        System.debug('>>>networkList'+networkList);
        Map<String, Network> networkNameIdMap = new Map<String, Network>();
        for(Network net:networkList){
            networkNameIdMap.put(net.name, net);
        } 
        return networkNameIdMap;
    }
    
    private static Map<String, Map<String, Topic>> getTopicNetWorkNameIdMap(){
        List<Topic> topics = [Select NetworkId, Name,Id From Topic];
        Map<String, Map<String, Topic>> topicNetWorkNameIdMap = new Map<String, Map<String, Topic>>();
        
        for(Topic t: topics){
            String lowerCaseTopicName= t.Name.toLowerCase();
            if(topicNetWorkNameIdMap.get(t.NetworkId)==null){
                topicNetWorkNameIdMap.put(t.NetworkId, new Map<String, Topic>{lowerCaseTopicName=>t});
            }else{
                topicNetWorkNameIdMap.get(t.NetworkId).put(lowerCaseTopicName, t);
            }
        }
        System.debug('>>>topicNetWorkNameIdMap'+topicNetWorkNameIdMap);
        return topicNetWorkNameIdMap;
    }
    
    
    private static Map<String, List<AncestrySFSC_CategoryMapping__c>> getCategoryMapCustomSetting(){
        List<AncestrySFSC_CategoryMapping__c> categoryMappingList =  [Select a.SystemModstamp, a.SetupOwnerId, a.Name, a.LastModifiedDate, 
                                                                      a.LastModifiedById, a.Language_Code__c, a.IsDeleted, a.Id, 
                                                                      a.Data_Category__c, a.Data_Category_Group__c, a.Data_Category_API_Name__c, 
                                                                      a.CreatedDate, a.CreatedById, a.Community_Topic__c, a.Community_Name__c, 
                                                                      a.Article_Language__c From AncestrySFSC_CategoryMapping__c a];
        Map<String, List<AncestrySFSC_CategoryMapping__c>> categoryLanguageMapping = new Map<String, List<AncestrySFSC_CategoryMapping__c>>();
        for(AncestrySFSC_CategoryMapping__c c: categoryMappingList) {
            String key = c.Data_Category_API_Name__c+'_'+c.Language_Code__c;
            if(categoryLanguageMapping.get(key)==null){
                categoryLanguageMapping.put(key, new List<AncestrySFSC_CategoryMapping__c>{c});
            }else{
                categoryLanguageMapping.get(key).add(c);
            }
        }    
        System.debug('>>>categoryLanguageMapping'+categoryLanguageMapping);
        return categoryLanguageMapping;
    }
}