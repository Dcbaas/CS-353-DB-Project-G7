SPOOL createDB.out
SET ECHO ON
--
DROP TABLE branch CASCADE CONSTRAINTS;
DROP TABLE car CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE rental CASCADE CONSTRAINTS;
DROP TABLE repair_shop CASCADE CONSTRAINTS;
DROP TABLE repair_history CASCADE CONSTRAINTS;
DROP TABLE languages CASCADE CONSTRAINTS;
DROP TABLE service CASCADE CONSTRAINTS;
--
CREATE TABLE car(
    serialNum INTEGER PRIMARY KEY,
    carModel  CHAR(40) NOT NULL,
    carType   CHAR(20) NOT NULL,
    carRate   INTEGER  NOT NULL,
    color     CHAR(15) NOT NULL,
    licensePlateNum CHAR(8) NOT NULL,
    year      INTEGER, 
    bID       INTEGER,
    --
    CONSTRAINT carIC1 CHECK(carType = 'economy' OR carType = 'premium' OR carType = 'luxury'),
    --
    CONSTRAINT carIC2 CHECK (NOT(carType = 'economy' AND (carRate < 50 OR carRate >= 150))),
    --
    CONSTRAINT carIC3 CHECK (NOT(carType = 'premium' AND (carRate < 150 OR carRate >= 450))),
    --
    CONSTRAINT carIC4 CHECK (NOT(carType = 'luxury' AND carRate < 450))
);
--
CREATE TABLE branch(
    bID INTEGER PRIMARY KEY,
    bAddress CHAR(20) NOT NULL,
    lotSize INTEGER,
    managerSSN INTEGER,
    managerStartDate DATE
);
--
CREATE TABLE employee(
    eSSN      INTEGER PRIMARY KEY,
    name      CHAR(20) NOT NULL,
    bID       INTEGER,
    supervisorSSN INTEGER NULL,
    startDate DATE
);
--
CREATE TABLE customer(
    licenseID   INTEGER PRIMARY KEY,
    insurance   CHAR(20),
    billingAddr CHAR(30),
    age         INTEGER,
    name        CHAR(20) NOT NULL,
    consultantSSN INTEGER,
    --
    CONSTRAINT customerIC1 CHECK(age > 25)
);
--
CREATE TABLE rental(
    orderID INTEGER PRIMARY KEY,
    cost    INTEGER NOT NULL,
    startDate DATE,
    returnDate DATE,
    milesUsed INTEGER, 
    renterLicenseID INTEGER,
    bID      INTEGER,
    carSerialNum INTEGER,
    --
    CONSTRAINT rentIC1 CHECK(startDate < returnDate)
);
--
CREATE TABLE repair_shop(
    rSid INTEGER PRIMARY KEY,
    garageSpaces INTEGER, 
    rAddress CHAR(30) NOT NULL
);
--
CREATE TABLE repair_history(
    carSerialNum INTEGER,
    year        INTEGER,
    cost        INTEGER,
    numServices INTEGER,
    --
    PRIMARY KEY (carSerialNum, year),
    CONSTRAINT rhIC1 FOREIGN KEY (carSerialNum)
                     REFERENCES car(serialNum)
                    ON DELETE CASCADE
);
--
CREATE TABLE languages(
    eSSN INTEGER,
    language CHAR(15),
    --
    PRIMARY KEY (eSSN, language)
);

--
CREATE TABLE service(
    rSid    INTEGER,
    carSerialNum INTEGER,
    sDate   DATE,
    cost    INTEGER,
    reason  CHAR(40),
    --
    PRIMARY KEY (rSid, carSerialNum),
    CONSTRAINT serviceIC1 FOREIGN KEY (rSid)
                    REFERENCES repair_shop(rSid)
                    ON DELETE CASCADE,
    --
    CONSTRAINT serviceIC2 FOREIGN KEY (carSerialNum)
                    REFERENCES car(serialNum)
                    ON DELETE CASCADE
);
--
/*
Forgien Keys that can't be made in thier inital creation.
*/
ALTER TABLE car ADD CONSTRAINT FK_1 
                    FOREIGN KEY (bID) REFERENCES branch(bID)
                    ON DELETE SET NULL
                    DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE branch ADD CONSTRAINT FK_2
                    FOREIGN KEY (managerSSN) REFERENCES employee(eSSN)
                    ON DELETE SET NULL
                    DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE employee ADD CONSTRAINT FK_3
                    FOREIGN KEY (bID) REFERENCES branch(bID)
                    ON DELETE SET NULL
                    DEFERRABLE INITIALLY DEFERRED;
--
ALTER TABLE customer ADD CONSTRAINT FK_4
                    FOREIGN KEY (consultantSSN) REFERENCES employee(eSSN)
                    ON DELETE CASCADE;
--
ALTER TABLE rental ADD CONSTRAINT FK_5
                    FOREIGN KEY (bID) REFERENCES branch(bID);
--
ALTER TABLE rental ADD CONSTRAINT FK_6 
                    FOREIGN KEY (carSerialNum) REFERENCES car(serialNum);
--
ALTER TABLE rental ADD CONSTRAINT FK_7
                    FOREIGN KEY (renterLicenseID) REFERENCES customer(licenseID);
--
ALTER TABLE languages ADD CONSTRAINT FK_8
                    FOREIGN KEY (eSSN) REFERENCES employee(eSSN)
                    ON DELETE CASCADE;
--
ALTER TABLE employee ADD CONSTRAINT FK_9
                    FOREIGN KEY (supervisorSSN) REFERENCES employee(eSSN)
                    ON DELETE SET NULL
                    DEFERRABLE INITIALLY DEFERRED;
SET ECHO OFF
SPOOL OFF

