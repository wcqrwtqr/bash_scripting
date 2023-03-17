#!/usr/bin/env sh

# This code is used to loop thorugh the web link having book pages for each page
# I did som trails beofre writing this code and it seems that for the pages from 1 to 10 uses the format 0001,0002,..., 0009
# and for the 10's uses the form 0010,0011,...,0099
# and for the 100's uses the form 0100,0101,...,0999
# So you neeed to ensure adding the 0's in the link for each loop
# NOTE: this page has this 000's and might not be the same in each website, so
# ensre to udo some trail and error.
# TODO: try to miminze the for loop and use cases instead of repleating the code

# Type the pages you need to download
echo "What is the first page to download:\n"
read  FIRST_PAGE
echo "What is the last page to download:\n"
read  LAST_PAGE

# NUM_PAGES=120 ## the old manual method

ones="000"
tens="00"
hunders="0"

URL_first="https://ia803100.us.archive.org/BookReader/BookReaderImages.php?zip=/29/items/al.mojiza1/al.mojiza1_jp2.zip&file=al.mojiza1_jp2/al.mojiza1_"
URL_end=".jp2&id=al.mojiza1&scale=2&rotate=0"

# For loop, ensure to change the i starting point based on the
# for ((i=1; i<=$NUM_PAGES; i++))
for ((i=$FIRST_PAGE; i<=$LAST_PAGE; i++))
do
   if [ $i -le 9 ]; then
   curl "${URL_first}""${ones}""${i}""${URL_end}" -o "$i.jpg"
   fi

   if [ $i -ge 10 ] &&  [ $i -le 99 ]; then
   curl "${URL_first}""${tens}""${i}""${URL_end}" -o "$i.jpg"
   fi

   if [ $i -ge 100 ] &&  [ $i -le 999 ]; then
   curl "${URL_first}""${hunders}""${i}""${URL_end}" -o "$i.jpg"
   fi
   if [ $i -gt 1000 ]; then
   echo "thats too much pages ha ha ha"
   # curl "${URL_first}""${hunders}""${i}""${URL_end}" -o "$i.jpg"
   fi
   # sleep 1
done
