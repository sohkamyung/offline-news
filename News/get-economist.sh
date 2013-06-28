#! /bin/bash

echo removing current printedition
rm printedition

echo getting new printedition
wget "http://www.economist.com/printedition/" -O printedition

echo converting printedition
python convert.py
