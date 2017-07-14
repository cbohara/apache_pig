orders = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/orders_duplicates.json' using JsonLoader('
order_id: chararray,
username: chararray,
product: chararray,
quantity: int,
amount: double,
order_date: chararray,
zipcode: chararray
');
dump orders;

no_duplicates = distinct orders;
dump no_duplicates;

limit_3 = limit orders 3;
dump limit_3;

orders_desc = order orders by order_id desc;
dump orders_desc;
