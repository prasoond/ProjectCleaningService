public class test1 {
 public static void tt()
 { Account a = new Account(name='Accf');
  Database.SaveResult s = Database.insert(a);
  System.debug(a);
  System.debug(s);
   
     
          }
     }