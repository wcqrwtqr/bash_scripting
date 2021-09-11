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


