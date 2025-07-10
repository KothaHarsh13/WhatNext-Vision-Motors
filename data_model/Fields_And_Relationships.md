# 🧾 Fields & Relationships – WhatNext Vision Motors Salesforce Project

This document lists the key fields and data types for each custom object used in the project, along with their relationships.

---

## 1️⃣ Vehicle__c (Custom Object)

| Field Name           | Data Type   | Description                          |
|----------------------|-------------|--------------------------------------|
| Vehicle_Name__c      | Text        | Name of the vehicle                  |
| Vehicle_Model__c     | Picklist    | Model Type (Sedan, SUV, EV, etc.)   |
| Stock_Quantity__c    | Number      | Quantity available in stock          |
| Price__c             | Currency    | Price of the vehicle                 |
| Dealer__c            | Lookup      | Lookup to `Vehicle_Dealer__c`       |
| Status__c            | Picklist    | Available, Out of Stock, Discontinued |

---

## 2️⃣ Vehicle_Dealer__c (Custom Object)

| Field Name           | Data Type   | Description                          |
|----------------------|-------------|--------------------------------------|
| Dealer_Name__c       | Text        | Name of the authorized dealer        |
| Dealer_Location__c   | Text        | Location/address of the dealer       |
| Dealer_Code__c       | Auto Number | Unique code for each dealer          |
| Phone__c             | Phone       | Dealer contact number                |
| Email__c             | Email       | Dealer email address                 |

---

## 3️⃣ Vehicle_Order__c (Custom Object)

| Field Name           | Data Type   | Description                          |
|----------------------|-------------|--------------------------------------|
| Customer__c          | Lookup      | Lookup to `Vehicle_Customer__c`      |
| Vehicle__c           | Lookup      | Lookup to `Vehicle__c`               |
| Order_Date__c        | Date        | Date of order                        |
| Status__c            | Picklist    | Pending, Confirmed, Delivered, Canceled |

---

## 4️⃣ Vehicle_Customer__c (Custom Object)

| Field Name                 | Data Type   | Description                          |
|----------------------------|-------------|--------------------------------------|
| Customer_Name__c           | Text        | Full name of the customer            |
| Email__c                   | Email       | Customer email address               |
| Phone__c                   | Phone       | Customer contact number              |
| Address__c                 | Text        | Residential address                  |
| Preferred_Vehicle_Type__c | Picklist    | Sedan, SUV, EV, etc.                 |

---

## 5️⃣ Vehicle_Test_Drive__c (Custom Object)

| Field Name           | Data Type   | Description                          |
|----------------------|-------------|--------------------------------------|
| Customer__c          | Lookup      | Lookup to `Vehicle_Customer__c`      |
| Vehicle__c           | Lookup      | Lookup to `Vehicle__c`               |
| Test_Drive_Date__c   | Date        | Date scheduled for the test drive    |
| Status__c            | Picklist    | Scheduled, Completed, Canceled       |

---

## 6️⃣ Vehicle_Service_Request__c (Custom Object)

| Field Name           | Data Type   | Description                          |
|----------------------|-------------|--------------------------------------|
| Customer__c          | Lookup      | Lookup to `Vehicle_Customer__c`      |
| Vehicle__c           | Lookup      | Lookup to `Vehicle__c`               |
| Service_Date__c      | Date        | Date of service request              |
| Issue_Description__c | Text        | Problem or issue reported            |
| Status__c            | Picklist    | Requested, In Progress, Completed    |

---

## 📌 Notes

- All **lookup fields** are used to build relationships between objects.
- Picklist values enforce **data consistency** and support UI automation.
- Validation rules, flows, and Apex use these fields for logic implementation.

