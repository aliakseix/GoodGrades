#!/bin/bash

# download the webpage to our local machine
curl -s https://en.wikipedia.org/wiki/List_of_municipalities_of_Norway > "page.html.txt"


# removing whitespace characters (also tabs, just to be sure.)
cat "page.html.txt" | tr -d '\n\t' > "page.html.one.line.txt"


# everything is on the same line; extracting our table in the 3 line (putting whitespace characters around it)
sed -E 's|<table class="sortable wikitable">|\n<table class="sortable wikitable">|' "page.html.one.line.txt" |
  sed -E 's|</table>|</table>\n|g'  > "page.html.table.newline.txt"

# only take the 3rd line
sed -n '3p' "page.html.table.newline.txt" > "table.only.txt"

# string literal - our future page -- inserting extracted table as body content
page_template='
 <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Our fancy webpage (for E)</title>
  </head>
  <body>
  <h1>My fancy webpage</h1>
  '"$(cat "table.only.txt")"'</body>
</html>
'

# dumping variable contents in a file
echo "$page_template" > "our.page.html"
