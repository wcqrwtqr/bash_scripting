# bash_scripting
My bash scripting files which I use in my daily work to get some automation and make my life easier.


# getGaugesData
This bash script was made to get the header data from DH memory gagues txr files and use awk to calculate the max temperature and pressure and print the results to standard output, also take some values and specific order and add it to a txt file in a csv manner so its easy to convert it to excel later one.
Used this script to loop over 70 gauges txt files and extract the values and produce a csv file and another file with the standard output so we can check it one by one along with the file name.
Used the below command to do the looping in the terminal after putting all the required files in a folder and running the command

{{{bash
for file in *.pdf; do getGaugesData $file ;done
}}}


