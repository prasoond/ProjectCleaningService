public class AccountListController {
  
    public String name{get;set;}
    public list<Account> accList{get;set;}
    public decimal AnnualRevenue{get;Set;}
    public AccountListController()
    {
  
        //safg
    }
    
    public void Search()
    {    system.debug(AnnualRevenue);
        accList=[Select id,name,AnnualRevenue from Account where AnnualRevenue>:AnnualRevenue];
    }
    
}