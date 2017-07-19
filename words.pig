lines = load '/Users/cbohara/tools/pig-0.16.0/pluralsight/data/words.txt' as (line: chararray);
-- dump lines;

word_bag = foreach lines generate TOKENIZE(line) as bag_of_words; -- TOKENIZE will split the line into a bag of words
-- dump word_bag;

words = foreach word_bag generate flatten(bag_of_words) as word; -- every word in the bag is now an individual tuple
-- dump words;

word_group = group words by word;
-- describe word_group;
-- dump word_group;

word_count = foreach word_group generate group, COUNT(words);
describe word_count;
dump word_count;
