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

student_info_bag = foreach students generate TOTUPLE($0, $1, $2), $3;
dump student_info_bag;

unpack_student_info = foreach students generate name, contact.city, contact.phone;
dump unpack_student_info;
