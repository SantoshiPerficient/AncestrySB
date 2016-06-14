/**
 * Author - Santoshi (Perficient)
 * Purpose - This class will handle permission logics
 */
public virtual without sharing class PRFT_Permissions extends PRFT_DomainLayer{
	PRFT_ActivityHistoryClass activityHisObj {get;set;}
	public PRFT_Permissions(){
		super();
	}
	
	// Checks access of logged in user based on the time stamp.
	public override Boolean checkAccess() { 
	
		System.debug('Checking current user info--'+CurrentUserInfo);
		System.debug('Checking current user info 111--'+ CurrentUserInfo.PRFT_Access_time_stamp__c);
		System.debug('Checking current user Now 111--'+ System.Now());
		if(CurrentUserInfo.PRFT_Access_time_stamp__c != null){
		   Integer hours = 0;
           Integer day = System.Now().day() - CurrentUserInfo.PRFT_Access_time_stamp__c.day();
           System.debug('checking day--'+day);
            if(day == 0) {
               Integer hrs = System.Now().hour() - CurrentUserInfo.PRFT_Access_time_stamp__c.hour();
                System.debug('checking hrs--'+hrs);
           		
             		Integer min = System.Now().minute() - CurrentUserInfo.PRFT_Access_time_stamp__c.minute();
             		 System.debug('checking min--'+min);
           		if(min < Integer.valueof(System.Label.PRFT_Access_Control_Time_in_min)){
           			return true;
           		}
            }
            
           

            
		}
		return false;
	}
}