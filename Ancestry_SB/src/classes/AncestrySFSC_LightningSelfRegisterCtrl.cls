global class AncestrySFSC_LightningSelfRegisterCtrl {

    public AncestrySFSC_LightningSelfRegisterCtrl() {

    }

    private static boolean isValidPassword(String password, String confirmPassword) {
        return password == confirmPassword;
    }
    
    private static boolean siteAsContainerEnabled(Id networkId) {
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(networkId,'');
        return authConfig.isCommunityUsingSiteAsContainer();
    }
    
    private static void validatePassword(User u, String password, String confirmPassword) {
    System.debug('>>>user:'+u);
        if(Test.isRunningTest()){
                return;
            }
        Site.validatePassword(u, password, confirmPassword);
        return;
    }
    
    @AuraEnabled
    public static String selfRegister(String firstname ,String lastname, String email, String password, String confirmPassword, String accountId, String regConfirmUrl, String extraFields, String startUrl, Boolean includePassword) {
       System.debug('>>>Into SelfRegister Aura method' + accountId);
        Savepoint sp = null;
        try {
            sp = Database.setSavepoint();
            
            if (lastname == null || String.isEmpty(lastname)) {
                return Label.Site.lastname_is_required;
            }
            
            if (email == null || String.isEmpty(email)) {
                return Label.Site.email_is_required;
            }
            
            User u = new User();
            u.Username = email;
            u.put('Email',email);
            
            u.FirstName = firstname;
            u.LastName = lastname;
            
            String networkId = Network.getNetworkId();
            if(Test.isRunningTest()){
                networkId = [select id from network where name like 'Ancestry%' limit 1].id;
            }
            System.debug('>>>netwrokId:'+networkId);
            // If using site to host the community the user should not hit s1 after logging in from mobile.
            if(networkId != null && siteAsContainerEnabled(networkId)) {
                u.put('UserPreferencesHideS1BrowserUI',true);
            }
            //If using site to host the community the user should populate the locale information 
            if(networkId != null){
                Network network = [select name from network where id =: networkId];
                System.debug('>>>netwrokName:'+network.name);
                Map<String, AncestrySFSC_CommunityToLocaleMap__c> mcs = AncestrySFSC_CommunityToLocaleMap__c.getAll();
                if(mcs.containsKey(network .name)){
                    u.put('TimeZoneSidKey',mcs.get(network.name).Time_Zone__c);
                    u.put('LocaleSidKey',mcs.get(network.name).Locale__c);
                    u.put('LanguageLocaleKey',mcs.get(network.name).Language__c);
                    
                }
            }
            String nickname = ((firstname != null && firstname.length() > 0) ? firstname.trim() : '' ) + ' ' + lastname.substring(0,1);
            List<User> users = [Select Id from user where CommunityNickname= :nickname];
            if(users!=null && users.size()>0){
            	nickname += String.valueOf(Crypto.getRandomInteger()).substring(1,3);
            }
          
            u.put('CommunityNickname', nickname);
                     
            if (extraFields != null) {
                List<Object> extraFieldsList = (List<Object>) JSON.deserializeUntyped(extraFields);
                for (Object thisFieldObject : extraFieldsList) {
                    Map<String,Object> thisField = (Map<String,Object>) thisFieldObject;
                    Schema.SObjectField sof = Schema.SObjectType.User.fields.getMap().get((String) thisField.get('fieldPath'));
                    u.put(sof, thisField.get('value'));
                }
            }
                        
            if (includePassword) {    
                if (!isValidPassword(password, confirmPassword)) {
                    return Label.site.passwords_dont_match;
                }
                validatePassword(u, password, confirmPassword);
            }
            else {
                password = null;
            }
            
            // lastName is a required field on user, but if it isn't specified, we'll default it to the username
            String userId = Site.createPortalUser(u, accountId, password);
                System.debug('>>>userId :'+userId);
            if (userId != null) { 
                System.debug('>>>password:'+password);
                if (password != null && password.length() > 1) {
                    ApexPages.PageReference lgn = Site.login(email, password, startUrl);
                    aura.redirect(lgn);
                }
                else {
                    ApexPages.PageReference confirmRef = new PageReference(regConfirmUrl);
                    aura.redirect(confirmRef);
                }
            }
            return null;
        }
        catch (Exception ex) {
            Database.rollback(sp);
            return ex.getMessage();            
        }
    }
    
    @AuraEnabled
    public static List<Map<String,Object>> getExtraFields(String extraFieldsFieldSet) { 
        List<Map<String,Object>> extraFields = new List<Map<String,Object>>();
        Schema.FieldSet fieldSet = Schema.SObjectType.User.fieldSets.getMap().get(extraFieldsFieldSet);
        if (fieldSet != null) {
            for (Schema.FieldSetMember f : fieldSet.getFields()) {
                Map<String, Object> fieldDetail = new Map<String, Object>();
                fieldDetail.put('dbRequired', f.getDBRequired());
                fieldDetail.put('fieldPath', f.getFieldPath());
                fieldDetail.put('label', f.getLabel());
                fieldDetail.put('required', f.getRequired());
                fieldDetail.put('type', f.getType());
                fieldDetail.put('value', '');   // client will populate
                extraFields.add(fieldDetail);
            }
        }
        return extraFields;
    }
}