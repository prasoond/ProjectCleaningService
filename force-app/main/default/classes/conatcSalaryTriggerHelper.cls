public with sharing class conatcSalaryTriggerHelper {
   
    public static void updateTotalSalary(List<Contact> newConList){
        list<contact> RelatedContact = new List<Contact>();
        for(contact c: newConList)
        {
            if(c.AccountId!=NULL)
            {
                RelatedContact.add(c);
            }
        }
        system.debug(RelatedContact);
        
        set<Id> AccId = new Set<Id>();
        for(Contact c:RelatedContact)
        {
            AccId.add(c.AccountId);
        } 
        system.debug(AccId);

        list<Account> Acc = [Select id, Total_Salary__c ,(Select id, lastName,Salary__c from Contacts) From Account
                             Where Id In: AccID];
                             system.debug(Acc);
        
        for(Account a: Acc)
        { 
            decimal sum=0;
        system.debug(a.Total_Salary__c );

            list<contact> con = a.Contacts;
            for(contact c:con)
            {
                try
                {
                 sum = sum + c.Salary__c;
                system.debug(a.Total_Salary__c+' ' +c.lastName );
                 }catch(Exception e)
                    {

                    } 
            }
         a.Total_Salary__c = sum;
        }
    
        Update Acc;
    }

    public static void updateTotalSalary(map<id,contact> newConMap, map<id,contact> oldConMap)
    {
        list<contact> RelatedContact = new List<Contact>();
        for(contact c: newConMap.values())
        {
            if(c.AccountId!=NULL)
            {
                RelatedContact.add(c);
            }
        }
        set<Id> AccId = new Set<Id>();
        for(Contact c:RelatedContact)
        {
            AccId.add(c.AccountId);
        }
        list<Account> Acc = [Select id, Total_Salary__c ,(Select id, Salary__c from Contacts) From Account
                             Where Id In: AccID];
                             system.debug(Acc);
        
        for(Account a: Acc)
        { decimal sum = 0;
        system.debug(a.Total_Salary__c );

            list<contact> con = a.Contacts;
            for(contact c:con)
            {try{
                sum  = sum  + c.Salary__c - (oldConMap.get(c.id)).Salary__c ;
              }catch(Exception e)
              {

              }
            }
            a.Total_Salary__c = a.Total_Salary__c + sum;
        }
        Update Acc;
                         
    }

    public static void deleteSalary(list<contact> newConList)
    {
        list<contact> RelatedContact = new List<Contact>();
        for(contact c: newConList)
        {
            if(c.AccountId!=NULL)
            {
                RelatedContact.add(c);
            }
        }
        map<Id,list<contact>> AccId = new map<Id,list<contact>>();
        set<id> aid = new set<id>();
        for(Contact c:RelatedContact)
        {
            aid.add(c.AccountId);
        }
        for(id a:aid)
        {
            list<contact> c = new list<contact>();
            for(Contact c1:RelatedContact)
            {
                if(c1.AccountId==a)
                {
                    c.add(c1);
                }
            }
            AccId.put(a,c);
        }
        list<Account> Acc =[Select id, name , Total_Salary__c From Account Where Id In: Accid.keySet()];
    
         for(Account a:Acc)
         {
             list<contact> con = AccId.get(a.id);
             decimal dif = 0;
             for(integer i=0;i<con.size();i++)
             {
                 dif = dif + con[i].Salary__c;
            }
            a.Total_Salary__c = a.Total_Salary__c - dif;
         }    
         Update Acc;

    }

}