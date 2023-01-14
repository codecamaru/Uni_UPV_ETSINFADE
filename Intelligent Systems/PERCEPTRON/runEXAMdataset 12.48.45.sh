#!/bin/sh

echo "\ndataset4GIA2 dataset\n"
echo "values of a from 0.1 to 10,000 and k=1200\n"
python experimentk.py dataset4GIA2 '.1 1 10 100 1000 10000' '0.1' '1200'
echo "\n values of b from 0.1 to 100,000 and k=1200\n"
python experimentk.py dataset4GIA2 '0.1' '.1 1 10 100 1000 10000 100000' '1200'