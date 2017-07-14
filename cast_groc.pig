groc_no_colname = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/groceries.csv' using PigStorage(',');
describe groc_no_colname; -- no schema at this time
dump groc_no_colname;

products = foreach groc_no_colname generate $1, $2, $4 * 1.0; -- multiplying index 4 by 1.0 lets pig know that the data type must be numeric
describe products;

groc_no_type = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/groceries.csv' using PigStorage(',')
as
(
order_id,
location,
product,
day,
revenue
);
describe groc_no_type; -- each field name is assigned bytearray by default

products = foreach groc_no_type generate location, product, revenue * 1.0; -- can use field name directly and not use index number
describe products; -- Pig will infer revenue is numeric
