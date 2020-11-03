public class DeepClone {

    @InvocableMethod(label='Method1')
    public static void method1(List<Id> i)
    {
        list<A__c> obj = [
            Select
            	Id,
            	Name,
            		(
                        Select 
                        	Id,
                        	Name 
                        From 
                        	B_s__r
                    )
            From 
            	A__c 
            Where 
            	Id IN :i
        ];
        A__C new_a = new A__c();
        for(A__c a:obj)
        {
            new_a.Name = a.Name;
            
        }
        insert new_a;
       list<B__C> list_newb = new list<B__c>();
       list<B__c> list_b = new list<B__c>(); 
        map<id,b__c> map_b = new map<id,B__c>();
        for(A__c a:obj)
        {
            for(B__c b : a.B_s__r)
            {  list_b.add(b);
                B__c new_b = new B__c();
                new_b.A__c = new_a.Id;
                new_b.Name = b.Name;
               list_newb.add(new_b);
                map_b.put(b.id,new_b);
            }
        }
       insert list_b; 
        
        
        
        
        List<B__c> b_for_c = [
            SELECT
            	Id,
            	(
                    SELECT
                    	Id
                    FROM
                    	C_s__r
                )
            FROM
            	B__c
            WHERE
            	Id IN: list_b
            	
        ];
        
    }
}