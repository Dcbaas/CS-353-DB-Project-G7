SET ECHO ON
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
SET ECHO OFF
