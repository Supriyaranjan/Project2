public with sharing class getUserInfo {

    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String getFirstName(String userIdFromAura) {
        String name;
        User currUser = [SELECT Id, Name FROM User WHERE Id = :userIdFromAura];
        name = currUser.Name;
        return name;
    }
}