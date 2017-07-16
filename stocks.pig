names = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/names.csv' using PigStorage(',') as
(
symbol: chararray,
name: chararray,
revenue: chararray
);
describe names;

trades = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/trades.csv' using PigStorage(',') as
(
symbol: chararray,
open: double,
high: double,
low: double,
close: double,
date: datetime
);
describe trades;

names_trades = join names by symbol, trades by symbol;
describe names_trades;
-- dump names_trades;
names_trades_useful = foreach names_trades generate names::symbol, revenue, close, date; -- need to specify an original relation if the field existed in both relations, otherwise you do not need to specify original relation
-- dump names_trades_useful;

names_trades_left_outer = join names by symbol left outer, trades by symbol;
-- dump names_trades_left_outer; -- every record from the names record will be present in the final result, either filled with info from trades or nulls for missing values

names2 = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/names.csv' using PigStorage(',') as
(
symbol: chararray,
name: chararray,
revenue: chararray
);

names_self = join names by symbol, names2 by symbol;
dump names_self;
