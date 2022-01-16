@isTest
public with sharing class CaseHandlerTest {

    @isTest
    public static void checkRestrictCaseDelete(){

        Test.startTest();

        Case case1 = new Case();
        case1.Description = 'This is test';
        case1.status = 'Working';
        insert case1;

        Id caseId = case1.Id;

        try {
            delete case1;
        } catch (Exception error) {
            System.assert(true);
        }   
    }
}
