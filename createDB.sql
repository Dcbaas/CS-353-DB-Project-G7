SET ECHO ON
--
DROP TABLE branch CASCADE CONSTRAINTS;
DROP TABLE car CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
/*
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE rental CASCADE CONSTRAINTS;
DROP TABLE repair_shop CASCADE CONSTRAINTS;
DROP TABLE repair_history CASCADE CONSTRAINTS;
DROP TABLE langauges CASCADE CONSTRAINTS;
DROP TABLE service CASCADE CONSTRAINTS;
*/
--
CREATE TABLE car(
    serialNum INTEGER PRIMARY KEY,
    carModel  CHAR(20),
    carType   CHAR(20),
    carRate   INTEGER,
    color     CHAR(15),
    licecePlateNum CHAR(8),
    year      INTEGER, 
    bID       INTEGER,
    --
    CONSTRAINT cIC2 CHECK(carType = 'economy' OR carType = 'premium' OR carType = 'luxlux'),
    --
    CONSTRAINT cIC3 CHECK (NOT(carType = 'economy' AND carRate < 50 OR carRate >= 150)),
    --
    CONSTRAINT cIC4 CHECK (NOT(carType = 'premium' AND carRate < 150 OR carRate >= 450)),
    --
    CONSTRAINT cIC5 CHECK (NOT(carType = 'luxlux' AND carRate < 450))
);
--
CREATE TABLE branch(
    bID INTEGER PRIMARY KEY,
    bAddress CHAR(20),
    lotSize INTEGER,
    managerSSN INTEGER,
    managerStartDate DATE
);
--
CREATE TABLE employee(
    eSSN      INTEGER PRIMARY KEY,
    name      CHAR(20),
    bID       INTEGER,
    startDate DATE
);
/*
--
CREATE TABLE customer(
    licenseID   INTEGER PRIMARY KEY,
    insurance   CHAR(20),
    billingAddr CHAR(30),
    age         INTEGER,
    name        CHAR(20),
    consultantSSN INTEGER,
    --
    CONSTRAINT cIC1 FOREIGN KEY (consultantSSN)
                    REFERENCES employee(eSSN),
    --
    CONSTRAINT cIC2 CHECK(age > 25)
);
--
CREATE TABLE rental(
    orderID INTEGER PRIMARY KEY,
    cost    CHAR(15),
    startDate DATE,
    returnDate DATE,
    milesUsed INTEGER, 
    renterLicenseID INTEGER,
    bID      INTEGER,
    carSerialNum INTEGER,
    --
    CONSTRAINT rIC1 FOREIGN KEY (bID)
                    REFERENCES branch(bID),
    --
    CONSTRAINT rIC2 FOREIGN KEY (carSerialNum)
                    REFERENCES car(serialNum),
    --
    CONSTRAINT rIC3 CHECK(startDate < returnDate)
);
--
CREATE TABLE repair_shop(
    rSid INTEGER PRIMARY KEY,
    garageSpaces INTEGER, 
    rAddress CHAR(15),
    --
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
    eSSN INTEGER PRIMARY KEY,
    language CHAR(15) PRIMARY KEY,
    --
    CONSTRAINT FOREIGN KEY (eSSN)
               REFERENCES employee(eSSN)
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
    CONSTRAINT sIC1 FOREIGN KEY (rSid)
                    REFERENCES repair_shop(rSid)
                    ON DELETE CASCADE,
    --
    CONSTRAINT sIC2 FOREIGN KEY (carSerialNum)
                    REFERENCES car(serialNum)
                    ON DELETE CASCADE
);
*/

/*
Forgien Keys
*/
ALTER TABLE car ADD CONSTRAINT FK_1
                    FOREIGN KEY (bID) REFERENCES branch(bID);
--
ALTER TABLE branch ADD CONSTRAINT FK_2
                    FOREIGN KEY (managerSSN) REFERENCES employee(eSSN);
--
ALTER TABLE employee ADD CONSTRAINT FK_3
                    FOREIGN KEY (bID) REFERENCES branch(bID);
--
SET ECHO OFF
