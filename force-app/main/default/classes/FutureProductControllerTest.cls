@isTest
private class FutureProductControllerTest {
    @TestSetup 
    static void LoadData() {
        List<Product2> newProducts = new List<Product2>();
        for(Integer i = 1; i < 6; i++) {
            Product2 newProduct = new Product2(Name='FutureCar' + i, Description = 'New cars', DisplayUrl = '/sports/'+i+'.jpg',ProductCode='00'+i+'2030');
            newProducts.add(newProduct);
        }
        newProducts.add(new Product2(Name='FutureCustomCurrentCar', Description = 'Current cars', DisplayUrl = '',ProductCode=''));
        Insert newProducts;
    }

    @isTest
    static void TP_getFutureProducts(){
        Test.startTest();
        List<Product2> allProducts = FutureProductController.getFutureProducts();
        System.assertEquals(5,allProducts.size());
        System.assertEquals('Car1',allProducts[0].Name);
        Test.stopTest();
    }

    @isTest
    static void TP_saveFutureCustomProduct(){
        Test.startTest();
        Product2 testProduct = new Product2(Name='TestCar2', Description = 'Test car', DisplayUrl = '',ProductCode='');
        FutureProductController.saveFutureCustomProduct(testProduct);
        List<Product2> result = [SELECT Name,DisplayUrl,ProductCode FROM Product2 WHERE Name='FutureCustomTestCar2'];
        system.debug(result);
        System.AssertEquals('FutureCustomTestCar2',result[0].Name);
        Test.stopTest();
    }

    @isTest
    static void TN_saveFutureCustomProduct(){
        Test.startTest();
        Product2 testProduct1 = new Product2(Name='TestCar1', Description = 'Test cars', DisplayUrl = '',ProductCode='0012028');
        Boolean exceptionOccurred = false;
        try {
            FutureProductController.saveFutureCustomProduct(testProduct1);
        } catch (Exception e){
            //Set boolean to true to catch exception being thrown
            exceptionOccurred = true;
        }
        
        System.assert(exceptionOccurred, 'An Exception was not thrown');

        Product2 testProduct2 = new Product2(Name='TestCar1', Description = 'Test cars', DisplayUrl = '/sports/3.jpg',ProductCode='');
        exceptionOccurred = false;
        try {
            FutureProductController.saveFutureCustomProduct(testProduct2);
        } catch (Exception e){
            //Set boolean to true to catch exception being thrown
            exceptionOccurred = true;
        }
        
        System.assert(exceptionOccurred, 'An Exception was not thrown');

        Test.stopTest();
    }

    @isTest
    static void TN_saveFutureProduct(){
        Test.startTest();
        Product2 testProduct1 = new Product2(Name='FutureTestCar1', Description = 'Cars', DisplayUrl = '',ProductCode='0012028');
        Boolean exceptionOccurred = false;
        try {
            FutureProductController.saveFutureProduct(testProduct1);
        } catch (Exception e){
            //Set boolean to true to catch exception being thrown
            exceptionOccurred = true;
        }
        
        System.assert(exceptionOccurred, 'An Exception was not thrown');

        Product2 testProduct2 = new Product2(Name='FutureTestCar2', Description = '', DisplayUrl = '/sports/3.jpg',ProductCode='');
        exceptionOccurred = false;
        try {
            FutureProductController.saveFutureProduct(testProduct2);
        } catch (Exception e){
            //Set boolean to true to catch exception being thrown
            exceptionOccurred = true;
        }
        
        System.assert(exceptionOccurred, 'An Exception was not thrown');
        Test.stopTest();
    }    
}
