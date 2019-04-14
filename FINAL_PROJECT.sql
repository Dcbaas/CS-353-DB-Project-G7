SPOOL project.out
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
--
--
--
--
SET FEEDBACK OFF
--
alter session set  NLS_DATE_FORMAT = 'MM-DD-YYYY';
--
insert into branch values(0, 'Old Kent Road', 10, 885414789, '06-22-1999');
insert into branch values(1, 'Boardwalk', 56, 996533256, '01-01-1975');
insert into branch values(2, 'Parks Place', 89, 332547852, '02-18-2019');
--
insert into employee values(996533256, 'Larry Kotman', 0, NULL, '01-01-1975');
insert into employee values(23456789, 'Sarah Pasco', 0, 996533256, '10-01-2000');
insert into employee values(123456789, 'Ian Hislop', 0, 23456789, '04-11-2019');
insert into employee values(987654321, 'Paul Merton', 0, 23456789, '04-11-2019');
insert into employee values(192837465, 'Danny Dire', 0, 23456789, '04-11-2019');
--
insert into employee values(885414789, 'Steve Tyler', 1, NULL, '06-22-199');
--
insert into employee values(332547852, 'Julia Hildebrand', 2, NULL, '02-18-2019');
insert into employee values(112233445, 'Lewis Hamilton', 2, 332547852, '07-08-2009');
insert into employee values(223344556, 'William Riker', 2, 332547852, '09-28-1987');
insert into employee values(445566778, 'Micheal Dorn' , 2, 332547852, '09-28-1987');
--
/* Invalid employee ssn */
insert into employee values(123abZH28, 'Grant Iverson', 0, '04-12-2018');
--
insert into car values(1962, 'Toyota Prius', 'economy', 86, 'black', 'RED69323', 2015, 1);
insert into car values(74656, 'BMW M3', 'premium', 212, 'yellow', 'DISCO5', 2019, 0);
insert into car values(2771, 'Rolls Royce Phantom', 'luxury', 555, 'gold', 'OPC 1546', 2016, 2);
insert into car values(8008, 'Oldsmobile Grantmobile','premium', 250, 'hot pink', 'NCC 1701',1995, 1);

-- Cars at Old Kent Road --
--Cars that fit the 4 table join --
insert into car values(0001, 'Ford F-150', 'premium', 155, 'red', 'OBG 4567', 2005, 0);
insert into car values(0002, 'Toyota Camery', 'economy', 66, 'orange', 'NASCAR', 2007, 0);
insert into car values(0003, 'Honda Accord', 'economy', 99, 'blue-grey', 'NX 74205', 2019, 0);
--car that won't be in the 4 table join--
insert into car values(0004, 'Douge Ram', 'economy', 103, 'pink', 'ABC 123', 2006, 0);
/*
This next one is an invalid data point
*/
insert into car values(4003, 'Yugo', 'garbage tier', 99, 'white', 'SOVIET1', 1975, 0);
--
insert into repair_shop values(123, 25, '606 Laker Lane, MI');
insert into repair_shop values(399, 32, '4017 Lubber Street, MI');
--
insert into service values(123, 1962, '03-27-2019', 250, 'Broken headlight'); 
insert into service values(123, 74656, '10-13-2018', 75, 'Oil change');
insert into service values(399, 2771, '06-07-2018', 200, 'New door handle');
insert into service values(399, 1962, '02-19-2019', 25, 'New air filter');
/*Next one is invalid data entry (car serial num does not exist)*/ 
insert into service values(399, 77777, '01-01-2019', 100, 'Invalid entry');
--
insert into repair_history values(74656, 2018, 75, 1);
insert into repair_history values(2771, 2018, 400, 2); 
insert into repair_history values(1962, 2019, 275, 2);
insert into repair_history values(1962, 2018, 350, 3);
insert into repair_history values(1962, 2017, 600, 1);
/* Next one is invalid data entry (serial and year have already been entered*/ 
insert into repair_history values(1962, 2017, 100, 1);
--
insert into languages values(885414789, 'English');
insert into languages values(332547852, 'English');
insert into languages values(885414789, 'French');
insert into languages values(332547852, 'Spanish');
insert into languages values(885414789, 'Arabic');
--

-- 
insert into customer values(10,'OurCredit','3257 Southfeild',42,'Boby Brown',123456789);
insert into customer values(11,'Sky','64839 Johnsonville',58,'John Johnson',123456789);
insert into customer values(12,'OurCredit','3257 Southfeild',70,'Avery Brooks',123456789);
insert into customer values(13,'Memic', '2345 Bajor Lane', 68, 'Nana Visitor', 123456789);
insert into customer values(14,'Fedacare','Deep Space 9', 56, 'Julian Bashir', 123456789);
--
insert into customer values(15, 'Fedacare','Deep Space 9', 45, 'Nicole de Boer', 987654321);
insert into customer values(16, 'Ferenicare', 'Deep Space 9', 67, 'Quark', 987654321);
insert into customer values(17, 'Risaian Services', '7654 Risa Road',74, 'Miles O Brian', 987654321);
insert into customer values(18, 'Allstate', '7449 Whistleville',30, 'Mr. Chicken', 987654321);
--
--4 TABLE JOIN RENTALs--
insert into rental values(0001, 224, '06-02-2012', '06-04-2012', 300, 10, 0, 0001);
insert into rental values(0002, 1200, '11-8-2016', '01-01-2017', 2800, 11, 0, 0003);
insert into rental values(0003, 900, '02-25-2019', '02-27-2019', 310, 10, 2, 2771);
--
SET FEEDBACK ON
COMMIT;
--
SELECT *
FROM car;
--
SELECT * 
FROM branch;
--
SELECT * 
FROM employee;
--
SELECT * 
FROM customer;
--
SELECT *
FROM rental;
--
SELECT *
FROM repair_shop;
--
SELECT *
FROM repair_history;
--
SELECT * 
FROM languages;
--
SELECT *
FROM service;
--
--
--
--
--
/*
4 table join
For all rentals that have customers whos age is over 35 and rented a car from the Old Kent Road branch that was made after 2005. find the orderID, the customer ssn, carMake, and licensePlateNumber.
*/
SELECT R.orderID, C.licenseID, car.carModel, car.licensePlateNum
FROM rental R, customer C, car, branch B
WHERE C.age > 35 AND
    B.bAddress = 'Old Kent Road' AND
    car.year >= 2005 AND
    R.renterLicenseID = C.licenseID AND
    R.bID = B.bID AND
    R.carSerialNum = car.serialNum
ORDER BY R.startDate;

--
/*
Self Join
Find the ssn, and names, and start dates of all the employees that work at branch 2 who started before thier supervisior started work.
*/
SELECT E1.eSSN, E1.name, E1.startDate
FROM employee E1, employee E2
WHERE E1.supervisorSSN = E2.eSSN AND
    E1.startDate < E2.startDate AND 
    E1.bID = 2
ORDER BY E1.eSSN;
/*
*/
--
/*
Union/Intersect/Minus (Pick one or more for a query) 
Find the license Plate Number, car model, and car year for every luxury car that has been in for service within the past 4 years (Since 2019)
*/
SELECT C.licensePlateNum, C.carModel, C.year
FROM car C
WHERE C.carType = 'luxury'
UNION 
SELECT C.licensePlateNum, C.carModel, C.year
FROM car C, service S
WHERE C.serialNum = S.carSerialNum AND
    S.sDate > '01-01-2015';
--
/*
Sum/Avg/Max/Min (Pick one or more for a query)
FOr every car that has been rented out, find the total revenue generated by each indiviaul. List Licsence plate number, model, and year.
*/
SELECT C.licensePlateNum, C.carModel, C.year, SUM(R.cost)
FROM car C, rental R
WHERE C.serialNum = R.carSerialNum
GROUP BY C.licensePlateNum, C.carModel, C.year;
--
/*
GROUP BY, HAVING, ORDER BY all in the sqme query.
Find the ssn, and name of all employees who have consulted with more than 3 customers and list how many they have consulted with. 
*/
SELECT E.eSSN, E.name, COUNT(*)
FROM customer C, employee E
WHERE E.eSSN = C.consultantSSN
GROUP BY E.eSSN, E.name
HAVING COUNT(*) > 3
ORDER BY COUNT(*);
--
/*
Correlated subquery
Find the serial number, rate, model, year, and type of all cars whose rate is higher than the average rate of their type tier. 
*/
SELECT C.serialNum, C.carRate, C.carModel, C.year, C.carType, C.licensePlateNum
FROM Car C
WHERE C.carRate >
    (SELECT AVG(C2.CarRate)
    FROM car C2
    WHERE C.carType = C2.carType)
ORDER BY C.serialNum;
--
/*
non correlated subquery
Find the serial number, rate, model, year, type, and licece plate number of every car that has a rate greater than $150 but has yet to be rented out.
*/
SELECT C.serialNum, C.CarRate, C.carModel, C.year, C.carType, C.licensePlateNum
FROM car C
WHERE C.carRate > 150 AND
    C.serialNum NOT IN 
    (SELECT R.carSerialNum
        FROM Rental R);

--
/*
A relational Division query
*/
SELECT C.licenseID, C.name
FROM customer C
WHERE NOT EXISTS ((SELECT Cr.serialNum
                FROM car Cr
                WHERE Cr.carType = 'luxury')
                MINUS
                (SELECT Cr.serialNum
                FROM rental R, Car Cr
                WHERE R.carSerialNum = Cr.serialNum AND
                    R.renterLicenseID = C.licenseID AND
                    Cr.carType = 'luxury'));
--
/*
An outer join query 
List all employees and list thier ....
*/
SELECT E.eSSN, E.name, C.name
FROM employee E LEFT OUTER JOIN 
                    customer C ON E.eSSN = C.consultantSSN;
--
SPOOL OFF
