CREATE TABLE car(
    serialNum INTEGER PRIMARY KEY,
    carModel  CHAR(20),
    carType   CHAR(20),
    carRate   INTEGER,
    color     CHAR(15),
    licecePlateNum CHAR(8),
    year      INTEGER, 
    bID       INTEGER
    -- Make constraints later

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
    startDate DATE,
);
--
CREATE TABLE customer(
    licenseID   INTEGER PRIMARY KEY,
    insurance   CHAR(20),
    billingAddr CHAR(30),
    age         INTEGER,
    name        CHAR(20),
    consultantSSN INTEGER
);
--
CREATE TABLE rental(
    orderID INTEGER,
    cost    CHAR(15),
    startDate DATE,
    returnDate DATE,
    milesUsed INTEGER, 
    renterLicenseID INTEGER,
    bID      INTEGER,
    carSerialNum INTEGER
);
--
CREATE TABLE repair_shop(
    RsID INTEGER,
    garageSpaces INTEGER, 
    rAddress CHAR(15)
);
--
CREATE TABLE repair_history(
    carSerialNum INTEGER,
    year        INTEGER,
    cost        INTEGER,
    numServices INTEGER
);
--
CREATE TABLE languages(
    eSSN INTEGER,
    language CHAR(15)
);
--
CREATE TABLE service(
    rSid    INTEGER,
    carSerialNum INTEGER, 
    sDate   DATE,
    cost    INTEGER,
    reason  CHAR(40)
);
