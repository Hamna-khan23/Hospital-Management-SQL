# 🏥 Hospital Management Database (SQL Server)

A comprehensive, production-ready SQL database project designed to showcase advanced database design, complex querying, and programmatic database objects in Microsoft SQL Server (SSMS).

---

## 📂 Database Schema & Architecture
The database consists of 8 normalized tables with proper Primary and Foreign Key constraints:
1. **Departments** - Manages hospital departments.
2. **Doctors** - Stores doctor profiles and department links.
3. **Patients** - Maintains patient demographics.
4. **Appointments** - Tracks patient-doctor bookings and statuses.
5. **Medicines** - Inventory management for medical supplies.
6. **Prescriptions** - Links appointments to medical notes.
7. **PrescriptionDetails** - Junction table handling prescription items and dosages.
8. **Payments** - Financial tracking for appointments and billing status.
   

---

## 🛠️ Features & SQL Concepts Covered
* **DDL & DML Operations:** `CREATE DATABASE`, `CREATE TABLE`, `INSERT`, `UPDATE`, `DELETE`, `SELECT`
* **Relational Integrity:** Primary Keys, Foreign Keys, and Constraints (`CHECK`, `DEFAULT`)
* **Advanced Joins:** `INNER JOIN`, `LEFT JOIN`, and multi-table joins.
* **Aggregations & Filtering:** `GROUP BY`, `HAVING`, `ORDER BY`, Aggregate Functions (`SUM`, `AVG`, `COUNT`).
* **Programmability:** 
  * **Views:** Reusable virtual tables for complex reporting (`vw_AppointmentDetails`).
  * **Stored Procedures:** Dynamic logic execution (`sp_GetDoctorsByDepartment`).
  * **Functions:** Scalar functions for computed values (`fn_GetDoctorTotalAppointments`).
  * **Triggers:** Automated data validation (`trg_PreventNegativeStock`).
* **Subqueries:** Nested queries for dynamic filtering (e.g., finding medicines above average price).
* **Transactions:** ACID-compliant transaction blocks with `BEGIN TRAN`, `COMMIT`, `TRY...CATCH`, and `ROLLBACK` for safe multi-step database updates.

---

## 🚀 How to Run
1. Open **SQL Server Management Studio (SSMS)**.
2. All database scripts, queries, and programmable objects are consolidated into a single file (`HospitalManagement_CompleteProject.sql`).
3. Open the file in SSMS and execute the entire script to create the database, tables, sample data, and all advanced objects.
4. Once executed, you can individually test or run specific reports, views, stored procedures, or transaction blocks as needed.

---
*Developed as part of a professional full-stack development portfolio.*
