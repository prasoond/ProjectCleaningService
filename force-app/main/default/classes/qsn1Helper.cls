public with sharing class qsn1Helper {
 
/**################################################################################################ */
    public static void insertOpp(list<Account> accList)
    {
        List<Account> accQ = [Select id, name, (Select id, name from Opportunities) from Account Where id IN :accList];
        list<Opportunity> oppList = new list<Opportunity>();
        for(account a : accQ)
        {
            if(a.opportunities.size()==0)
            {   String n = 'First Opportunity ' + a.name;
                Opportunity o = new Opportunity(name=n,AccountId=a.id,stagename='Prospecting',closedate=system.today()+5);
                oppList.add(o);
            }
        }
        insert oppList;
    }

/*############################################################################################## */
    public static void qsn2(list<opportunity> NewOpp)
    {
        
    list<opportunity> opp = [Select id,name, AccountId from Opportunity];
    set<id> accId= new set<id>();
    for(Opportunity o: opp)
    {
        accId.add(o.AccountId);
    }
    list<Account> acc = [Select id, name, (Select id, name from Opportunities) From Account where id IN:accId];

    map<Id,list<String>> map1 = new map<Id,list<String>>();
    for(account a:acc)
    { list<string> oname = new list<string>();
      for(opportunity o:a.opportunities)
      {
          oname.add(o.name);
      }
      map1.put(a.id,oname);
    }

    for(opportunity o:NewOpp)
    {   
         id aid= o.AccountId;
        if(map1.containsKey(aid))
        {
            list<string> oname = map1.get(aid);
            for(string s:oname)
            {
                if(s.equals(o.name))
                {
                    o.name = o.name +' Duplicate Opportunity';
                    
                }
            }

        }
    }
 
    }

   /**####################################################################################### */ 

   public static void qsn3(list<account> accList)
   {
    list<Account_Backup__c> abList = new list<Account_Backup__c>();
    for(account a: accList)
    {system.debug('1');
     system.debug(a.MasterRecordId);
        if(a.MasterRecordId!=null)
        {
            Account_Backup__c ab = new Account_Backup__c(name=a.name,Phone_Number__c=a.phone,Account_MasterId__c = a.MasterRecordId);
            system.debug(ab);
            abList.add(ab);

        }
    }
    insert abList;

   }
  /**############################################################################################### */
  public static void qsn4(Map<id,Account> accList)
  {
    list<string> s = new list<string>{'Closed Won','Closed Lost'};
    List<Account> accQ =[Select id, name , (Select id, name, stageName from Opportunities where StageName Not In: s ) from Account where id In:accList.keySet()];
    for(account a:accQ)
    {integer count =0;
        for(opportunity o: a.opportunities)
        {
            count++;
        }
        if(count>0)
        {System.debug(a);
            accList.get(a.id).addError('Account have open Opportunities, Can\'t Delete');
        }
    }
  }
  /**################################################################################################# */

  public static void qsn5(list<opportunity> oppList)
  {
    set<id> accId = new set<id>();
    for(opportunity o:oppList)
    {
        accId.add(o.AccountId);
    }
    list<account> accList = [Select id, name ,rating ,(Select id, name , amount from Opportunities where id in:oppList)from account where id in:accId];
    for(account a:accList)
    {
        for(opportunity o:a.opportunities)
        {
            if(o.amount>10000)
            {
                system.debug(o);
                a.rating ='Hot';
                System.debug(a.rating);
            }
        }
    }
    update accList;
    system.debug(accList);

  }
}