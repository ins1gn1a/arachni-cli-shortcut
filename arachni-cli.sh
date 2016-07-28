#!/bin/bash

echo -e "\nOutput File: "
read output

echo -e "\nURL: "
read url

outputfile="$output.afr"

echo -e "\nCookie String (Enter nothing for no auth): "
read cookie

echo -e "\nUser Agent (1=IE11, 2=Chrome, 3=Firefox, Blank for Arachni): "
read useragent

echo -e "\nHTTP Request Concurrency (Blank for default '3'): "
read concurrency

echo -e "\nHTTP Request Queue Size (Blank for default '50'): "
read requestqueue

# User Agent Set
if [ -z "$useragent" ]; then
    useragent=""
elif [ $useragent -eq 1 ]; then
    useragent="--http-user-agent='Mozilla/5.0 (compatible, MSIE 11, Windows NT 6.3; Trident/7.0;  rv:11.0) like Gecko'"
elif [ $useragent -eq 2 ]; then
    useragent="--http-user-agent='Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'"
elif [ $useragent -eq 3 ]; then
    useragent="--http-user-agent='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.1'"
else
    useragent=""
fi

# Cookie set
if [ -z "$cookie"]; then
    cookie=""
else
    cookie="--http-cookie-string='"$cookie"'"
fi

# Concurrency
if [ -z "$concurrency" ]; then
    concurrency="--http-request-concurrency='3'"
else 
    concurrency="--http-request-concurrency='$concurrency'"
fi

# Request Queue
if [ -z "$requestqueue"]; then
    requestqueue="--http-request-queue-size='50'"
else
    requestqueue="--http-request-queue-size='$requestqueue'"
fi

echo -e "\n"arachni --output-verbose --scope-auto-redundant --audit-links --audit-forms $concurrency $cookie $useragent --report-save-path=$outputfile $url --scope-exclude-pattern=logout $requestqueue
