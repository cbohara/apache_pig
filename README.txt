Download .tar.gz file from:
http://apache.mirrors.ionfish.org/pig/

###############################################
Apache Hadoop = distributed computing framework
###############################################
HDFS
    file system to manage the storage of data across multiple machines in the cluster
MapReduce
    parallel processing framework
    process data across multiple servers
YARN
    framework to run and manage data processing tasks

Apache Hive = data warehouse
    all orgs are constantly collecting data
    data warehouse
        where data for analytical processing is typically stored
        huge database in distributed computing framework
        stores data from multiple sources
        contains semi-structured and unstructured data
    extracting info from a data warehouse
        process heavy
        long-running jobs
        source of data for analysts and engineers
    Hive runs ON TOP of Hadoop
        stores all data in HDFS
    all HiveQL queries are converted to MapReduce jobs
        HiveQL = query language to process data
        query data in HDFS for analysis and insights
        very similar to SQL

Apache Pig = ETL tool
    extract data from a source > transform so it is useful > load into data warehouse
    used by developers to bring together useful data into 1 place
    deals with data that is
        unstructured
        missing values
        inconsistent
    high level scripting language
    directly works on files in HDFS
    Pig extracts data, cleans it up, and and then loads data into HDFS

Pig Latin = scripting language
    data flow language
    clean data with inconsistent or incomplete schema so you can later query it
    store in data warehouse
    procedural
        specify exactly how data is to be modified at each step
        no if statements or for loops
    often used with Hadoop
        data from 1+ sources can be read, processed and stored in parallel
        provides built-in functions of standard data operations
    very efficient
        Pig Latin commands transformed to MapReduce jobs behind the scenes

pig modes of operation
    local mode 'pig -x local'
        runs on a single machine
        does not require Hadoop
        will store data on local filesystem
        opens GRUNT shell = Pig’s REPL environment
    MapReduce mode `pig -x mapreduce`
        runs on a Hadoop cluster with HDFS
        Pig can be installed on any machine connected to the cluster
        does not need to be installed on each machine
        used in production
    interactive mode
        REPL environment GRUNT
        via command line
        immediate feedback
        use to figure out what commands you want to run
    batch mode
        create Pig script with all commands
        use in production

GRUNT
invoked when using `pig` command in any mode of operations
update log4j.properties to output only errors

open GRUNT REPL
`pig -x local -4 conf/log4j.properties` will open GRUNT shell with less noise
run Pig script
`pig -x local -4 conf/log4j.properties [pig file name]`
can interact directly with HDFS in GRUNT
`copyToLocal hdfsFile localFile`

loading data into relations
    relations
        basic structure that holds data
        aka variables
        Pig operations are performed on relations
        may or may not have schema
        immutable
        updates to a relation creates a new relation
        need to store transformations into a new relation
        stored in memory
        ephemeral
        exist only for duration of Pig session
    lazy evaluation
        transformations not evaluated until display results to screen or store in file

##############
pig commands
##############
PigStorage()
    built-in function
    deserializes and reads data from disk
    serializes and writes data to disk
    writes to directory
        _SUCCESS (MapReduce status output)
        part-r-0000 (contains actual data)
    directory cannot already exist
    default = tab delimiter
    pass in PigStorage(‘,’) for csv files

describe
    provides schema info

foreach
    iterates over every record in the relation
    generates $[index number]
    chooses certain fields we are interested in

###############
pig data types
###############
complex
collection types represent a group of entities
tuple
ordered collection of fields
ex: (134, “John”, “Smith”, “HR”, 9)
each field has its own data type
if no data type is specified, defaults to bytearray
TOTUPLE() creates tuple from individual fields

bag
a relation is a bag
bag = unordered collection of tuples
ex: { (tuple 1), (tuple 2), (tuple 3) }
can have duplicates
each tuple can have different number and type of fields
if pig tries to access a field that does not exist, a null value is substituted
pig creates bags when you use the group command

map
key-value pair data type
keys
must be of type chararray
must be unique
used to look up associated value
value can be any data type
ex: [John#HR Jill#Engg Nina#Engg]
# separates the key and the value

unknown or partial schemas
if schema is not known
pig will still accept data
attempt to guess data type
defaults to bytearray data type
if we provide a schema, but the data does not fit according to pig
pig will try and convert the data as specified in schema
ex: if you do multiplication on a field, pig will assume it is a numeric value
this conversion will not always be successful in practice

functions
built-in User Defined Functions (UDF)
user defined = defined by any developer working on the pig project
can write UDFs in Java, Python, etc.
https://pig.apache.org/docs/r0.9.1/func.html

#####
union
#####
the result of a union is all tuples of individual relations come together in 1 relation
does not preserve order of tuples in original relation
preserves duplicates
relations need to have
same number of fields
if you try to perform a union on relations with diff number of fields > results in null  
data types need to be compatible
if the number of fields are the same, but the data types of those fields are diff > pig will try to find common ground
(most precise) double > float > long > int > bytearray (least precise)
pig will cast the union data value to the more precise value

#####################
different inner types
#####################
if trying to compare values of different types within a tuple, pig will likely be confused and result in an empty complex data type
onschema
will try to match fields with the same type
otherwise keeps original or nulls empty fields with null

#############################
executing MapReduce using pig
#############################
foreach will iterate over each record in a relation
do not want to iterate over all the records multiple times
nested foreach
combine multiple operations over the records of a dataset
avoid iterating over the dataset multiple times

#################
command wiki
#################

FOREACH GENERATE 
works exactly like SELECT in SQL
new_relation = FOREACH relation_name GENERATE field;

INDEXOF() 
accepts a string value, a character, and an index #
it returns the first occurance of the char in the string

ex: file contains employee records 001,Robin,22,newyork
emp_data = LOAD '../emp.txt' USING PigStorage as (id:int, name:chararray, age:int, city:chararray);
# parse the name of each employee and return the index value at which the letter 'r' occurs the first time
# if 'r' does not exist return -1
indexof_data = FOREACH emp_data GENERATE (id,name), INDEXOF(name,'r',0);
# result will be stored in relation
dump indexof_data;
> ((1,Robin),-1)
> ((7,Robert),4)
# can use FILTER to ensure that 'r' does not occur within the name
contains_r = FILTER indexof_data BY INDEXOF(name, 'r', 0) < 0;
# can use FILTER to ensure that 'r' does occur within the name
no_r = FILTER indexof_data BY INDEXOF(name, 'r', 0) > 0;
