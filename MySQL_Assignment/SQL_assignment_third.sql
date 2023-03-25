set sql_safe_updates=0;
use assignment;

# Q1)
Delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_status`(in in_month int,in in_year int)
BEGIN
select ordernumber,orderdate,status from orders
where in_month= month(shippeddate) and in_year= year(shippeddate);

END //
call order_status(5,2005);


# Q2)
CREATE TABLE cancellations(
id INT PRIMARY KEY AUTO_INCREMENT, 
customernumber INT, 
ordernumber INT,
comments VARCHAR(250)
);

Delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancel_order`()
BEGIN
insert into cancellations(customernumber,ordernumber,comments)
select customernumber,ordernumber,comments from orders where status='cancelled';


END//
call cancel_order();


# Q3a)
Delimiter//
CREATE DEFINER=`root`@`localhost` FUNCTION `purchase_status`(in_customernumber int)
RETURNS varchar(10)
READS SQL DATA
DETERMINISTIC
BEGIN
declare stat varchar(20);
declare total FLOAT DEFAULT 0;
SET total = (SELECT SUM(amount) FROM payments WHERE in_customerNumber = customerNumber);
IF total<25000 THEN SET Stat = 'Silver' ;
ELSEIF total > 25000 AND amount <50000  THEN SET Stat = 'Gold' ;
ELSEIF total < 50000  THEN SET Stat ='Platinum';
END IF;
RETURN stat;
END//

# Q3b)
DELIMITER // 
CREATE PROCEDURE cust_detail()
BEGIN  
Select cutomerNumber, customerName, if (creditLimit>50000,'Platinum',IF( 50000>creditLimit>25000,'Gold','Silver')) FROM customers;
END//


# Q4)
DELIMITER $$
CREATE TRIGGER trg_movies_update
AFTER DELETE ON movies
FOR EACH ROW
BEGIN
    UPDATE rentals
    SET movieid = id
    WHERE movieid = OLD.id ;
END;

DELIMITER $$
CREATE TRIGGER trg_movies_delete 
AFTER DELETE ON movies 
FOR EACH ROW 
BEGIN
    DELETE FROM  rentals
    WHERE movieid 
    NOT IN (SELECT DISTINCT id FROM movies);
END $$

# Q5)
select fname from employee order by salary desc limit 2,1;

# Q6)
SELECT *, 
RANK () OVER (
ORDER BY salary DESC
) AS Rank_no 
FROM employee;