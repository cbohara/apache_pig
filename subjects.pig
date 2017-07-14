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
