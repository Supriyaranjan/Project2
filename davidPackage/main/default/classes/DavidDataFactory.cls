public with sharing class DavidDataFactory {
    

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
            name = 'Test ' + index; 
            description = 'Description for Product: ' + name;
            dummyProducts.add(new Product2(Name = name, Description = description));
        }//end for i

        return dummyProducts;
    }//end createProducts

    //createAccount 
    public static Account createAccount(){
        Account newAccount = new Account(Name = 'Test');
        return newAccount;
    }//end create

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
    }//end create

    //createContact
    public static Contact createContact(String accountId){
        Contact newContact = new Contact(FirstName = 'Test', LastName = 'Test', AccountId = accountId);
        return newContact;
    }//end create
    
    //createContacts
    public static list<Contact> createContacts(Integer numContacts, List<Account> accounts){
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
    }//end create

    //creatContract
    public static Contract createContract(String accountId, String contactId){
        Contract newContract = new Contract(AccountId = accountId, Contact__c = contactId);
        return newContract;
    }//end create

    //createContracts
    public static List<Contract> createContracts(List<Account> accounts, List<Contact> contacts, Integer numContracts){
        List<Contract> newContracts = new List<Contract>();
        Integer i;

        for( i = 0; i < numContracts; i++){
            newContracts.add(new Contract(AccountId = accounts[i].Id, Contact__c = contacts[i].Id));
        }//end for i
        return newContracts;
    }//end create



}//end DataFactory
