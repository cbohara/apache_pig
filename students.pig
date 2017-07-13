students = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/students.txt'
as 
(
student_id: chararray,
name: chararray,
grade: int,
contact: tuple(city: chararray, phone: chararray)
);
describe students;

student_info = foreach students generate $1, $3.$0, $3.$1; -- use . to access fields in tuple
dump student_info;

