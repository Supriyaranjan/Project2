public with sharing class productPageController {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts(){
        List<Product2> currProducts = [SELECT name, description, (SELECT Id, UnitPrice FROM PricebookEntries) FROM Product2];
        return currProducts;
    } //end getProducts

}
