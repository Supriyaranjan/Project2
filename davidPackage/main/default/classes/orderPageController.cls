public with sharing class orderPageController {
   
    @AuraEnabled 
    public static String createOrder(String userId){
        //hardcoded for testing 
        //userId = '0050R00000AeJgnQAF';

        //find the user account associated with the id from the context user
        User currentUser = [SELECT Name, AccountId FROM User WHERE Id = :userId];
        //find the account associated with the contact that is the user
        Account userAccount = [SELECT Id, Name FROM Account WHERE Id = :currentUser.AccountId];
        //find the contact associate with the account 
        //Contact userContact = [SELECT Id, Name FROM Contact WHERE AccountId = :userAccount.Id ];
        Contact userContact = [SELECT Id, Name FROM Contact WHERE AccountId = :userAccount.Id AND Name = :currentUser.Name];
        //find the contract associated with the account that is ordering 
        Contract userContract = [SELECT Id FROM Contract WHERE Contact__c = :userContact.Id];
        //get the standard pricebook 
        Pricebook2 standardPricebook = [Select Id FROM Pricebook2 WHERE IsStandard = true];

        //generate an order to insert
        Order newOrder = new Order(AccountId = userAccount.Id, ContractId = userContract.Id, Contact__c = userContact.Id,EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id = standardPricebook.Id);
        //insert the order
        insert newOrder;

        //return user contact id for use with order items
        return userContact.Id;
    }//end createOrder

    @AuraEnabled 
    public static Boolean createOrderItems(String contactId, List<String> product2Ids, List<Integer> quantities, List<Decimal> unitPrices, Integer totalItems){
        System.debug('I am in the createOrderItems function');
        //orderItem needs
        // - OrderId -> comes from contact id select id, name, (select id from orders__r) from contact
        // - PricebookEntry -> use productIds passed in and all pricebook entries to find the ones in the order 
        // - Product2 Ids -> passed in as list
        // - Quantity -> passed in as list 
        // - UnitPrice -> passed in as list 
        Boolean result = true;
        //get the current order from the contact id passed in
        Order currOrder = [SELECT Id, Pricebook2Id FROM Order WHERE Contact__r.id = :contactId AND TotalAmount = 0];
        System.debug('I queried for the current Order ' + currOrder.Id + ' and current Pricebook ' + currOrder.Pricebook2Id);
        //set the retrieved pricebook2Id to a string
        String pricebook2Id = currOrder.Pricebook2Id;
        //create a list for the new order items
        List<OrderItem> newOrderItems = new List<OrderItem>();
        //create a list for all the pricebookEntries fields related to the items 
        List<PricebookEntry> allPricebookEntries = [SELECT Id, Product2Id, Pricebook2Id, UnitPrice, Name FROM PricebookEntry];
        System.debug('We got ' + allPricebookEntries.size() + ' initial pricebooks');
        //create a list of only the related pricebook entries for the products passed in 
        List<PricebookEntry> relatedPricebookEntries = new List<PricebookEntry>();

        //use two enhanced for loops to sort out the products and their related pricebook entries
        for(String product2Id : product2Ids){
            System.debug('Currently loopin through product ' + product2Id);
            for(PricebookEntry allPricebookEntry : allPricebookEntries){
                System.debug('We are looping through pricebook for ' + allPricebookEntry.Name + ' with pricebookid ' + allPricebookEntry.Id + ' and productid' + allPricebookEntry.Product2Id);
                if(allPricebookEntry.Pricebook2Id == pricebook2Id && allPricebookEntry.Product2Id == product2Id){
                    System.debug('Comparing product ids' + allPricebookEntry.Product2Id + ' to ' + product2Id);
                    System.debug('Comparing pricebook ids' + allPricebookEntry.Pricebook2Id + ' to ' + pricebook2Id);
                    relatedPricebookEntries.add(allPricebookEntry);
                }//end if 
            }//end for allPricebookEntry
        }//end for product2Id

        System.debug('We got ' + relatedPricebookEntries.size() + ' related pricebooks');

        //for loop to add as many orderItems as there are products
        //something here is out of bounds, write a test to debug
        for(Integer i = 0; i < totalItems; i++){
            newOrderItems.add(new OrderItem(OrderId = currOrder.Id, PricebookEntryId = relatedPricebookEntries[i].Id, Product2Id = product2Ids[i], Quantity = quantities[i], UnitPrice = unitPrices[i]));
        }//end for i

        //insert into database
        insert newOrderItems;
        return result;
    }//end createOrderItems


}//orderPageController
