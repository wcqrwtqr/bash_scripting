#!/usr/bin/env bash


# Author: Mohammed Albatati
# Date: 16 Aug 2022
# Script to convert units quicly without going to the site

num=$(( (RANDOM % 10)+1))
random_color=`tput setaf "$num"`
reset=`tput sgr0`

checkvalue(){
    num=$1
    if [ $num -gt 20000]; then
        echo "$num"
        echo "Value is too high, check the value again"
    else
        echo "$num"
    fi
}

leterminTobbl(){
    read -p "Enter value in leter/min: " value
    echo "$value leter/min equals -> ${random_color}"
    res=`echo "$value*9.054144" | bc`
    checkvalue $res 2>/dev/null
    echo "${reset}bbl/day"
}

metercubedayTobbl(){
    read -p "Enter value in meter^3: " value
    echo "$value meter3/day equals -> ${random_color}"
    res=`echo "$value*6.2876" | bc`
    checkvalue $res 2>/dev/null
    echo "${reset}bbl/day"
}

metercubehourTobbl(){
    read -p "Enter value in meter^3/hour: " value
    echo "$value meter3/hour equals -> ${random_color}"
    res=`echo "$value*150.9096" | bc`
    checkvalue $res 2>/dev/null
    echo "${reset}bbl/day"
}

gpmTobbl(){
    read -p "Enter value in Gallon per minute: " value
    echo "$value Gallon equals -> ${random_color}"
    # echo "$value*34.28571312" | bc
    res=`echo "$value*34.28571312" | bc`
    checkvalue $res 2>/dev/null
    echo "${reset}bbl/day"
}

echo "Enter conv unit"
echo "1. ${random_color}meter3/day${reset} to bbl/day"
echo "2. ${random_color}meter3/hour${reset} to bbl/day"
echo "3. ${random_color}leter/min${reset} to bbl/day"
echo "4. ${random_color}gallon/min${reset} to bbl/day"
read -p "Select: " unit
echo "=========="
case $unit in
    1) metercubedayTobbl;;
    2) metercubehourTobbl;;
    3) leterminTobbl;;
    4) gpmTobbl;;
esac
