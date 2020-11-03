public with sharing class jobTriggerHelper {
     
public static void insertJob(List<job__c> jobList)
{
    List<Job_bookings__c> jb = new List<Job_bookings__c>(); 
    Set<Date> dateset = new Set<Date>();
    Integer clearnersReq = 0;
//abc abc
    for(job__c nj: jobList) {   
        
        if(nj.Recurrences__c == 'weekly')
        {
            Integer i=0;
            date d = nj.Start_date__c;
            while(d<=nj.End_Date__c)
            {   dateset.add(d);
                d = d+7;
                i++;
            }
            clearnersReq = clearnersReq + (Integer)nj.Cleaners_per_day__c*i;
            
        }
        else if(nj.Recurrences__c == 'bi-weekly')
        {
            Integer i=0;
            date d = nj.Start_date__c;
            while(d<=nj.End_Date__c)
            {   
                dateset.add(d);
                d = d+14;
                i++;
            }
            clearnersReq = clearnersReq + (Integer)nj.Cleaners_per_day__c*i;
            
        }
        else if(nj.Recurrences__c == 'monthly')
        {
            Integer i=0;
            date d = nj.Start_date__c;
            while(d<=nj.End_Date__c)
            {   
                dateset.add(d);
                d = d+30;
                i++;
            }
            clearnersReq = clearnersReq + (Integer)nj.Cleaners_per_day__c*i;
        }
        else {
            date d = nj.Start_date__c;
            dateset.add(d);
            clearnersReq = clearnersReq +(Integer)nj.Cleaners_per_day__c;
        }

    }
    List<Job_bookings__c> dateBookings = [
        SELECT
            id,
            Date_of_Execution__c,
            Name,
            Cleaner__c,
            Executed__c
        FROM
            Job_bookings__c
        WHERE
            Date_of_Execution__c IN: dateset
        
    ];
    Set<ID> not_CleanerId = new Set<ID>();
    for(Job_bookings__c clid: dateBookings)
    {
        not_CleanerId.add(clid.Cleaner__c);
        
    }

    List<Cleaner__c> cleanersID = [
        SELECT 
            id,
            Name__C,
            Date_of_Last_Job__c
        FROM
            Cleaner__c
        WHERE
            ID NOT IN: not_CleanerId     
    ];

  
  Integer a=0;
  for(job__c j: jobList)
  { 
    if(j.Recurrences__c == '')
      {
        for(Integer i=0;i<j.Cleaners_per_day__c ;i++)
        {
            Job_bookings__c newJB = new job_bookings__c();
            newJB.Date_of_Execution__c = j.Start_Date__c;
            newJB.Job__c = j.ID;
            newJB.Cleaner__c =  cleanersID[a].ID;
            a++;
            jb.add(newJB);
        }
      }
      else if(j.Recurrences__c == 'weekly')
      {
          Date d = j.Start_Date__c ;
          while(d<=j.End_Date__c)
          {   Job_bookings__c newJB = new job_bookings__c();
            newJB.Date_of_Execution__c = d;
            newJB.Job__c = j.ID;
            newJB.Cleaner__c =  cleanersID[a].ID;
            a++;
            jb.add(newJB);
            d = d+7;
          }
      }
     else if(j.Recurrences__c == 'bi-weekly')
      {
        Date d = j.Start_Date__c ;
        while(d<=j.End_Date__c)
        {    Job_bookings__c newJB = new job_bookings__c();
            newJB.Date_of_Execution__c = d;
            newJB.Job__c = j.ID;
            newJB.Cleaner__c =  cleanersID[a].ID;
            a++;
            jb.add(newJB);
            d = d+14;
        }
      }
      else{
        Date d = j.Start_Date__c ;
        while(d<=j.End_Date__c)
        {    Job_bookings__c newJB = new job_bookings__c();
            newJB.Date_of_Execution__c = d;
            newJB.Job__c = j.ID;
            newJB.Cleaner__c =  cleanersID[a].ID;
            a++;
            jb.add(newJB);
            d = d+30;
        }
      }  
    
  }

}

}