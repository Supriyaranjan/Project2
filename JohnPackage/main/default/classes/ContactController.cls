public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactInfo(){

       Id loggedInUserId = UserInfo.getUserId();
       User u = [SELECT Id, contactId FROM User WHERE Id = :loggedInUserId];
       Id getContactId = u.contactId;

        return [
            SELECT Id, FirstName, LastName, Phone, Email
            FROM Contact
            WHERE Id = :getContactId

        ];
    }
}