public with sharing class orderPageController {
   
    @AuraEnabled 
    public static String findAccount(String userId){
        //hardcoded for testing 
        userId = '0050R00000AeJgnQAF';

        //find the user account associated with the id from the context user
        User currentUser = [SELECT Name, AccountId FROM User WHERE Id = :userId];
        //find the account associated with the contact that is the user
        Account userAccount = [SELECT Id, Name FROM Account WHERE Id = :currentUser.AccountId];
        //find the contact associate with the account 
        Contact userContact = [SELECT Id, Name FROM Contact WHERE AccountId = :userAccount.Id];
        //find the contract associated with the account that is ordering 
        Contract userContract = [SELECT Id FROM Contract WHERE Contact__c = :userContact.Id];
        //get the standard pricebook 
        Pricebook2 standardPricebook = [Select Id FROM Pricebook2 WHERE IsStandard = true];

        //generate an order to insert
        Order newOrder = new Order(AccountId = userAccount.Id, ContractId = userContract.Id, Contact__c = userContact.Id,EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id = standardPricebook.Id);
        //insert the order
        insert newOrder;


        return userContract.Id;
    }//end findAccount

}//orderPageController
