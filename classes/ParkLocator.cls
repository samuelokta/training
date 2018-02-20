public with sharing class ParkLocator {

    public static Set<String> countryNames = new Set<String>{'Germany','India','Japan', 'United States'}; 

    public static String[] country(String cName) 
    {

        if(countryNames.contains(cName))
        {   
            ParkService.ParksImplPort parksImplPort = new ParkService.ParksImplPort();
            return parksImplPort.byCountry(cName);
        }
        return new List<String>();
    }
}