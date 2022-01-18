public with sharing class CaseWebController {
//Function to get FAQ list
    @AuraEnabled
    public static List<FAQ__c> GetFAQList(){
        try 
        {
            System.Debug('I am here GetFAQList');
            List<FAQ__c> faqList =[select Id, Name, Topic__c, Question__c, Answer__c from FAQ__c];
            return faqList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //function to get FAQ list by topic
    @AuraEnabled
    public static List<FAQ__c> GetFAQByTopic(String topicName){
    try {
        System.Debug('I am here GetFAQByTopic');
        String topicLike = '';
        if (topicName != '')
        {
            topicLike = '%'+ topicName +'%';
        }
        List<FAQ__c> faqList =[select Id, Name, Topic__c, Question__c, Answer__c from FAQ__c where Topic__c LIKE : topicLike LIMIT 5];
        return faqList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    
    }

    //Function to get unique FAQ topics
    @AuraEnabled
    public static List<String> GetFAQTopic(){
    try {
        System.Debug('I am here GetFAQTopic');
        List<String> faqTopics = new List<String>();

        //List<FAQ__c> faqTopicList =[select Id, Name, Topic__c, Question__c, Answer__c from FAQ__c LIMIT 5];
        AggregateResult[] faqTopicList = [select Topic__c from FAQ__c Group By Topic__c];
        
        for(AggregateResult faq : faqTopicList){
            String faqTopic = (String)faq.get('Topic__c');
            faqTopics.add(faqTopic);
        }
        return faqTopics;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    
    }
}
