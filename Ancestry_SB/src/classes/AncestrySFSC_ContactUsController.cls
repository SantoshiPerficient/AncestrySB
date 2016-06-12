/*************************************************
Class: AncestrySFSC_ContactUsController.cls
Description: controller class for AncestrySFSC_ContactUs lightning component
Auther: JoJo Zhao(Perficient)
Date:   5/24/2016

Revision History:
----------------------------------------------------
***************************************************/ 
public class AncestrySFSC_ContactUsController {
    private static String ARTICLE_URL_PREFIX = 'article';
    
    private static Set<String> PREFIX_SET = new Set<String>{'home','topic','article','search','question'};
        @AuraEnabled
        public static List<Contact_Us_Configurations__c> getContactUsConfs(String url){
            System.debug('>>>url' + url); 
            Contact_Us_Setting__c currentContactUsSetting = getContactUsSettingForURl(url);
            Set<Id> configureIds = new  Set<Id>();
            Map<Id,Decimal> configureIdsWithSequence = new Map<Id,Decimal>();
            Map<Id,Contact_Us_Configurations__c> configureIdsWithObject = new Map<Id,Contact_Us_Configurations__c>();
            
            List<Contact_Us_Configurations__c> orderedChannels = new List<Contact_Us_Configurations__c> ();
            if(currentContactUsSetting!=null){
                for(Contact_Us_Association__c cua:[Select Sequence__c, Contact_Us_Configuration__c 
                                                   From Contact_Us_Association__c
                                                   where Contact_Us_Setting__c = :currentContactUsSetting.id  and IsDeleted = false
                                                   order by Sequence__c]){
                                                       configureIds.add(cua.Contact_Us_Configuration__c);
                                                       configureIdsWithSequence.put(cua.Contact_Us_Configuration__c,cua.Sequence__c);
                                                   }
                List<Contact_Us_Configurations__c> channels = [Select id, Option_Sub_Text__c, Option_Link__c,Option_Link_Target__c,
                                                               Option_Link_Text__c, Option_Label__c, Name, LiveChatOrgId__c, 
                                                               LiveChatInitialLink__c, LiveChatDeploymentId__c, LiveChatButtonId__c, 
                                                               Icon__c, Configuration_Type__c 
                                                               From Contact_Us_Configurations__c where id in :configureIds];
                for(Contact_Us_Configurations__c c:channels){
                    configureIdsWithObject.put(c.id, c);
                }
                for(Id cId:configureIdsWithSequence.keySet()){
                    orderedChannels.add(configureIdsWithObject.get(cId));
                }
                
                return orderedChannels;
            }else{
                return new List<Contact_Us_Configurations__c>();
            }
        }
    
    private static Contact_Us_Setting__c getContactUsSettingForURl(String url){
        if(url!=null && url.length()>0){
            String prefixType=null;
            Id topicId = null;  
            Set<String> topicNameSet = new Set<String>();
            
            Integer index = url.indexOf('/s/');
            if(index>-1){
                url = url.substring(index);
                String currentNetworkName = getCurrentNetworkName();
                if(url=='/s/'){
                    prefixType = 'home';
                }else{
                    String[] pathList = url.split('/');
                    
                    System.debug('>>>url pathList' + pathList);
                    if(pathList.size()>=4){
                        prefixType=pathList[2];
                        
                        Boolean isValidId = true;
                        try {
                            if(pathList[2] == ARTICLE_URL_PREFIX){                               
                                // Map<String, AncestrySFSC_CommunityToLocaleMap__c> mcs = AncestrySFSC_CommunityToLocaleMap__c.getAll();
                                // String languageName = mcs.get(currentNetworkName).Language__c;
                                
                                Map<String, String> mcs = new Map<String, String> ();
                                for(AncestrySFSC_CategoryMapping__c cusSetting : [Select Community_Name__c, Language_Code__c 
                                                                                  from AncestrySFSC_CategoryMapping__c]){
                                                                                      mcs.put(cusSetting.Community_Name__c, cusSetting.Language_Code__c);
                                                                                  } 
                                String languageName = mcs.get(currentNetworkName);
                                
                                Set<String> dcNameSet = new Set<String>();
                                Set<Id> sskIds = new Set<Id>();
                                String queryString = 'SELECT id FROM Support_Site__kav where UrlName=\''+pathList[3]+'\' and PublishStatus=\'Online\' and Language=\''+languageName+'\'';
                                List<Support_Site__kav> ssks = Database.query(queryString);
                                for(Support_Site__kav ssk : ssks){
                                    sskIds.add(ssk.id);
                                }
                                
                                for(Support_Site__DataCategorySelection dc: [SELECT DataCategoryName,Id FROM Support_Site__DataCategorySelection where parentId in :sskIds]){
                                    dcNameSet.add(dc.DataCategoryName);
                                }
                                //get all date category mapped topic name                                
                                for(AncestrySFSC_CategoryMapping__c tName:  [SELECT Community_Topic__c from AncestrySFSC_CategoryMapping__c where Community_Name__c=:currentNetworkName and Data_Category_API_Name__c in :dcNameSet]){
                                    topicNameSet.add(tName.Community_Topic__c);
                                }
                            }else{
                                topicId = (ID) pathList[3];
                                
                                if( topicId.getSObjectType()!=topic.sObjectType){
                                    topicId=null;
                                }else{
                                    Topic t=[Select name from topic where id= :topicId];
                                    if(t!=null){
                                        topicNameSet.add(t.name);
                                    }
                                }
                            } 
                        }
                        catch (Exception e) {
                            System.debug(e.getMessage());
                            isValidId = false;
                        }
                        
                    }
                }
                
                if(prefixType!=null && PREFIX_SET.contains(prefixType.toLowerCase())){            
                    
                    try{
                        List<Contact_Us_Setting__c> contactUsSetting = new List<Contact_Us_Setting__c>();
                        if(topicNameSet!=null && topicNameSet.size()==0){
                            topicNameSet=null;
                        }
                        contactUsSetting =[Select Id, Community_Topic__c, Page_Name__c, 
                                           PageURLPrefix__c, Name, Community__c 
                                           From Contact_Us_Setting__c where PageURLPrefix__c = :prefixType 
                                           and Community__c=:currentNetworkName and Community_Topic__c in :topicNameSet limit 1];
                        
                        if(contactUsSetting!=null && contactUsSetting.size()>0){
                            return contactUsSetting[0];
                        }
                        
                    }catch(Exception e){
                        System.debug(e.getMessage());
                    }
                } 
            }
        }
        return null;
    }
    
    
    private static String getCurrentNetworkName(){
        
        try{
            String networkId = Network.getNetworkId();
            if(Test.isRunningTest()){
                
                NetworkMember membership = [SELECT networkID, memberID FROM NetworkMember WHERE memberID = :Userinfo.getUserId() limit 1];
                networkId = membership.NetworkId;
                System.debug('>>>Test networkId'+networkId);
                if(networkId==null){
                    Network n = [Select Id,name from Network limit 1];
                    networkId=n.id;
                }
            }
            Network currentNetwork = [select name from network where id = :networkId];
            if(currentNetwork!=null){
                return currentNetwork.name;
            }
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        return null;
    }
}