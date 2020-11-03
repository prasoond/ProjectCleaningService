public class SecondController {
    public String name{get;set;}
    list<account> accList{get;set;} 
    decimal AnnualRevenue{get;set;}
        public SecondController()
    {
        for(Account a:accList)
        {
            name=a.name;
           accList = [Select id, name ,AnnualRevenue from Account where AnnualRevenue=:AnnualRevenue];
    
        
        }
    }
}