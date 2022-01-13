public with sharing class DavidDataFactory {
    
     //createProduct
        public static Product2 createProduct(){
        Product2 newProduct = new Product2(Name = 'Test Product');
        return newProduct;
    }//end create Product

    //createProducts
    public static List<Product2> createProducts(Integer numProducts){
        //make some variables
        Integer i;
        String name;
        String index;
        String description;

        //make an empty list 
        List<Product2> dummyProducts = new List<Product2>();

        //loop to fill products
        for(i = 0; i < numProducts; i++){
            index = String.valueOf(i+1);
            name = 'Test Product ' + index; 
            description = 'Description for Product: ' + name;
            dummyProducts.add(new Product2(Name = name, Description = description));
        }//end for i

        return dummyProducts;
    }//end createProducts

    //createAccount 
    public static Account createAccount(){
        Account newAccount = new Account(Name = 'Test');
        return newAccount;
    }//end createAccount

    //createAccounts
    public static List<Account> createAccounts(Integer numAccounts){
        List<Account> newAccounts = new List<Account>();
        String name;
        String index;
        Integer i;

        for( i = 0; i < numAccounts; i++){
            index = String.valueOf(i+1);
            name = 'Test ' + index;
            newAccounts.add(new Account(Name = name));
        }//end for i

        return newAccounts;
    }//end create Accounts

    //createContact
    public static Contact createContact(String accountId){
        Contact newContact = new Contact(FirstName = 'Test', LastName = 'Test', AccountId = accountId);
        return newContact;
    }//end create Contact
    
    //createContacts
    public static List<Contact> createContacts(Integer numContacts, List<Account> accounts){
        List<Contact> newContacts = new List<Contact>();
        String name;
        String index;
        Integer i;

        for( i = 0; i < numContacts; i++){
            index = String.valueOf(i+1);
            name = 'Test ' + index;
            newContacts.add(new Contact(FirstName = name, LastName = name, AccountId = accounts[i].Id));
        }//end for i

        return newContacts;
    }//end create Contacts

    //creatContract
    public static Contract createContract(String accountId, String contactId){
        Contract newContract = new Contract(AccountId = accountId, Contact__c = contactId);
        return newContract;
    }//end create Contract

    //createContracts
    public static List<Contract> createContracts(List<Account> accounts, List<Contact> contacts, Integer numContracts){
        List<Contract> newContracts = new List<Contract>();
        Integer i;

        for( i = 0; i < numContracts; i++){
            newContracts.add(new Contract(AccountId = accounts[i].Id, Contact__c = contacts[i].Id));
        }//end for i
        return newContracts;
    }//end create Contracts

    //createPricebookEntry
    public static PricebookEntry createPricebookEntry(Product2 product, Pricebook2 pricebook, Integer unitPrice){
        PricebookEntry newPricebookEntry = new PricebookEntry(Product2Id = product.Id, Pricebook2Id = pricebook.Id, UnitPrice = unitPrice);
        return newPricebookEntry;
    }//end createPricebookEntry

    //createPricebookEntries
    public static List<PricebookEntry> createPricebookEntries(List<Product2> products, Pricebook2 pricebook, Integer unitPrice, Integer numPricebookEntries){
        List<PricebookEntry> newPricebookEntries = new List<PricebookEntry>();
        Integer i;
        for(i = 0; i < numPricebookEntries; i++){
            newPricebookEntries.add(new PricebookEntry(Product2Id = products[i].Id, Pricebook2Id = pricebook.Id, UnitPrice = unitPrice));
        }//end for i
        return newPricebookEntries;
    }//end createPricebookEntries


}//end DataFactory
