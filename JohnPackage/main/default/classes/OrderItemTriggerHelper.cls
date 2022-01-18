public with sharing class OrderItemTriggerHelper {
    
    public static void maxOrderQuant(List<OrderItem> newOrders) {
        for (OrderItem orders: newOrders) {
            if(orders.Quantity > 99) {
                orders.addError('ERROR: Too many items!');
            }
        }
    }
}
