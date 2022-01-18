public with sharing class FutureProductController {

    //Get future product list from database, return company future products only, remove custom ideas product proposal
    @AuraEnabled
    public static List<Product2> getFutureProducts(){
        
            List<Product2> futureProducts = [SELECT Name,Description,DisplayUrl,ProductCode FROM Product2 WHERe Name LIKE '%Future%'];
            List<Product2> companyProducts = new List<Product2>();
            for(Integer i=0; i < futureProducts.size(); i++) {
                //Remove Future keyword from Name
                futureProducts[i].Name = futureProducts[i].Name.remove('Future');

                //Not contain custom idea product proposal
                if(futureProducts[i].Name.contains('Custom')) {
                    continue;
                }
                futureProducts[i].ProductCode = futureProducts[i].ProductCode.substring(3);
                companyProducts.add(futureProducts[i]);
            }            
            return companyProducts;
    }

    //Save custom product proposal, add keyword FutureCustom into name
    @AuraEnabled
    public static void saveFutureCustomProduct(Product2 newProduct){
        try {
            newProduct.Name = 'FutureCustom' + newProduct.Name;
            Insert newProduct;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Save company product
    @AuraEnabled
    public static void saveFutureProduct(Product2 currentProduct){
        try {
            Upsert currentProduct;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //For BEFORE_INSERT and BEFORE_UPDATE trigger
    public static void checkFutureKeyword(List<Product2> newProducts) {
        for(Integer i = 0; i < newProducts.size();i++) {

            System.debug('Godd'+ newProducts[i].Name);
            //If as company future product, product code and displayUrl must have value
            if((!newProducts[i].Name.contains('FutureCustom'))){
                if((newProducts[i].ProductCode == null) && (newProducts[i].Name.contains('Future'))){
                    newProducts[i].addError('FutureProduct not valid');
                }
                if((newProducts[i].DisplayUrl == null) && (newProducts[i].Name.contains('Future'))){
                    newProducts[i].addError('FutureProduct not valid');
                }
            } else {
                //If as future custom product proposal, product code and displayUrl must no value
                if(newProducts[i].DisplayUrl != null) {
                    newProducts[i].addError('FutureCustomProduct not valid');
                } else if(newProducts[i].ProductCode != null)  {
                    newProducts[i].addError('FutureCustomProduct not valid');
                }
            }
        }
    }
}
