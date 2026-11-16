-- =======================================================
-- Wonders of Wildlife - Oracle Database Schema
-- Database: Oracle Database 10g/11g/19c/21c Express Edition (XE)
-- User/Schema: wildlife / wildlife
-- =======================================================

-- Drop existing tables
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE contact_messages CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE animals CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE sanctuaries CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE admin_users CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Drop existing sequences
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_sanctuaries';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_animals';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_admin_users';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE seq_contact_messages';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- 1. Create Sequences for auto-generating IDs
CREATE SEQUENCE seq_sanctuaries START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_animals START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_admin_users START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE seq_contact_messages START WITH 1 INCREMENT BY 1 NOCACHE;

-- 2. Admin Users Table (For Admin Panel Authentication)
CREATE TABLE admin_users (
    id NUMBER PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password VARCHAR2(100) NOT NULL,
    full_name VARCHAR2(100)
);

-- 3. Wildlife Sanctuaries & National Parks Table
CREATE TABLE sanctuaries (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(150) NOT NULL,
    state VARCHAR2(100) NOT NULL,
    description VARCHAR2(2000) NOT NULL,
    key_animals VARCHAR2(500),
    best_time VARCHAR2(100),
    image_url VARCHAR2(255) NOT NULL
);

-- 4. Animals & Birds Species Table
CREATE TABLE animals (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(150) NOT NULL,
    category VARCHAR2(50) NOT NULL, -- 'Animal' or 'Bird'
    scientific_name VARCHAR2(150),
    habitat VARCHAR2(255),
    found_in VARCHAR2(500),
    description VARCHAR2(2000) NOT NULL,
    image_url VARCHAR2(255) NOT NULL
);

-- 5. Contact / Inquiry Messages Table
CREATE TABLE contact_messages (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    subject VARCHAR2(150) NOT NULL,
    message VARCHAR2(2000) NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Insert Default Administrators
INSERT INTO admin_users VALUES (seq_admin_users.NEXTVAL, 'admin', 'admin123', 'Wildlife Administrator');
INSERT INTO admin_users VALUES (seq_admin_users.NEXTVAL, 'wildlife123', 'tiger123', 'Wildlife Staff');

COMMIT;
