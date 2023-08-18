public with sharing class PreventNoteDeletionHandler {
    public static void PreventNoteDeletionIfBillIsNotPaid(List<Billing_Payment_Note__c> notes) {
        // Check if the Bill is Paid is checked
        for(Billing_Payment_Note__c n : notes){
            if (n.Bill_is_Paid__c == false) {
                n.addError('Cannot delete a Billing Payment Note with an unpaid bill.');
            }
        }
    }
}