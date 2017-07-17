student_activities = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/student_activities.txt' as
(
student_id: chararray,
name: chararray,
activity1: chararray,
activity2: chararray,
activity3: chararray,
activity4: chararray
);
-- dump student_activities;

student_activity_bag = foreach student_activities generate student_id, name, TOBAG(activity1, activity2, activity3, activity4) as activities;
-- dump student_activity_bag;;

flatten_activities = foreach student_activity_bag generate name, flatten(activities) as activity;
dump flatten_activities;
