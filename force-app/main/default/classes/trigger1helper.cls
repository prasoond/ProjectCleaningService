public with sharing class trigger1helper {
    public static void addPvtLtdinName(list<account> accnew)
    {
        for(account a:accnew )
        {
          a.name = a.name + ' pvt limited';
        }
    }

    public static void addRelatedContact(List<Account> accnew)
    {  list<contact> conlist = new list<contact>();
      for(account a:accnew)
      {
       contact c = new contact(lastName=a.name +' Contact',MailingCity=a.ShippingCity,AccountID=a.id);
       conlist.add(c);
      }
      insert conlist;
    }

    public static void isAmountChanged(List<Account> accnew,map<id,Account> accoldmap)
    {
        for(integer i=0;i<accnew.size();i++)
        {
            if(accnew[i].annualRevenue != accoldmap.get(accnew[i].Id).annualRevenue)
            {
                accnew[i].addError('Annual Revenue Cannot be changed in update event');
            }
        }
    }

    public static void updateRelatedContact(List<account> accnew)
    {
        list<account> accQuery = [Select id, name, shippingCity,(Select id, lastName, MailingCity from Contacts) 
                                  From Account
                                  Where Id In :accnew];
        for(account a:accQuery)
        {
            list<contact> con = a.Contacts;
            system.debug(con);
            for(contact c:con)
            {
                c.MailingCity=a.ShippingCity;
                system.debug(c);
            
            }
            update con;
        }
                                  
    }
  public static  list<account> backupAccounts = new List<account>();
    public static void checkRelatedOpportunity(map<id,Account> accoldmap)
    {  
        Set<id> idList =accoldmap.keySet();
        list<Account> accQuery = [Select id, name,Owner.email,(Select id, name, AccountId from Opportunities) 
                                  From Account
                                  Where Id IN :idList];
        
        for(account a:accQuery)
        {
            List<Opportunity> oppList = a.Opportunities;
            if(oppList.size()!=0)
            {
                (accoldmap.get(a.id)).addError('Cant Delete the Account because there are related Opportunities Present');
            }
            else{
             backupAccounts.add(a);

            }
            
        } 
    }
    public static void EmailonDelete()
    {
      for(account a:backupAccounts){
       system.debug(a.owner.email);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       try{ String[] toAddresses = new String[] {a.owner.email};

        mail.setToAddresses(toAddresses);
        mail.setSubject('Account Record Deleted : ' + a.Id);
        mail.setPlainTextBody('Account name: ' + a.name +' has been deleted.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
      }catch(Exception e)
      {

      }

      }

    }
    public static void EmailonDelete(list<account> accnew)
    {
        for(account a:accnew)
        {Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            try{ String[] toAddresses = new String[] {a.owner.email};
     
             mail.setToAddresses(toAddresses);
             mail.setSubject('Account Record UnDeleted : ' + a.Id);
             mail.setPlainTextBody('Account name: ' + a.name +' has been undeleted.');
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           }catch(Exception e)
           {
     
           }

        }
    }

}