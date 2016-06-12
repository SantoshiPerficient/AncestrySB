/*************************************************
Class: AncestrySFSC_DefaultEmailTemplateHandler.cls
Description: set the email template ID in the Case Email Action.
Auther: Lisa Cheng
Date:   2/16/2016

Revision History:
----------------------------------------------------
Set the email template ID in the Case Email Action - Lisa Cheng 2/16/2016
Fetch Email template from certain folder which is defined in custom label - JoJo Zhao 4/4/2016
***************************************************/
global class AncestrySFSC_DefaultEmailTemplateHandler implements QuickAction.QuickActionDefaultsHandler{
    global AncestrySFSC_DefaultEmailTemplateHandler(){
    }
    
    global void onInitDefaults(QuickAction.QuickActionDefaults[] defaults) {
        QuickAction.SendEmailQuickActionDefaults sendEmailDefaults = null;
         // Check if the quick action is the standard Case Feed send email action
        for (Integer j = 0; j < defaults.size(); j++) {
            if (defaults.get(j) instanceof QuickAction.SendEmailQuickActionDefaults &&
               defaults.get(j).getTargetSObject().getSObjectType() == EmailMessage.sObjectType &&
               defaults.get(j).getActionName().equals('Case.Email') && defaults.get(j).getActionType().equals('Email')) {
                   sendEmailDefaults = (QuickAction.SendEmailQuickActionDefaults)defaults.get(j);
                   break;
            }
        }
        if (sendEmailDefaults != null) {
            String userId = UserInfo.getUserId();
            User currentUser = [select id,Email_Template__c from user where id =:userId];  
            System.debug('>>>currentUser:'+currentUser );
            Id templateId = getTemplateIdHelper(currentUser.Email_Template__c);
            if(templateId != null){
                sendEmailDefaults.setTemplateId(templateId);
                sendEmailDefaults.setInsertTemplateBody(false);
                sendEmailDefaults.setIgnoreTemplateSubject(true);
                System.debug('>>>sendEmailDefaults:'+sendEmailDefaults);
            }
        }

    }
    private Id getTemplateIdHelper(String templateName) {
        Id templateId = null;
        Id folderId = null;
        try {
            folderId = [select id, name from folder  where developerName= : Label.AncestrySFSC_UserEmailTemplateFolder_DeveloperName].id;
            
            templateId = [select id, name from EmailTemplate where name= : templateName and folderId=: folderId].id;  
        } catch (Exception e) {
            system.debug('Unble to locate EmailTemplate using name: ' + templateName + ' refer to Setup | Communications Templates '+ templateName);
        }
        return templateId;
    }
}