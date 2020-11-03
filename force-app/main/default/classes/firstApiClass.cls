@RestResource(urlMapping='/testApi' )
global class firstApiClass {
    @HttpPost
   global static String myMethod()
   {
       Return 'hello'; 
   }
   @HttpGet
    global static list<Account> myMethod1()
    {
        return [Select id, name from Account limit 5];
    }
}