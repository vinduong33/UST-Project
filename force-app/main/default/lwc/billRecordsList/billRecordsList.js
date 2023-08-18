import { LightningElement, wire, track } from 'lwc';
import getBillRecords from '@salesforce/apex/AccountController.getBillRecords';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Bill Name', fieldName: 'Name', type: 'text' },
    { label: 'Amount Due', fieldName: 'Amount_Due__c', type: 'currency' },
    { label: 'Amount Remaining', fieldName: 'Amount_Remaining__c', type: 'currency' },
    { label: 'Due Date', fieldName: 'Due_Date__c', type: 'date' }
];

export default class BillRecordsList extends LightningElement {
    @track bills = [];
    @track columns = COLUMNS;
    error;
    wiredResult;

    // Wire service call to fetch bill records
    @wire(getBillRecords) 
    wiredBillRecords(result) {
        this.wiredResult = result; // Store the result
        const { data, error } = result;
        if (data) {
            this.bills = data;
            refreshApex(this.wiredResult); // Refresh the data to ensure updates
        } else if (error) {
            this.error = error;
            console.error(error);
        }
    }
}