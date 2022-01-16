
@isTest
public with sharing class orderPageControllerTest {
    
    @isTest 
    public static void TP_createOrderItems(){
        Test.startTest();
            //variables for test 
            Boolean result;
            Integer i;
            Integer amount = 3;
            //create an account 
            Account newAccount = DavidDataFactory.createAccount();
            insert newAccount;
            Account currAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test'];
            //create a contact 
            Contact newContact = DavidDataFactory.createContact(currAccount.Id);
            insert newContact;
            Contact currContact = [SELECT Id, Name FROM Contact WHERE AccountId = :currAccount.Id];
            //create contract
            Contract newContract = DavidDataFactory.createContract(currAccount.Id, currContact.Id);
            insert newContract;
            Contract currContract = [SELECT Id FROM Contract WHERE AccountId = :currAccount.Id AND Contact__c = :currContact.Id];
            //generate the StandardPB Id since we don't have one in the test org
            Id pricebookId = Test.getStandardPricebookId(); 
            Pricebook2 updateStandardPricebook = new Pricebook2(Id = pricebookId);
            update updateStandardPricebook;
            Pricebook2 standardPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = true];

            //create order
            Order newOrder = new Order(AccountId = currAccount.Id, ContractId = currContract.Id, Contact__c = currContact.Id, EffectiveDate = date.today(), Status = 'Draft', Pricebook2Id = standardPricebook.Id);
            insert newOrder;

            //create products and pricebook entries
            List<Product2> newProducts = DavidDataFactory.createProducts(amount);
            insert newProducts;
            List<Product2> currProducts = [SELECT Id, Name FROM Product2 WHERE Name LIKE 'Test%'];
            List<PricebookEntry> newPricebookEntries = DavidDataFactory.createPricebookEntries(currProducts, standardPricebook, amount, currProducts.size());
            insert newPricebookEntries;
            List<PricebookEntry> currPricebookEntries = [SELECT Id FROM PricebookEntry WHERE Name LIKE 'Test Product%'];

            //create digestable info for the function
            List<String> product2Ids = new List<String>();
            List<Integer> quantities = new List<Integer>();
            List<Decimal> unitPrices = new List<Decimal>();

            for(i = 0; i < amount; i++){
                product2Ids.add(currProducts[i].Id);
                quantities.add(i+1);
                unitPrices.add(1000.00);
            }//end for i

            //start probing the order items 
            result = orderPageController.createOrderItems(currContact.Id, product2Ids, quantities, unitPrices, amount);

        Test.stopTest();
    }//end TP_createOrderItems

}//end orderPageControllerTest
