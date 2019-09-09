#! /bin/bash

echo "------------- Quote of the Day -----------------"
echo ""

curl -s https://www.brainyquote.com/quote_of_the_day | grep 'Love Quote of the Day' -A 5 > Raw

grep 'view quote' Raw > Quote
grep 'view author' Raw > Author

python << END
import re
with open('Quote') as quoteFile:   
    quoteString = quoteFile.readline()
with open('Author') as authorFile:
    authorString = authorFile.readline()

    quote = re.findall('(?<=\"view quote\">).+?(?=\<\/a>)', quoteString)
    print('\"' + quote[0] + '\"')

    author = re.findall('(?<=\"view author\">).+?(?=\<\/a>)', authorString)
    print('-' + author[0])
END

rm Quote
rm Author
rm Raw

echo ""
echo "------------------------------------------------"
