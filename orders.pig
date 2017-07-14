orders = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/orders.json' using JsonLoader('
order_id: chararray,
username: chararray,
product: chararray,
quantity: int,
amount: double,
order_date: chararray,
zipcode: chararray
');
dump orders;

order_totals = foreach orders generate username, product, quantity * amount as total; -- can perform math and rename fieldname
dump order_totals;

order_totals = foreach orders generate username, product, ROUND(quantity * amount) as total; -- ROUND results in an int 
describe order_totals;
dump order_totals;

order_numbers = foreach orders generate SUBSTRING(order_id, 1, 2) as order_num; -- SUBSTRING(string you want to grab the substring from, start index, stop index is 1 beyond the last index like Python slice
dump order_numbers;

update_order_ids = foreach orders generate REPLACE(order_id, 'o', 'order'), product;
dump update_order_ids;

order_date = foreach orders generate username, product, quantity, ToDate(order_date, 'MM-dd-yyyy') as date;
describe order_date;

order_month = foreach order_date generate GetMonth(date);
dump order_month;
