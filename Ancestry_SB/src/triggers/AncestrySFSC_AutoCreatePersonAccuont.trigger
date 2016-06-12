/*************************************************
Class: AncestrySFSC_AutoCreatePersonAccuont.cls
Description: trigger for Case
Auther: Lisa Cheng
Date:   2/15/2015

Revision History:
----------------------------------------------------
Populate the value of Account and Contact when case is created from Web  - Lisa Cheng 2/15/2016
***************************************************/ 
trigger AncestrySFSC_AutoCreatePersonAccuont on Case (before insert) {
   if(Trigger.isInsert){
        if(Trigger.isBefore){
            AncestrySFSC_AutoCreatePersonAcctHelper helper = new AncestrySFSC_AutoCreatePersonAcctHelper();
            helper.autoCreatePersonAccount(trigger.new);
        }
    }

}