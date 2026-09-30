-- CIS 344 Individual Project
-- Pet Training School Database

DROP DATABASE IF EXISTS pet_training_school;

CREATE DATABASE pet_training_school;

USE pet_training_school;

-- Creating Owner Table
CREATE TABLE owner (
    owner_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (owner_id),
    UNIQUE KEY email_UNIQUE (email)
);

-- Creating Pet Table
CREATE TABLE pet (
    pet_id INT NOT NULL AUTO_INCREMENT,
    pet_name VARCHAR(45) NOT NULL,
    species VARCHAR(45) NOT NULL,
    breed VARCHAR(45) DEFAULT NULL,
    date_of_birth DATE DEFAULT NULL,
    owner_id INT NOT NULL,
    PRIMARY KEY (pet_id),
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id)
);

-- Creating Trainer Table
CREATE TABLE trainer (
    trainer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    email VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (trainer_id),
    UNIQUE KEY email_UNIQUE (email)
);

-- Creating Training Class Table
CREATE TABLE training_class (
    class_id INT NOT NULL AUTO_INCREMENT,
    class_name VARCHAR(100) NOT NULL,
    training_level VARCHAR(45) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    trainer_id INT NOT NULL,
    PRIMARY KEY (class_id),
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
);

-- Creating Enrollment Table
CREATE TABLE enrollment (
    enrollment_id INT NOT NULL AUTO_INCREMENT,
    enrollment_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    pet_id INT NOT NULL,
    class_id INT NOT NULL,
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY (pet_id) REFERENCES pet(pet_id),
    FOREIGN KEY (class_id) REFERENCES training_class(class_id)
);

-- Creating Payment Table
CREATE TABLE payment (
    payment_id INT NOT NULL AUTO_INCREMENT,
    payment_date DATE NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    payment_method VARCHAR(45) NOT NULL,
    enrollment_id INT NOT NULL,
    PRIMARY KEY (payment_id),
    UNIQUE KEY enrollment_id_UNIQUE (enrollment_id),
    FOREIGN KEY (enrollment_id) REFERENCES enrollment(enrollment_id)
);

-- Inserting Owner Data
INSERT INTO owner (first_name, last_name, phone, email)
VALUES
('John', 'Moretta', '914-555-1001', 'john.moretta@email.com'),
('Maria', 'Garcia', '347-555-1002', 'maria.garcia@email.com'),
('David', 'Aaronson', '516-555-1003', 'david.aaronson@email.com'),
('Sarah', 'Parker', '631-555-1004', 'sarah.parker@email.com'),
('Mike', 'Brown', '845-555-1005', 'mike.brown@email.com');

-- Inserting Pet Data
INSERT INTO pet (pet_name, species, breed, date_of_birth, owner_id)
VALUES
('Bolt', 'Dog', 'Golden Retriever', '2020-05-15', 1),
('Cookie', 'Dog', 'Beagle', '2021-08-22', 2),
('Charlie', 'Cat', 'Siamese', '2019-03-10', 3),
('Sunshine', 'Rabbit', 'Mini Rex', '2025-01-18', 4),
('Rocky', 'Dog', 'Boxer', '2020-11-05', 5);

-- Inserting Trainer Data
INSERT INTO trainer (first_name, last_name, phone, email, specialty)
VALUES
('James', 'Wilson', '914-555-2001', 'james.wilson@email.com', 'Dog Training'),
('Arlene', 'Martinez', '347-555-2002', 'arlene.martinez@email.com', 'Dog Behavior Training'),
('Carlos', 'Rivera', '516-555-2003', 'carlos.rivera@email.com', 'Cat Training'),
('Emily', 'Thompson', '631-555-2004', 'emily.thompson@email.com', 'Small Animal Training'),
('Daniel', 'Lee', '845-555-2005', 'daniel.lee@email.com', 'Dog Obedience Training');

-- Inserting Training Class Data
INSERT INTO training_class
(class_name, training_level, start_date, end_date, price, trainer_id)
VALUES
('Basic Dog Training', 'Beginner', '2026-10-05', '2026-11-02', 150.00, 1),
('Dog Behavior Basics', 'Intermediate', '2026-10-07', '2026-11-04', 175.00, 2),
('Cat Training Basics', 'Beginner', '2026-10-10', '2026-11-07', 125.00, 3),
('Small Animal Basics', 'Beginner', '2026-10-12', '2026-11-09', 100.00, 4),
('Dog Obedience', 'Intermediate', '2026-10-15', '2026-11-12', 180.00, 5);

-- Inserting Enrollment Data
INSERT INTO enrollment (enrollment_date, status, pet_id, class_id)
VALUES
('2026-09-29', 'Active', 1, 1),
('2026-09-29', 'Active', 2, 2),
('2026-09-29', 'Active', 3, 3),
('2026-09-29', 'Active', 4, 4),
('2026-09-29', 'Active', 5, 5);

-- Inserting Payment Data
INSERT INTO payment (payment_date, amount, payment_method, enrollment_id)
VALUES
('2026-09-29', 150.00, 'Credit Card', 1),
('2026-09-29', 175.00, 'Debit Card', 2),
('2026-09-29', 125.00, 'Credit Card', 3),
('2026-09-29', 100.00, 'Cash', 4),
('2026-09-29', 180.00, 'Debit Card', 5);

-- Viewing All Data
SELECT * FROM owner;
SELECT * FROM pet;
SELECT * FROM trainer;
SELECT * FROM training_class;
SELECT * FROM enrollment;
SELECT * FROM payment;

-- Pet Training Information
SELECT 
    owner.first_name,
    owner.last_name,
    pet.pet_name,
    training_class.class_name,
    trainer.first_name AS trainer_first_name,
    trainer.last_name AS trainer_last_name,
    payment.amount
FROM owner
JOIN pet ON owner.owner_id = pet.owner_id
JOIN enrollment ON pet.pet_id = enrollment.pet_id
JOIN training_class ON enrollment.class_id = training_class.class_id
JOIN trainer ON training_class.trainer_id = trainer.trainer_id
JOIN payment ON enrollment.enrollment_id = payment.enrollment_id;