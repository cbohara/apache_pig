marks = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/marks.txt'
as 
(
student_id: chararray,
name: chararray,
grade: int,
marks: map [int]
);
dump marks;

math_marks = foreach marks generate $1, $3#'Math'; -- access values with 'Math' key using #'keyname'
dump math_marks;

student_grade_map = foreach marks generate $0, TOMAP($1, $2); -- create key-value pair map
dump student_grade_map;

many_maps = foreach marks generate $0, TOMAP($1, $2), $3;
dump many_maps;
