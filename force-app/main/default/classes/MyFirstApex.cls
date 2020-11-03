public class MyFirstApex {
    
    public static void m1()
    {
        list<list<string>> l_in = new list<list<string>>();
        list<string> l1 = new list<string>{'abca','apcapqqc'};
            l_in.add(l1);
        
        list<list<string>> l_out = new list<list<string>>();
         list<string> la = new list<string>{'',''};
             l_out.add(la);
        integer p=0;
        for(list<string> l: l_in)
        {integer q=0;
         string s2;
            for(string s:l)
            {
                list<string> ls = new list<string>();
                for(integer i =0;i<s.length();i++)
                {
                    ls.add(s.substring(i,i+1));
                }
             ls.sort();
           /* for(integer i =0;i<ls.size();i++)
             {
                 for(integer j = i+1;j<ls.size();j++)
                 {
                     if(ls[i]==ls[j])
                     {
                         ls.remove(j);
                     }
                 }
             }*/
             set<string> sl = new set<string>(ls);
            s2='';
             for(string s1 : sl)
            {
                s2 = s2 +s1;
            }
                  l_out[p][q]=s2;    
                q++;

            }
         
         p++;
        }
        system.debug(l_out);
    }

}