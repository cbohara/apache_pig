customers = LOAD '/Users/charlieohara/github/cbohara/apache_pig/data/customers.txt' USING PigStorage(',') AS (id:int, name:chararray, age:int, address:chararray, salary:int);
dump customers;
/*
(1,Ramesh,32,Ahmedabad,2000)
(2,Khilan,25,Delhi,1500)
(3,kaushik,23,Kota,2000)
(4,Chaitali,25,Mumbai,6500)
(5,Hardik,27,Bhopal,8500)
(6,Komal,22,MP,4500)
(7,Muffy,24,Indore,10000)
*/

orders = LOAD '/Users/charlieohara/github/cbohara/apache_pig/data/orders.txt' USING PigStorage(',') AS (oid:int, date:chararray, customer_id:int, amount:int);
dump orders;
/*
(102,2009-10-08 00:00:00,3,3000)
(100,2009-10-08 00:00:00,3,1500)
(101,2009-11-20 00:00:00,2,1560)
(103,2008-05-20 00:00:00,4,2060)
*/

-- left outer join returns all rows from the left table even if there are no matches in the right relation
outer_left_join = JOIN customers BY id LEFT OUTER, orders BY customer_id;
dump outer_left_join;
/*
(1,Ramesh,32,Ahmedabad,2000,,,,)
(2,Khilan,25,Delhi,1500,101,2009-11-20 00:00:00,2,1560)
(3,kaushik,23,Kota,2000,100,2009-10-08 00:00:00,3,1500)
(3,kaushik,23,Kota,2000,102,2009-10-08 00:00:00,3,3000)
(4,Chaitali,25,Mumbai,6500,103,2008-05-20 00:00:00,4,2060)
(5,Hardik,27,Bhopal,8500,,,,)
(6,Komal,22,MP,4500,,,,)
(7,Muffy,24,Indore,10000,,,,)
*/
