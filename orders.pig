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

order_date = foreach orders generate username, product, quantity, ToDate(order_date, 'MM-dd-yyyy') as date; -- convert chararray to datetime data type
describe order_date;

order_month = foreach order_date generate GetMonth(date);
dump order_month;

order_quant_filter = filter orders by quantity > 1; -- only return orders where the person purchased multiples of an item
dump order_quant_filter;

two_filters = filter orders by quantity > 1 and order_id > 'o5'; -- multiple filters using and
dump two_filters;

tv_orders = filter orders by product matches '.*tv'; -- use regex to find match ending with tv
dump tv_orders;

speaker_orders = filter orders by product matches '.*speakers*.';
dump speaker_orders;

split orders into order_one if (quantity == 1), order_many if (quantity > 1);
dump order_one;
dump order_many;

split orders into order_with_username if (username is not null), order_missing_username if (username is null and order_id is not null);
dump order_with_username;
dump order_missing_username;
