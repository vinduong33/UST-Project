import { LightningElement, wire, track, api } from 'lwc';
import getPaymentRecords from '@salesforce/apex/AccountController.getPaymentRecords';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Bill Name', fieldName: 'Related_Bill_Name__c', type: 'text' },
    { label: 'Payment Description', fieldName: 'Name', type: 'text' },
    { label: 'Amount Paid', fieldName: 'Amount_Paid__c', type: 'currency' },
    { label: 'Payment Date', fieldName: 'Payment_Date__c', type: 'date' }
];

export default class PaymentRecordsList extends LightningElement {
    @track payments = [];
    @track columns = COLUMNS;
    error;
    wiredResult;

    // Wire service call to fetch payment records
    @wire(getPaymentRecords) 
    wiredPaymentRecords(result) {
        this.wiredResult = result; // Store the result
        const { data, error } = result;
        if (data) {
            // Map payment records and create a 'Related_Bill_Name__c' field for display
            this.payments = data.map(payment => ({
                ...payment,
                Related_Bill_Name__c: payment.Bill__c ? payment.Bill__r.Name : ''
            }));
            refreshApex(this.wiredResult); // Refresh the data to ensure updates
        } else if (error) {
            this.error = error;
            console.error(error);
        }
    }
}