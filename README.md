# Bash Scripting
My bash scripting files which I use in my daily work to get some automation and make my life easier.
To use the script in your computer simply download the files or clone it, then move the script to folder at your PATH like "/usr/bin/" or "/usr/local/bin/"
The use the command to add the executable flag to it
```bash
chmod +x filename # make the script executable
cp filename /usr/local/bin/ # Copy the file to the directory (mac)
#or
cp filename /usr/bin/ # Copy the file to the directory (other)
```
Now to run the script from anywhere just type the script name and it will run 

## getGaugesData
This bash script was made to get the header data from DH memory gagues txr files and use awk to calculate the max temperature and pressure and print the results to standard output, also take some values and specific order and add it to a txt file in a csv manner so its easy to convert it to excel later one.
Used this script to loop over 70 gauges txt files and extract the values and produce a csv file and another file with the standard output so we can check it one by one along with the file name.
Used the below command to do the looping in the terminal after putting all the required files in a folder and running the command

``` bash
for file in *.pdf; do getGaugesData $file ;done
```

## getPrices
This script is used to use cURL and go to gold prices site and crude oil prices and scrap the web page and filter for the needed prices of the day.

After making the script executable and moved to /usr/bin/ or /usr/local/bib/ then you can simply run the command in terminal like below.

```bash
getPrices
```
A questions will be asked and needs to be answered:
* Which price you are looking to read? 
* 1) Oil Price type 1
* 2) Gold Price type 2
* 3) Both (leave blank and hit enter)

## yttrim
This script is used to download youtube video with a selected duration and start so instead of downloading the whole 1 or 2 hour video instead I can ask the script to download the video starting on time hh:mm:ss and for duration of X sec and the file downloaded will be the small portion you need.
The script will be asking for the input as you go so there is no need to pass any arguments to the script.
After making the script executable and moved to /usr/bin/ or /usr/local/bib/ then you can simply run the command in terminal like below.

```bash
yttrim
```
Three questions will be asked and needs to be answered:
* Provide the link of the youtube video 
* Provide the starting point like (00:01:20) starting first minute and 20 sec (If left blank then it will start from the beginning)
* Provide the duration (should be more than 1 sec)

