import { LightningElement, wire } from 'lwc';
import getAllTasks from '@salesforce/apex/TaskCtrl.getAllTasks';
import TASK_OBJECT from '@salesforce/schema/Task__c';
import NAME_FIELD from '@salesforce/schema/Task__c.Name';
import DUE_DATE_FIELD from '@salesforce/schema/Task__c.Due_Date__c';
import STATUS_FIELD from '@salesforce/schema/Task__c.Status__c';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    {label: 'Task Name', fieldName: 'Name', type: 'text'},
    {label: 'Due Date', fieldName: 'Due_Date__c', type: 'date'},
    {label: 'Status', fieldName: 'Status__c', type: 'text'},
    {type: 'button', typeAttributes: {
        label: 'Complete',
        name: 'Complete'
    }}
];

export default class TaskList extends LightningElement {

    //tasks;
    columns = COLUMNS;
    objectName = TASK_OBJECT;
    fields = [NAME_FIELD, DUE_DATE_FIELD, STATUS_FIELD];

    /**
    @wire(getAllTasks)
    tasksHandler({data, error}){
        if(data){
            this.tasks = data;
        }
        if(error){
            console.error(error);
        }
    } */
    @wire(getAllTasks)
    tasks;

    successHandler(){
        refreshApex(this.tasks);
    }

    callRowAction(event){
        const taskId = event.detail.row.Id;

        const taskObj = {
            Id: taskId, 
            Status__c: 'Completed'
        }

        const recordInput = {
            fields: taskObj
        }
        updateRecord(recordInput)
            .then(result => {
                //display a toast message
                console.log(result);
            })
            .catch(error => {
                console.error(error);
            })
    }
}