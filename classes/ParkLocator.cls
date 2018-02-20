public with sharing class ParkLocator {

    Set<String> countryNames = new Set<String>{'Germany','India','Japan', 'United States'}; 

    public static List<String> country(String cName) 
    {

        if(countryNames.contains(cName))
        {   
            ParkService.ParksImplPort parksImplPort = ParkService.ParksImplPort();
            return parksImplPort.byCountry(cName);
        }
        return new List<String>();
    }
}
