/*
This is my first pig script
*/

A = load '/Users/cbohara/tools/pig-0.16.0/build.xml' using PigStorage(); -- loading data
dump A; -- print results to screen
