alter session set  NLS_DATE_FORMAT = 'MM-DD-YYYY'

insert into branch values(0, 'Old Kent Road', 10, 885414789, '06-22-1999');
insert into branch values(1, 'Boardwalk', 56, 996533256, '01-01-1975');
insert into branch values(2, 'Parks Place', 89, 332547852, '02-18-2019');
--
insert into car values(1962, 'Toyota Prius', 'economy', 86, 'black', 'RED69323', 2015, 1);
insert into car values(74656, 'BMW M3', 'premium', 212, 'yellow', 'DISCO5', 2019, 0);
/*
This next one is an invalid data point
*/
insert into car values(4003, 'Yugo', 'garbage tier', 99, 'white', 'SOVIET1', 1975, 0);
insert into car values(2771, 'Rolls Royce Phantom', 555, 'gold', 'OPC 1546', 2016, 2);
insert into car values(8008, 'Oldsmobile Grantmobile',250, 'hot pink', 'NCC 1701', 1);
--
insert into repair_shop(123, 25, '606 Laker Lane, MI');
insert into repair_shop(399, 32, '4017 Lubber Street, MI');
insert into service values(123, 1962, '03-27-2019', 250, 'Broken headlight'); 
insert into service values(123, 74656, '10-13-2018', 75, 'Oil change');
insert into service values(399, 2771, '06-07-2018', 200, 'New door handle');
insert into service values(399, 1962, '02-19-2019', 25, 'New air filter');
/*Next one is invalid data entry (car serial num does not exist)*/ 
insert into service values(399, 77777, '01-01-2019', 100, 'Invalid entry');
--
insert into repair_history value(74656, 2018, 75, 1);
insert into repair_history value(2771, 2018, 400, 2); 
insert into repair_history value(1962, 2019, 275, 2);
insert into repair_history value(1962, 2018, 350, 3);
insert into repair_history value(1962, 2017, 600, 1);
/* Next one is invalid data entry (serial and year have already been entered*/ 
insert into repair_history value(1962, 2017, 100, 1);
--
insert into languages value(885414789, 'English');
insert into languages value(332547852, 'English');
insert into languages value(885414789, 'French');
insert into languages value(332547852, 'Spanish');
insert into languages value(885414789, 'Arabic');

