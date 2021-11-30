public with sharing class CTPersonController {
    
    public  static String  getToken(String mobileNo) {
        Blob value = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', value); 
        
        //get the string value from  hash 
        return EncodingUtil.base64Encode(hash);
    }
    // Get 100 contacts with recent healt status change @return List <Person__c>
    public static List <Person__c> getRecentHealthChanges() {
       return [SELECT Id, Name, Health_Status__c, Status_Update_Date__c, Mobile__c, Token__c  FROM Person__c ORDER BY Status_Update_Date__c DESC NULLS LAST LIMIT  100 ];
    }

    // Search people by name, token or mobile 
    // return  List<Person__c>
    public  static List <Person__c>  searchPeople(String searchTerm) {
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Health_Status__c, Status_Update_Date__c, Mobile__c, Token__c  
        FROM Person__c 
        WHERE Name LIKE :searchTerm  
            OR Mobile__c LIKE :searchTerm 
            OR Token__c LIKE :searchTerm  
        ORDER BY Status_Update_Date__c DESC NULLS LAST ];
    }
    // Search person by Id
    // return Person__c
    public static Person__c getPersonById(String personId) {
        List <Person__c> people = [SELECT Id, Name, Health_Status__c, Status_Update_Date__c, Mobile__c, Token__c 
        FROM Person__c
        WHERE Id =:personId ];
        if (people != null && people.size() > 0 ) {
            return people[0];
        }
        return null;
    }
}
