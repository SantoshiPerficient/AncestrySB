public without sharing class PRFT_OrderController extends PRFT_Permissions{
   public PRFT_OrderController(){
		super();
	}
	
	public void orderCreationCheck(){
		System.debug('check access---'+ checkAccess());
	}  
}