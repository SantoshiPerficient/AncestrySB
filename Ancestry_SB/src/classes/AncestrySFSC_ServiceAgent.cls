public class AncestrySFSC_ServiceAgent
{
    public void ExecuteBusinessProcs()
    {
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
            AncestrySFSC_ServiceProc.assignTopicToArticleProcess(RecentlyPublishedSupportSiteCollection);
        }
        catch(Exception ex)
        {
            System.debug(ex);
        }  
    }
}