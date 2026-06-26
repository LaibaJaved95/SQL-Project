CREATE SCHEMA CropHealthSystem;
USE CropHealthSystem;

CREATE TABLE Farmer (
    FarmerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50) UNIQUE,
    Location VARCHAR(50)
);

CREATE TABLE Physician (
    PhysicianID INT PRIMARY KEY,
    Name VARCHAR(50),
    Specialization VARCHAR(50)
);

CREATE TABLE CaseTable (
    CaseID INT PRIMARY KEY,
    FarmerID INT,
    Description VARCHAR(100),
    Status VARCHAR(20),
    ConfidenceScore DECIMAL(5,2),
    FOREIGN KEY (FarmerID) REFERENCES Farmer(FarmerID)
);

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    FarmerID INT,
    PhysicianID INT,
    Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (FarmerID) REFERENCES Farmer(FarmerID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID)
);

INSERT INTO Farmer VALUES (1, 'Ali', 'ali@gmail.com', 'Punjab');
INSERT INTO Farmer VALUES (2, 'Sara', 'sara@gmail.com', 'Sindh');

INSERT INTO Physician VALUES (1, 'Dr. Ahmed', 'Crop Disease');
INSERT INTO Physician VALUES (2, 'Dr. Khan', 'Soil Expert');

INSERT INTO CaseTable VALUES (101, 1, 'Leaf spots', 'AI Diagnosed', 0.85);
INSERT INTO CaseTable VALUES (102, 1, 'Yellow leaves', 'Forwarded', 0.40);
INSERT INTO CaseTable VALUES (103, 2, 'Fungal infection', 'AI Diagnosed', 0.90);

INSERT INTO Appointment VALUES (1, 1, 1, '2026-04-25', 'Accepted');
INSERT INTO Appointment VALUES (2, 2, 2, '2026-04-26', 'Pending');


SELECT *
FROM CaseTable
WHERE ConfidenceScore > (
    SELECT AVG(ConfidenceScore)
    FROM CaseTable
);


SELECT *
FROM CaseTable
WHERE FarmerID IN (
    SELECT FarmerID
    FROM Farmer
    WHERE Location = 'Punjab'
);


SELECT *
FROM CaseTable C
WHERE EXISTS (
    SELECT 1
    FROM Farmer F
    WHERE F.FarmerID = C.FarmerID
);