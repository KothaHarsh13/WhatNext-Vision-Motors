# 📘 Project Overview: WhatNext Vision Motors – Salesforce CRM Integration

## 🚗 Introduction

**WhatNext Vision Motors** is a visionary player in the automotive industry, committed to transforming mobility with cutting-edge technology. To enhance customer satisfaction and streamline operations, the company launched a strategic Salesforce CRM implementation project as part of a virtual internship program under the Agentblazer Champion initiative.

---

## 🎯 Objectives

The key goals of this Salesforce project are:

- Simplify the **vehicle ordering experience**
- Automate **dealer assignment** based on customer location
- Enforce **stock validation** during order placement
- Automate **order fulfillment updates** using Scheduled and Batch Apex
- Improve visibility of **order statuses** for both staff and customers

---

## 🔑 Core Functionalities

### 1. 🚫 Prevent Ordering Out-of-Stock Vehicles
- When a user attempts to place an order for a vehicle with zero stock, the system blocks the action with a clear error message.
- Handled using **Apex Trigger + Validation Logic**.

### 2. 📍 Auto-Assignment of Nearest Dealer
- Automatically assigns a nearby dealer to the order based on the customer’s address.
- Improves user convenience and dealer efficiency.
- Implemented using **Flows** and **Geolocation logic (simulated)**.

### 3. 🔁 Order Status Update Based on Stock
- Uses a **Batch Apex** process to loop through all `Pending` orders.
- If stock is available, the order is set to `Confirmed`, and stock is reduced.
- Scheduled daily using **Scheduled Apex**.

### 4. 📨 Automated Reminders for Test Drives *(optional enhancement)*
- Record-triggered Flow to send an email reminder for upcoming test drive schedules.

---

## ⚙️ Technical Implementation

| Component            | Purpose                                                                 |
|---------------------|-------------------------------------------------------------------------|
| `VehicleOrderTrigger` | Validates stock before allowing order creation                         |
| `VehicleOrderTriggerHandler` | Contains modular logic to enforce stock and update vehicle inventory |
| `VehicleOrderBatch`  | Batch Apex to confirm pending orders and reduce stock                  |
| `VehicleOrderBatchScheduler` | Scheduled Apex to run batch jobs at fixed intervals              |
| `auto_assign_dealer_flow.flow-meta.xml` | Salesforce Flow that assigns the closest dealer automatically |
| Custom Objects        | `Vehicle__c`, `Vehicle_Order__c`, `Dealer__c`, etc.                     |

---

## 📊 Benefits

- ⏱️ **Reduced Manual Work:** Automated processes for stock checking and dealer assignment.
- ✅ **Improved Accuracy:** Real-time stock validation eliminates invalid orders.
- 😊 **Better User Experience:** Customers know exactly what’s available and where.
- 📈 **Scalability:** Clean Apex architecture allows easy extension for features like invoicing or delivery tracking.

---

## 📁 Related Files

| File                         | Description                                       |
|------------------------------|---------------------------------------------------|
| `README.md`                 | Summary, features, and usage                      |
| `System_Requirements.md`    | System, browser, and network requirements         |
| `apex/`                     | Trigger, Apex classes, Batch & Scheduler code     |
| `flows/`                    | Metadata for Flow automation                      |

---

## 🙌 Acknowledgment

This project was developed as part of the **Salesforce Developer Virtual Internship** under the **Agentblazer Champion** program.

