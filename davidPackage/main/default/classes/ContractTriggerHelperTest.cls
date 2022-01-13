
@isTest
public with sharing class ContractTriggerHelperTest {
    
    //-------Test the Helper-------//
    //Test Positive
    //Tests for the successful insertion of a contract
    @isTest 
    public static void TP_contractDuplicate(){
        Test.startTest();
        //variables for the contract 
        Boolean result;
        Account newAccount = DataFactory.createAccount();
        insert newAccount;
        Account currAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test'];
        Contact newContact = DataFactory.createContact(currAccount.Id);
        insert newContact;
        Contact currContact = [SELECT Id, Name FROM Contact WHERE FirstName = 'Test'];
        //create a viable contract 
        List<Contract> newContracts = new List<Contract>();
        //load the list with one contract
        newContracts.add(DataFactory.createContract(currAccount.Id, currContact.Id));
        //pass it to the function
        result = ContractTriggerHelper.contactDuplicate(newContracts);
        //check results
        System.assertEquals(true, result);
        Test.stopTest();
    }//end TP_contractDuplicate

    //Test Negative 
    //Tests for the unsuccessful insertion of contract based
    //on the two different conditions failing. Duplicate entry 
    //and missing Contact__c 
    @isTest
    public static void TN_contractDuplicateNoContact(){
        Test.startTest();
        //variables for contract
        Boolean result;
        //NO CONTACT__C TEST
        Account newAccount = DataFactory.createAccount();
        insert newAccount;
        Account currAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test'];
        //Make contract
        List<Contract> newContracts = new List<Contract>();
        newContracts.add(new Contract(AccountId = currAccount.Id));
        //pass it to the function
        result = ContractTriggerHelper.contactDuplicate(newContracts);
        //check results
        System.assertEquals(false, result);
        Test.stopTest();
    }//end TN_contractDuplicate

    @isTest
    public static void TN_contractDuplicateDupEntry(){
        Test.startTest();
        //variables for contract
        Boolean result;
        //DUPLICATE CONTACT 
        Account newAccount = DataFactory.createAccount();
        insert newAccount;
        Account currAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test'];
        Contact newContact = DataFactory.createContact(currAccount.Id);
        insert newContact;
        Contact currContact = [SELECT Id, Name FROM Contact WHERE FirstName = 'Test'];
        //create the duplicate contract 
        Contract dupContract = DataFactory.createContract(currAccount.Id, currContact.Id);
        insert dupContract;
        //create a new contract with the same info 
        List<Contract> newContracts = new List<Contract>();
        newContracts.add(DataFactory.createContract(currAccount.Id, currContact.Id));
        //pass it to the function
        result = ContractTriggerHelper.contactDuplicate(newContracts);
        //check results
        System.assertEquals(false, result);
        Test.stopTest();
    }//end TN_contractDuplicateDupEntry

    //--------Test the Trigger------//
    //Test Positive
    @isTest 
    public static void TP_ContractTrigger(){
        Test.startTest();
        //variables for contract 
        Account newAccount = DataFactory.createAccount();
        insert newAccount;
        Account currAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test'];
        Contact newContact = DataFactory.createContact(currAccount.Id);
        insert newContact;
        Contact currContact = [SELECT Id, Name FROM Contact WHERE FirstName = 'Test'];
        //create the contract variable 
        Contract newContract = DataFactory.createContract(currAccount.Id, currContact.Id);
        //insert so we can save the result
        Database.SaveResult result = Database.insert(newContract, false);
        //check result
        System.assertEquals(true, result.isSuccess());
        Test.stopTest();
    }//end TP_ContractTrigger


    //Test Negative 
    @isTest 
    public static void TN_ContractTriggerNoContact(){
        Test.startTest();
        //variables for contract
        Account newAccount = DataFactory.createAccount();
        insert newAccount;
        Account currAccount = [SELECT Id, Name FROM Account WHERE Name = 'Test'];

        //create the contract without a ContactId
        Contract newContract = new Contract(AccountId = currAccount.Id);
        Database.SaveResult result = Database.insert(newContract, false);

        //check the result
        System.assertEquals(false, result.isSuccess());

        Test.stopTest();
    }//end TN_ContractTriggerNoContact

    //Test Bulk 
    @isTest 
    public static void TB_ContractTrigger(){
        Test.startTest();
        //variables for contract
        Integer testLimit = 200;
        List<Database.SaveResult> resultList;
        List<Account> newAccounts = DataFactory.createAccounts(testLimit);
        insert newAccounts;
        List<Account> currAccounts = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test%' LIMIT :testLimit];

        List<Contact> newContacts = DataFactory.createContacts(testLimit, currAccounts);
        insert newContacts;
        List<Contact> currContacts = [SELECT Id, Name FROM Contact WHERE Name LIKE 'Test%' LIMIT :testLimit];

        //create some contracts with unique contactIds
        List<Contract> newContracts = DataFactory.createContracts(currAccounts, currContacts, testLimit);

        //insert into database
        resultList = Database.insert(newContracts, false);

        //iterate over the list of results
        for(Database.SaveResult result : resultList){
            System.assertEquals(true, result.isSuccess());
        }

        Test.stopTest();
    }//end TB_ContractTrigger





}//end class ContractTriggerHelper
