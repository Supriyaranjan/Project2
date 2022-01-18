@isTest
public with sharing class OrderItemTriggerHelperTest {
   
    @isTest
    public static void testMaxOrderQuant(){
        Test.startTest();
        OrderItem orderitem1 = new OrderItem();
        orderitem1.Quantity = 100;
        Database.SaveResult res = Database.insert(orderitem1, false);
        System.assertEquals('ERROR: Too many items!', res.getErrors()[0].getMessage());
        Test.stopTest();

    }

    @isTest
    public static void testNegMaxOrderQuant(){
        Test.startTest();
        OrderItem orderitem1 = new OrderItem();
        orderitem1.Quantity = 98;
        Database.SaveResult res = Database.insert(orderitem1, false);
        System.assertEquals(true, res.isSucess());
        Test.stopTest();

    }
}
