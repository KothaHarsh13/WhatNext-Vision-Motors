# 🧩 Objects & Relationships – WhatNext Vision Motors Salesforce Project

This document outlines the custom Salesforce objects used in the project and their relationships.

---

## 📦 Object Summary

| Object Name                   | Purpose                           | Relationships                        |
|------------------------------|-----------------------------------|--------------------------------------|
| `Vehicle__c`                 | Stores vehicle details            | Related to `Vehicle_Order__c`, `Vehicle_Test_Drive__c`, `Vehicle_Service_Request__c`, and `Vehicle_Dealer__c` |
| `Vehicle_Dealer__c`          | Stores authorized dealer info     | Related to `Vehicle__c` and `Vehicle_Order__c`          |
| `Vehicle_Customer__c`        | Stores customer details           | Related to `Vehicle_Order__c`, `Vehicle_Test_Drive__c`, `Vehicle_Service_Request__c` |
| `Vehicle_Order__c`           | Tracks vehicle purchases          | Related to `Vehicle_Customer__c`, `Vehicle__c`, `Vehicle_Dealer__c` |
| `Vehicle_Test_Drive__c`      | Tracks test drive bookings        | Related to `Vehicle_Customer__c`, `Vehicle__c`          |
| `Vehicle_Service_Request__c` | Tracks vehicle servicing requests | Related to `Vehicle_Customer__c`, `Vehicle__c`          |

---

## 🔗 Relationship Overview

- A `Vehicle_Customer__c` can:
  - Place multiple `Vehicle_Order__c`
  - Book multiple `Vehicle_Test_Drive__c`
  - Raise multiple `Vehicle_Service_Request__c`

- A `Vehicle__c` can:
  - Be ordered by many `Vehicle_Order__c`
  - Be test driven through multiple `Vehicle_Test_Drive__c`
  - Be serviced via multiple `Vehicle_Service_Request__c`

- A `Vehicle_Dealer__c` can:
  - Be linked to multiple `Vehicle__c` (availability)
  - Be auto-assigned during order placement via Flow logic

---

## 📝 Notes

- All relationships are **lookup** or **master-detail**, depending on business rules.
- Flows and Apex logic make use of these relationships for auto-assignment, stock validation, and test drive scheduling.

