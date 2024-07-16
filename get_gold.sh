#!/usr/bin/env sh

# This cose is for fetching gold price data

json_data=$(curl -s -X 'GET' -H $'Host: data-asg.goldprice.org' -H $'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.6045.123 Safari/537.36' -H $'Origin: https://goldprice.org' -H $'Sec-Fetch-Site: same-site' -H $'Referer: https://goldprice.org/'  $'https://data-asg.goldprice.org/dbXRates/USD' | jq -r '.items[0].xauPrice')


echo "Gold price today: $json_data ounce"

