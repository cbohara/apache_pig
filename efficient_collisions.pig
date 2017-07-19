collisions = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/nypd.csv' using PigStorage(',');
collisions_useful = foreach collisions generate $0 as date, $2 as borough, $3 as zipcode, TRIM($8) as location, $11 + $13 + $15 + $17 as injured, TRIM($19) as reason;

collisions_injured = foreach collisions_useful generate reason, borough, location, injured;
-- describe collisions_injured;

collisions_group = group collisions_injured by (borough, reason);
-- describe collisions_group;

collisions_total_raw = foreach collisions_group generate group.borough, group.reason, COUNT(collisions_injured) as total;
-- dump collisions_total_raw;

collisions_total = filter collisions_total_raw by borough is not null and reason is not null; -- clean up data so we only keep data with both borough and reason values 
-- dump collisions_total;

collisions_total_group = group collisions_total by borough;
describe collisions_total_group;
dump collisions_total_group;
