set sql_safe_updates=0;
 # Q1)
use assignment;
select * from employee where deptno=10 and salary>3000;

# Q2a)
SELECT COUNT(*) FROM students where marks >= 50 and marks <80;

# Q2b)
select count(*) from students where marks >=80;

# Q3)
select * from station;
select distinct city from station where id %2 =0;

# Q4)
select (count(city)- count(distinct city)) from station;

# Q5a)
select distinct lower(city) from station where left(city,1) in('a','e','i','o','u');

# Q5b)
select distinct(city) from station where city like 'a%a' or city like'e%e'or city like'i%i'or city like'o%o'or city like'u%u';

# Q5C)
select distinct(city) from station where left(city,1) not in('a','e','i','o','u');

# Q5d)
select distinct(city) from station where city not like 'a%'
and city not like 'e%'
and city not like 'i%'
and city not like 'o%'
and city not like 'u%'
and city not like '%a'
and city not like '%e'
and city not like '%i'
and city not like '%o'
and city not like '%u';

# Q6
select first_name from emp where salary>2000 and datediff(curdate(),hire_date)< 36*30 order by salary desc;

# Q7)
select sum(salary) as total_salary, deptno from employee group by deptno;

# Q8)
select * from city;
select count(*)  from city where population>100000;

# Q9)
select sum(population) as population from city where district='california';

# Q10)
select avg(population) as average from city;

# Q11)
select * from orders;
select * from customers;
select o.ordernumber,o.status,o.customernumber,c.customername,o.comments from orders o 
join customers c on o.customernumber = c.customernumber 
where o.status = 'Disputed';
