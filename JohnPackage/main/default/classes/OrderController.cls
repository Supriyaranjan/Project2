public with sharing class OrderController {
    @AuraEnabled(cacheable=true)
    public static List<Order> getOrderList(){

       Id loggedInUserId = UserInfo.getUserId();

        return [
            SELECT Id, OrderNumber, OwnerId, EffectiveDate
            FROM Order
            WHERE OwnerId = :loggedInUserId

        ];
    }
}