public class AncestrySFSC_EmptyCategoryArticleCtr {
    public Map<Id, Set<String>> getArticleCategoryMap(){
      		List<Support_Site__kav> RecentlyPublishedSupportSiteCollection =  getPublishedArticle();
              Map<Id, Set<String>> articleCategoryMap = new Map<Id, Set<String>>();
            Map<Id, String> articleLanguageMap = new Map<Id, String>();
         setArticleMap(RecentlyPublishedSupportSiteCollection, articleCategoryMap,articleLanguageMap);
        return articleCategoryMap;
    }
    
    public List<Support_Site__kav> getPublishedArticle(){
        
         DateTime orgDateTime = System.now();
        Integer articlePublishBeforeMintues = Integer.valueOf(Label.AncestrySFSC_ArticlePublishBeforeMintues);
        
        System.debug('>>>:orgDateTime.addMinutes(-'+articlePublishBeforeMintues+') '+orgDateTime.addMinutes(-articlePublishBeforeMintues));
        
        try
        {
            //Find article which is publish recently
            List<Support_Site__kav> RecentlyPublishedSupportSiteCollection =[Select Id,Language,KnowledgeArticleId,MasterVersionId  FROM Support_Site__kav
                                                                             WHERE  LastPublishedDate >= :orgDateTime.addMinutes(-articlePublishBeforeMintues) 
                                                                             AND LastPublishedDate <= :orgDateTime 
                                                                             AND PublishStatus = 'Online' 
                                                                             AND (IsVisibleInPkb = true or IsVisibleInCsp = true)
                                                                             AND KnowledgeArticleId in (Select ParentId From Support_Site__VersionHistory  s where (EventType ='KavPublished' or EventType='KavPublishedNew')  
                                                                                        and ParentSobjectType='Support_Site' AND CreatedDate >= :orgDateTime.addMinutes(-articlePublishBeforeMintues) 
                                                                                        AND CreatedDate <= :orgDateTime)];
            System.debug('>>>>RecentlyPublishedSupportSiteCollection1' + RecentlyPublishedSupportSiteCollection);
            return RecentlyPublishedSupportSiteCollection;
        }
        catch(Exception ex)
        {
            System.debug(ex);
            return null;
        }  
    }
    
    public void  setArticleMap(List<Support_Site__kav> RecentlyPublishedSupportSiteCollection, 
                               Map<Id, Set<String>> articleCategoryMap,
                               Map<Id, String> articleLanguageMap){
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
            
           
            for(Support_Site__kav s:RecentlyPublishedSupportSiteCollection){
                articleCategoryMap.put(s.id, articleKaCategoryMap.get(s.MasterVersionId)==null? new Set<String>() :  articleKaCategoryMap.get(s.MasterVersionId));
                
                articleLanguageMap.put(s.id, s.Language);
            }
            
            System.debug('>>>>articleLanguageMap' + articleLanguageMap);
            System.debug('>>>>articleCategoryMap' + articleCategoryMap);
    }
    
}