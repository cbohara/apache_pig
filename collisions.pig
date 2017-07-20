collisions = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/nypd.csv' using PigStorage(',');
limit_collisions = limit collisions 100000;

header = limit limit_collisions 1;
-- dump header;

subset = foreach limit_collisions generate $0 as date, $2 as borough, $3 as zipcode, TRIM($8) as location, ($11 + $13 + $15 + $17) as injured, TRIM($19) as reason;
-- dump subset;

collisions_reason_injured = foreach subset generate reason, borough, injured;
describe collisions_reason_injured;
-- collisions_reason_injured: {reason: chararray,borough: bytearray,injured: double}

collisions_borough_group = group collisions_reason_injured by borough;
limit_borough = limit collisions_borough_group 2;
-- dump limit_borough; -- limiting doesn't necessarily lead to insight because a bag contains so many records

num_collisions_per_borough = foreach collisions_borough_group generate group, COUNT(collisions_reason_injured);
-- dump num_collisions_per_borough;
