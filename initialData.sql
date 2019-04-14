SPOOL initialData.out
SET ECHO ON
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
--customer tables that should work -- -- 
/*
insert into customer values(1,'NationWide',24581 Chesterfeild,25,Richard Nixon,382462847);
insert into customer values(1,'HoneyBeeHam','24581 Chesterfeild',25,'Richard Nixon',382462847);
--2 primary -- 
insert into customer values(2,'NationWide','24581 Chesterfeild',20,'Richard Nixon',382462847);
--under 25 -- 
insert into customer values(3,'NationWide','24581 Chesterfeild',25,'Richard Nixon',382462847);
-- 25 exactly -- 
insert into customer values('number','NationWide','24581 Chesterfeild','number','Richard Nixon','number');
--replaced integers with chars. -- 
insert into customer values(4,'NationWide','24581 Chesterfeild',25,'Richard Nixon',382462847);
-- 
insert into customer values(5,'LONGERTHAN20IIIIIIIII','24581 Chesterfeild',25,'Richard Nixon',382462847);
insert into customer values(6,'NationWide','LONGERTHAN30IIIIIIIIIIIIIIIIII',25,'Richard Nixon',382462847);
insert into customer values(7,'NationWide','24581 Chesterfeild',25,'LONGERTHAN20IIIIIIIII',382462847);
--big chars -- 
insert into customer values(0,0,0,0,0,0);
-- putting for everything -- 
insert into customer values(,,,,,);
--nothing in here -- 
-- 
insert into customer values( , , , , , );
*/
--only spaces in here
COMMIT;
-- BASIC QUERIES --
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
SET ECHO OFF
SPOOL OFF
