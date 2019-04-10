SET ECHO ON
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
/*
4 table join
For all rentals that have customers whos name starts with l and came from the Old Kent road branch using a car that was made after 2005.
*/
--
/*
Self Join
Find the ssn, and names, and start dates of all the employees that work at branch 2 and started work before January 1, 2019
*/
SELECT E1.eSSN, E1.name, E1.startDate
FROM employee E1, employee E2
WHERE 
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
A relational Division query (may be combined with the minus?)
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
