@isTest
public with sharing class CaseWebControllerTest {
    public CaseWebControllerTest() {

    }

    @isTest
    public static void testFAQList()
    {
        Test.startTest();
        List<FAQ__c> faqLst = new List<FAQ__c>();
        for(Integer num = 0; num < 4; num++) {
            FAQ__c faqRec = new FAQ__c();
            faqRec.Topic__c = 'Test Topic';
            faqRec.Question__c = 'This is question ' + num;
            faqRec.Answer__c = 'This is answer ' + num;
            
            faqLst.add(faqRec);
        }
        try{
            insert faqLst;
            List<FAQ__c> insertedFAQ = CaseWebController.GetFAQList();
            System.assertEquals(4, insertedFAQ.size());
        }
        catch(Exception exp){
            System.assert(false);
        }
    }

    @isTest
    public static void testFAQByTopic(){

        Test.startTest();
        List<FAQ__c> faqLst = new List<FAQ__c>();
        for(Integer num = 0; num < 4; num++) {
            FAQ__c faqRec = new FAQ__c();
            faqRec.Topic__c = 'Test Topic';
            faqRec.Question__c = 'This is question ' + num;
            faqRec.Answer__c = 'This is answer ' + num;
            
            faqLst.add(faqRec);
        }
        try{
            insert faqLst;
            List<FAQ__c> insertedFAQ = CaseWebController.GetFAQByTopic('Test Topic');
            System.assertEquals(4, insertedFAQ.size());
        }
        catch(Exception exp){
            System.assert(false);
        }
        
    }

    @isTest
    public static void testFAQTopics(){

        Test.startTest();
        List<FAQ__c> faqLst = new List<FAQ__c>();
        for(Integer num = 0; num < 4; num++) {
            FAQ__c faqRec = new FAQ__c();
            faqRec.Topic__c = 'Test Topic' + num;
            faqRec.Question__c = 'This is question ' + num;
            faqRec.Answer__c = 'This is answer ' + num;
            
            faqLst.add(faqRec);
        }
        try{
            insert faqLst;
            List<String> insertedFAQTopics = CaseWebController.GetFAQTopic();
            System.assertEquals(4, insertedFAQTopics.size());
        }
        catch(Exception exp){
            System.assert(false);
        }
        
    }
}
