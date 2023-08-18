public class PreventCategoryDeletionHandler {
    public static void PreventCategoryDeletion(List<Billing_Category__c> category) {
        // Check if the Billing Category paid status is checked
        for(Billing_Category__c c : category){
            if (c.Paid__c == false) {
                c.addError('Cannot delete a Billing Category with an unpaid bill.');
            }
        }
    }
    
}