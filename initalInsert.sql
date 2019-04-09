SET ECHO ON
alter session set  NLS_DATE_FORMAT = 'MM-DD-YYYY';
--
insert into branch values(0, 'Old Kent Road', 10, 885414789, '06-22-1999');
insert into branch values(1, 'Boardwalk', 56, 996533256, '01-01-1975');
insert into branch values(2, 'Parks Place', 89, 332547852, '02-18-2019');
--
insert into employee values(885414789, 'Steve Tyler', 1, '06-22-199');
insert into employee values(996533256, 'Larry Kotman', 0, '01-01-1975');
insert into employee values(332547852, 'Julia Hildebrand', 2, '02-18-2019');
--
/* Invalid employee ssn */
insert into employee values(123abZH28, 'Grant Iverson', 0, '04-12-2018');
--
insert into car values(1962, 'Toyota Prius', 'economy', 86, 'black', 'RED69323', 2015, 1);
insert into car values(74656, 'BMW M3', 'premium', 212, 'yellow', 'DISCO5', 2019, 0);
insert into car values(2771, 'Rolls Royce Phantom', 'luxury', 555, 'gold', 'OPC 1546', 2016, 2);
--insert into car values(8008, 'Oldsmobile Grantmobile',250, 'hot pink', 'NCC 1701', 1);
/*
This next one is an invalid data point
*/
insert into car values(4003, 'Yugo', 'garbage tier', 99, 'white', 'SOVIET1', 1975, 0);
--

COMMIT;
SET ECHO OFF
