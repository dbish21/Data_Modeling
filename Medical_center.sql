CREATE TABLE MedicalCenter (
    MedicalCenterID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Doctors (
    DoctorID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Specialty VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255),
    MedicalCenterID INT,
    FOREIGN KEY (MedicalCenterID) REFERENCES MedicalCenter(MedicalCenterID)
);

CREATE TABLE Patients (
    PatientID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    DateOfBirth DATE,
    Gender CHAR(1),
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE Diseases (
    DiseaseID SERIAL PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    ICDCode VARCHAR(10)
);

CREATE TABLE Visits (
    VisitID SERIAL PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    VisitDate DATE,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Diagnoses (
    DiagnosisID SERIAL PRIMARY KEY,
    VisitID INT,
    DiseaseID INT,
    FOREIGN KEY (VisitID) REFERENCES Visits(VisitID),
    FOREIGN KEY (DiseaseID) REFERENCES Diseases(DiseaseID)
);
