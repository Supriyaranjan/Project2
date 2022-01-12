public with sharing class DataFactory {
    
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

}//end DataFactory
