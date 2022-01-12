
@isTest
public with sharing class productPageControllerTest {
    //TP_getProducts
    //Test for a positive result of querying for products in the 
    //database
    @isTest 
    public static void TP_getProducts(){
        Test.startTest();
        //variables for testing
        List<Product2> testProducts = new List<Product2>();
        Boolean result;
        //create dummy data 
        List<Product2> currProducts = DataFactory.createProducts(3);
        //insert them 
        insert currProducts;
        //test function
        testProducts = productPageController.getProducts();
        if(testProducts.size() > 0){
            result = true;
        }//end if > 0
        else{
            result = false;
        }//end else
        //see results
        System.assertEquals(true, result);
        Test.stopTest();
    }//end TP_getProducts

    //TN_getProducts
    //Tests for a negative result, or failure to get products from database
    @isTest 
    public static void TN_getProducts(){
        Test.startTest();
        //create variables for testing 
        Boolean result;
        List<Product2> testProducts = new List<Product2>();
        //begin testing
        testProducts = productPageController.getProducts();
        //test function
        if(testProducts.size() > 0){
            result = true;
        }//end if
        else{
            result = false;
        }
        //see results
        System.assertEquals(false, result);
        Test.stopTest();
    }//end TN_getProducts
}//end productPageControllerTest
