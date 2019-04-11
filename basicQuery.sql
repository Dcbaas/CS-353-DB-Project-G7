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
Find the ssn, and names, and start dates of all the employees that work at branch 2 and started work before January 1, 2019
*/
/*
SELECT E1.eSSN, E1.name, E1.startDate
FROM employee E1, employee E2
WHERE 
*/
--
/*
Union/Intersect/Minus (Pick one or more for a query) 
*/
--
/*
Sum/Avg/Max/Min (Pick one or more for a queryA)
*/
--
/*
GROUP BY, HAVING, ORDER BY all in the sqme query.
*/
--
/*
Correlated subquery
*/
--
/*
non correlated subquery
*/
--
/*
A relational Division query
*/
--
/*
An outer join query 
*/
--
/*
A RANK query 
*/
--
/*
A Top-N query
*/
SET ECHO OFF
