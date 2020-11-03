public class test {
    public static void m1(string course,decimal fee1,decimal fee2)
    {
      // list<student__c> l = [Select id, name , name__C, initial_fee__c 
        //                     FROM student__c 
          //                   WHERE initial_fee__c <:fee2 AND initial_fee__c >:fee1];
       list<Batch_Course_Junction__c> bcj = [Select id, course__r.name , batch__r.name 
                                             FROM Batch_Course_Junction__c 
                                             where course__r.name = :course  ];
        
     /*for(student__c s:l)
      {
          system.debug(s.name__c + ' ' + s.initial_fee__c);
      }*/
     
        list<student__c> lc = [Select id, name,name__C ,batch__r.name FROM student__c 
                               where batch__r.name=:bcj[0].batch__r.name AND initial_fee__c <:fee2 AND initial_fee__c >:fee1];
        
    for(student__c s:lc)
    {
        system.debug(s.name__c + ' ' + s.batch__r.name );
    }
        
    }
}