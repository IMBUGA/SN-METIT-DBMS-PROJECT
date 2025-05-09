/*Title of the project; SN METIT Clinic Appointment Booking System */
/*I'm going to create a database for a clinic appointment booking system.*/
/*The system will allow patients to book appointments with medical staff, manage their medical records, and handle prescriptions.*/
/*The database will include tables for departments, specializations, rooms, users (for admin/staff), medical staff, patients, appointments, and prescriptions.*/
/*The database will be designed to ensure data integrity and relationships between the tables.*/
/*It's a procedural process*/
/*The database will be created using SQL statements, and sample data will be inserted into the tables for testing purposes.*/

/*1. Creating sn_metit_clinic Database*/
CREATE DATABASE IF NOT EXISTS sn_metit_clinic;
USE sn_metit_clinic;

/*2. Departments*/
USE sn_metit_clinic;
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

/*3. Specializations*/
USE sn_metit_clinic;
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

/*4. Rooms*/
USE sn_metit_clinic;
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    floor INT NOT NULL
);

/*5. Users (login for admins/staff)*/
USE sn_metit_clinic;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'staff') NOT NULL
);

/*6. Medical Staff*/
USE sn_metit_clinic;
CREATE TABLE Medical_Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    specialization_id INT NOT NULL,
    department_id INT NOT NULL,
    user_id INT UNIQUE,
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

/*7. Patients*/
USE sn_metit_clinic;
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);

/*8. Appointments*/
USE sn_metit_clinic;
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    staff_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    room_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Medical_Staff(staff_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
/*9. Prescriptions*/
USE sn_metit_clinic;
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medicine_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

/*10. Insert Specializations*/
USE sn_metit_clinic;
INSERT INTO Specializations (name) VALUES
('Nurse'),
('Physiotherapist'),
('Clinical Psychologist'),
('Therapist'),
('Psychiatrist'),
('Radiographer');

/*11. Insert Departments*/
USE sn_metit_clinic;
INSERT INTO Departments (name) VALUES
('General Medicine'),
('Radiology'),
('Mental Health'),
('Physiotherapy'),
('Nursing Services');

/*12. Insert Users*/
USE sn_metit_clinic;
INSERT INTO Users (username, password_hash, role) VALUES
('admin1', 'hashed_admin1', 'admin'),
('nurse_joseph', 'hashed_jose', 'staff'),
('dr_sande', 'hashed_sande', 'staff'),
('therapist_emma', 'hashed_emma', 'staff');

/*13. Insert Rooms*/
INSERT INTO Rooms (room_number, floor) VALUES
('101A', 1), ('102B', 1), ('201A', 2), ('202B', 2), ('301C', 3);

/*14. Insert Medical Staff*/
INSERT INTO Medical_Staff (full_name, email, phone, specialization_id, department_id, user_id) VALUES
('Joseph Thuranira', 'joseph@yahoo.com', '0754635788', 1, 5, 2),
('Dr. Sande Imbuga', 'danmarksande@gmail.com', '0797971425', 5, 1, 3),
('Emma Vero', 'emma.therapist@gmail.com', '0712534668', 4, 3, 4),
('Dr. Alice Kilo', 'alice.kilo@gmail.com', '0727896355', 2, 4, NULL),
('Nurse Peter Kim', 'peter.kim@outlook.com', '0740946260', 1, 5, NULL),
('Dr. Ruth Nandi', 'ruth.nandi@outlook.com', '0795131140', 6, 2, NULL);

/*15. Insert Patients*/
    INSERT INTO Patients (full_name, email, phone, date_of_birth, gender) VALUES
    ('John Mwangi', 'john.m@gmail.com', '0797000001', '1990-01-15', 'Male'),
    ('Mary Atieno', 'mary.a@gmail.com', '0758000002', '1985-07-21', 'Female'),
    ('Tom Ouma', 'tom.o@gmail.com', '0723000003', '1992-11-09', 'Male'),
    ('Agnes Wanjiku', 'agnes.w@gmail.com', '0725000004', '1978-05-03', 'Female'),
    ('Brian Kiptoo', 'brian.k@gmail.com', '0745000005', '2000-12-30', 'Male'),
    ('Grace Mutheu', 'grace.m@gmail.com', '0756000006', '1995-06-06', 'Female'),
    ('Steve Otieno', 'steve.o@gmail.com', '0709000007', '1988-03-17', 'Male'),
    ('Janet Cherono', 'janet.c@gmail.com', '0702000008', '1993-08-22', 'Female'),
    ('David Odhiambo', 'david.o@gmail.com', '0700078009', '1999-09-19', 'Male'),
    ('Linda Wambui', 'linda.w@gmail.com', '0728000010', '1982-04-11', 'Female');

/*16. Insert Appointments*/
INSERT INTO Appointments (patient_id, staff_id, appointment_date, reason, status, room_id) VALUES
(1, 2, '2025-05-10 09:00:00', 'Mental health consultation', 'Scheduled', 1),
(2, 1, '2025-05-10 10:30:00', 'Routine checkup', 'Scheduled', 2),
(3, 3, '2025-05-11 08:45:00', 'Therapy session', 'Scheduled', 3),
(4, 2, '2025-05-12 14:00:00', 'Follow-up', 'Completed', 1),
(5, 4, '2025-05-13 11:00:00', 'Physiotherapy consultation', 'Scheduled', 4),
(6, 5, '2025-05-14 15:30:00', 'Injection', 'Completed', 2),
(7, 6, '2025-05-15 13:15:00', 'X-ray imaging', 'Scheduled', 5),
(8, 2, '2025-05-16 09:45:00', 'Psychiatric assessment', 'Scheduled', 1),
(9, 1, '2025-05-17 10:00:00', 'Blood pressure check', 'Completed', 2),
(10, 3, '2025-05-18 11:45:00', 'Trauma therapy', 'Scheduled', 3);

/*17. Insert Prescriptions*/
INSERT INTO Prescriptions (appointment_id, medicine_name, dosage, instructions) VALUES
(1, 'Sertraline', '50mg once daily', 'Take after breakfast'),
(4, 'Paracetamol', '500mg every 6 hours', 'Take after meals'),
(6, 'Amoxicillin', '250mg three times daily', 'Finish full dose'),
(9, 'Atenolol', '50mg daily', 'Check blood pressure regularly'),
(10, 'Fluoxetine', '20mg daily', 'Take in the morning');
