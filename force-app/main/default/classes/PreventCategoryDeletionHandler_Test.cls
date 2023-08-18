@isTest
public class PreventCategoryDeletionHandler_Test {

    @TestSetup
    static void makeData(){
        TestDataFactory.MakeBill();
    }   

    @isTest public static void TestPreventCategoryDelete() {   
        // Query bill and add category expense record
        Bill__c b = [SELECT Id FROM Bill__c WHERE Name = 'Test Bill' LIMIT 1];

        Billing_Category__c c = new Billing_Category__c();
        c.Name = 'Test Category';
        c.Description__c = 'Water';
        c.Bill__c = b.Id;  
        
        
        try {
            // Insert then try deleting 
            Test.startTest();
            insert c;
            delete c;
            Test.stopTest();

        } catch (Exception e) {

            // Check for error message
            Boolean expectedExceptionThrown =  e.getMessage().contains('Cannot delete a Billing Category with an unpaid bill.') ? true : false;
            system.assertEquals(true, expectedExceptionThrown);
        }
    }
}