/**
 * Author - Santoshi (Perficient)
 * Purpose - This class will handle activity history updates and access control.
 */
public without sharing class PRFT_ActivityHistoryClass extends PRFT_DomainLayer{

	
   // initialise constructor and assign to record.
   public PRFT_ActivityHistoryClass(List<ActivityHistory> sObjectList)
   {
       super(sObjectList);

    }

    // Construct activity history list.
    public class Constructor implements PRFT_DomainLayer.IConstructable
    {
        public PRFT_DomainLayer construct(List<SObject> sObjectList)
        {

            return new PRFT_ActivityHistoryClass(sObjectList);

        }
    }
    
    // Create Activity History for the record passed.
    public override void createActivityHistory()
	{
	  insert (Records);
	}
	
	
    
	 
}