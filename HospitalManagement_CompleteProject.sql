-- Step 1: Create Database
CREATE DATABASE HospitalDB;
GO

USE HospitalDB;
GO

-- 1. Departments Table
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

-- 2. Doctors Table
CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID)
);

-- 3. Patients Table
CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

-- 4. Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
    AppointmentDate DATETIME NOT NULL,
    Status VARCHAR(30) DEFAULT 'Scheduled' -- e.g., Scheduled, Completed, Cancelled
);

-- 5. Medicines Table
CREATE TABLE Medicines (
    MedicineID INT IDENTITY(1,1) PRIMARY KEY,
    MedicineName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL
);

-- 6. Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT FOREIGN KEY REFERENCES Appointments(AppointmentID),
    PrescriptionDate DATE DEFAULT GETDATE(),
    Notes VARCHAR(255)
);

-- 7. Prescription Details (Many-to-Many linking Prescriptions and Medicines)
CREATE TABLE PrescriptionDetails (
    PrescriptionDetailID INT IDENTITY(1,1) PRIMARY KEY,
    PrescriptionID INT FOREIGN KEY REFERENCES Prescriptions(PrescriptionID),
    MedicineID INT FOREIGN KEY REFERENCES Medicines(MedicineID),
    Quantity INT NOT NULL,
    Dosage VARCHAR(50) -- e.g., 1 tablet twice a day
);

-- 8. Payments Table
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT FOREIGN KEY REFERENCES Appointments(AppointmentID),
    TotalAmount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentStatus VARCHAR(30) DEFAULT 'Pending' -- Paid, Pending
);

GO

-- 1. Insert Departments
INSERT INTO Departments (DepartmentName, Description) VALUES
('Cardiology', 'Heart and cardiovascular care'),
('Neurology', 'Brain and nervous system disorders'),
('Pediatrics', 'Child healthcare and treatment'),
('Orthopedics', 'Bones, joints, and muscles care');

-- 2. Insert Doctors
INSERT INTO Doctors (FirstName, LastName, Specialization, Phone, Email, DepartmentID) VALUES
('Hamna', 'Khan', 'Cardiologist', '0300-1234567', 'ali.khan@hospital.com', 1),
('Ayesha', 'Ahmed', 'Neurologist', '0301-7654321', 'ayesha.ahmed@hospital.com', 2),
('Usman', 'Farooq', 'Pediatrician', '0302-9876543', 'usman.farooq@hospital.com', 3),
('Fatima', 'Zehra', 'Orthopedic Surgeon', '0303-4567891', 'fatima.zehra@hospital.com', 4);

-- 3. Insert Patients
INSERT INTO Patients (FirstName, LastName, Gender, DateOfBirth, Phone, Address) VALUES
('Bilal', 'Hassan', 'Male', '1990-05-12', '0312-1112233', 'Clifton, Karachi'),
('Zainab', 'Malik', 'Female', '1995-08-20', '0313-4445566', 'Gulshan, Karachi'),
('Hamza', 'Raza', 'Male', '1985-11-05', '0314-7778899', 'DHA, Karachi'),
('Maryam', 'Siddiqui', 'Female', '2000-02-15', '0315-0001122', 'North Nazimabad, Karachi');

-- 4. Insert Medicines
INSERT INTO Medicines (MedicineName, Category, UnitPrice, StockQuantity) VALUES
('Disprin', 'Painkiller', 15.50, 500),
('Augmentin', 'Antibiotic', 350.00, 200),
('Panadol', 'Painkiller', 10.00, 1000),
('Omeprazole', 'Gastric', 120.00, 300),
('Calpol', 'Syrup', 150.00, 150);

-- 5. Insert Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) VALUES
(1, 1, '2026-06-01 10:00:00', 'Completed'),
(2, 2, '2026-06-02 11:30:00', 'Completed'),
(3, 3, '2026-06-03 09:15:00', 'Scheduled'),
(4, 4, '2026-06-04 14:00:00', 'Scheduled');

-- 6. Insert Prescriptions
INSERT INTO Prescriptions (AppointmentID, PrescriptionDate, Notes) VALUES
(1, '2026-06-01', 'Take rest and avoid oily food.'),
(2, '2026-06-02', 'Complete the antibiotic course for 5 days.');

-- 7. Insert Prescription Details
INSERT INTO PrescriptionDetails (PrescriptionID, MedicineID, Quantity, Dosage) VALUES
(1, 3, 10, '1 tablet twice a day'),
(1, 1, 5, 'As needed for pain'),
(2, 2, 14, '1 tablet morning and evening'),
(2, 4, 14, '1 tablet before breakfast');

-- 8. Insert Payments
INSERT INTO Payments (AppointmentID, TotalAmount, PaymentDate, PaymentStatus) VALUES
(1, 1500.00, '2026-06-01 10:45:00', 'Paid'),
(2, 2000.00, '2026-06-02 12:15:00', 'Paid'),
(3, 1200.00, '2026-06-03 10:00:00', 'Pending');
 select * from Doctors;
 SELECT 
    A.AppointmentID,
    P.FirstName + ' ' + P.LastName AS PatientName,
    D.FirstName + ' ' + D.LastName AS DoctorName,
    D.Specialization,
    A.AppointmentDate,
    A.Status
FROM Appointments A
INNER JOIN Patients P ON A.PatientID = P.PatientID
INNER JOIN Doctors D ON A.DoctorID = D.DoctorID;


SELECT 
    Pr.PrescriptionID,
    P.FirstName + ' ' + P.LastName AS PatientName,
    M.MedicineName,
    PD.Quantity,
    PD.Dosage,
    Pr.Notes
FROM Prescriptions Pr
INNER JOIN Appointments A ON Pr.AppointmentID = A.AppointmentID
INNER JOIN Patients P ON A.PatientID = P.PatientID
INNER JOIN PrescriptionDetails PD ON Pr.PrescriptionID = PD.PrescriptionID
INNER JOIN Medicines M ON PD.MedicineID = M.MedicineID;

SELECT 
    SUM(TotalAmount) AS TotalRevenue
FROM Payments
WHERE PaymentStatus = 'Paid';
 --Viewssss--
go
CREATE VIEW vw_AppointmentDetails AS
SELECT 
    A.AppointmentID,
    P.FirstName + ' ' + P.LastName AS PatientName,
    P.Phone AS PatientPhone,
    D.FirstName + ' ' + D.LastName AS DoctorName,
    D.Specialization,
    A.AppointmentDate,
    A.Status
FROM Appointments A
INNER JOIN Patients P ON A.PatientID = P.PatientID
INNER JOIN Doctors D ON A.DoctorID = D.DoctorID;
GO

SELECT * FROM vw_AppointmentDetails;


go
---Stored Procedure--
CREATE PROCEDURE sp_GetDoctorsByDepartment
    @DepartmentName VARCHAR(100)
AS
BEGIN
    SELECT 
        D.DoctorID,
        D.FirstName + ' ' + D.LastName AS DoctorName,
        D.Specialization,
        D.Phone,
        D.Email,
        Dep.DepartmentName
    FROM Doctors D
    INNER JOIN Departments Dep ON D.DepartmentID = Dep.DepartmentID
    WHERE Dep.DepartmentName = @DepartmentName;
END;
GO

EXEC sp_GetDoctorsByDepartment @DepartmentName = 'Cardiology';

SELECT TOP 1
    D.FirstName + ' ' + D.LastName AS DoctorName,
    D.Specialization,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM Doctors D
LEFT JOIN Appointments A ON D.DoctorID = A.DoctorID
GROUP BY D.DoctorID, D.FirstName, D.LastName, D.Specialization
ORDER BY TotalAppointments DESC;

SELECT 
    Dep.DepartmentName,
    COUNT(D.DoctorID) AS TotalDoctors
FROM Departments Dep
LEFT JOIN Doctors D ON Dep.DepartmentID = D.DepartmentID
GROUP BY Dep.DepartmentName
HAVING COUNT(D.DoctorID) > 0;


SELECT MedicineName, UnitPrice, Category
FROM Medicines
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Medicines);


--Function--
go
CREATE FUNCTION fn_GetDoctorTotalAppointments (@DocID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalAppts INT;
    SELECT @TotalAppts = COUNT(*) 
    FROM Appointments 
    WHERE DoctorID = @DocID;
    
    RETURN @TotalAppts;
END;
GO

SELECT dbo.fn_GetDoctorTotalAppointments(1) AS Doctor1Appointments;


--Trigger--
go
CREATE TRIGGER trg_PreventNegativeStock
ON Medicines
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE StockQuantity < 0)
    BEGIN
        RAISERROR ('Error: Stock quantity cannot be negative!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

--transaction--
BEGIN TRANSACTION;

BEGIN TRY  
    UPDATE Appointments 
    SET Status = 'Completed' 
    WHERE AppointmentID = 3;

    UPDATE Payments 
    SET PaymentStatus = 'Paid', PaymentDate = GETDATE() 
    WHERE AppointmentID = 3;

    COMMIT TRANSACTION;
    PRINT 'Transaction Successful! Payment processed and appointment completed.';
END TRY
BEGIN CATCH
   
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred! Transaction rolled back.';
END CATCH;