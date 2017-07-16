collisions = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/nypd.csv' using PigStorage(',');
limit_collisions = limit collisions 100000;

header = limit limit_collisions 1;
dump header;

subset = foreach limit_collisions generate $0 as date, $2 as borough, $3 as zipcode, TRIM($8) as location, ($11 + $13 + $15 + $17) as injured, TRIM($19) as reason;
dump subset;

reason_injured = foreach subset generate reason, borough, injured;
dump reason_injured;

group_by_reason = group reason_injured by reason;
describe group_by_reason;

group_by_borough = group reason_injured by borough;
describe group_by_borough;
limit_borough = limit group_by_borough 2;
dump limit_borough;
