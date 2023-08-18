@isTest
public class SetHighPriorityOnBillsHandler_Test {

    @TestSetup
    static void makeData(){
        TestDataFactory.MakeBill();
    }   

    @isTest public static void TestInsertSetHighPriorityOnBills() {
        // Check if inserted bill has high priority checked
        Bill__c bill = [SELECT Id, High_Priority__c FROM Bill__c WHERE Name = 'Test Bill' LIMIT 1];
        system.assertEquals(true, bill.High_Priority__c);
    }

    @isTest public static void TestUpdateSetHighPriorityOnBills() {
        // Check if updated bill that is due in the future has high priority not checked
        Bill__c bill = [SELECT Id, High_Priority__c FROM Bill__c WHERE Name = 'Test Bill' LIMIT 1];
     
        bill.Due_Date__c = Date.today().addDays(4);
        bill.High_Priority__c = false;
       
        Test.startTest();
        update bill;
        Test.stopTest();

        system.assertEquals(false, bill.High_Priority__c);
    }
}