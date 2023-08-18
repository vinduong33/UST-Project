@isTest
public class TestDataFactory {
    public static void MakeBill() {
         // Insert new bill with due date of today
         List<Bill__c> b = new List<Bill__c>();
         b.add(new Bill__c (
         Name = 'Test Bill',
         Due_Date__c = Date.today(),
         Amount_Due__c = 100,
         High_Priority__c = true));
         insert b;       
    }

}