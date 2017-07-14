students = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/subjects.txt'
as 
(
student_id: chararray,
name: chararray,
grade: int,
subject1: chararray,
subject2: chararray,
subject3: chararray
);
dump students;

students_bag = foreach students generate $0, $1, $2, TOBAG($3, $4, $5); -- each subject is now a single element tuple within the bag
describe students_bag;
dump students_bag;

/*
group will create bag (unordered collection of tuples) with 2 fields
the group key is student_id
the group will be a bag with a tuple
ex: (s123, {(s123,John,8,Math,Chemistry,Physics)}
    (s345, {(s345,Kathy,8,Magic,Unicorns,Physics)}
*/
subjects_bag = group students by student_id; 
describe subjects_bag;
dump subjects_bag;

s = foreach subjects_bag generate students.(student_id, name); -- format used to access data in bag
describe s;
dump s;
