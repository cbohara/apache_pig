groceries_dir = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/groceries_dir/' using PigStorage(','); -- reads in csv data
dump groceries_dir; -- prints to stdout

groceries = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/groceries.csv' using PigStorage(',') 
as 
(
order_id: chararray, 
location: chararray, 
product: chararray, 
day: datetime, 
revenue: double
); -- specify schema

describe groceries; -- prints schema to stdout
dump groceries;

locations = foreach groceries generate $1; -- foreach iterates over relation and generate grabs the data at index 1
describe locations; -- preserves the data type provided in original groceries relation
dump locations;

products = foreach groceries generate $2;
describe products;
dump products;

groceries_subset = limit groceries 5; -- use limit to grab subset of original relation
dump groceries_subset;

store groceries_subset into '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/subset_dir/' using PigStorage(','); -- writes comma delimited data into directory and directory cannot already exist 

groceries_order_bag = foreach groceries generate $0, $1, TOTUPLE($2, $4); -- TOTUPLE creates tuple with elements at index 2 and 4 from groceries relation
describe groceries_order_bag;
dump groceries_order_bag;

groceries_no_datatype = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/groceries.csv' using PigStorage()
as
(
order_id,
location,
product,
day,
revenue
); -- demo how pig will cast the datatype to each field
describe groceries_no_datatype;
