global class AncestrySFSC_ServiceAgentSchedular implements Schedulable {
   global void execute(SchedulableContext SC) {
      AncestrySFSC_ServiceAgent serviceAgent = new AncestrySFSC_ServiceAgent();
      serviceAgent.ExecuteBusinessProcs();      
   }
}