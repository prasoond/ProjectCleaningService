public class myfirstclass {
   public static void mymethod()
    {
       list<list<integer>> lmain = new list<list<integer>>();
        list<integer> l1 = new list<integer>{1,2,3};
            list<integer> l2 = new list<integer>{4,5,6};
                list<integer> l3 = new list<integer>{7,8,9};
        lmain.add(l1);
        lmain.add(l2);
        lmain.add(l3);
        
        list<list<integer>> lmainT = new list<list<integer>>();
        list<integer> lt1 = new list<integer>{0,0,0};
            list<integer> lt2 = new list<integer>{0,0,0};
                list<integer> lt3 = new list<integer>{0,0,0};
         lmainT.add(lt1);
        lmainT.add(lt2);
        lmainT.add(lt3);
        
                            
         system.debug(lmain);  
    system.debug(lmainT);
for(integer i =0;i<lmain.size();i++)
        {
            for(integer j = 0; j< l1.size();j++)
            {
                lmainT[i][j]=lmain[j][i];
            }
        }
        
 
         system.debug(lmain);  
    system.debug(lmainT);       
    }

}