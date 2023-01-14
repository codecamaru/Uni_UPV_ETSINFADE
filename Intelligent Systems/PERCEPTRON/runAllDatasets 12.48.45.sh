#!/bin/sh

echo "\nOCR dataset\n"
echo "values of a from 0.1 to 10,000\n"
python experiment.py OCR_14x14 '.1 1 10 100 1000 10000' '0.1'
echo "\n values of b from 0.1 to 100,000\n"
python experiment.py OCR_14x14 '0.1' '.1 1 10 100 1000 10000 100000'

echo "\nEXPRESSIONS dataset\n"
echo "values of a from 0.1 to 10,000\n"
python experiment.py expressions '.1 1 10 100 1000 10000' '0.1'
echo "\n values of b from 0.1 to 100,000\n"
python experiment.py expressions '0.1' '.1 1 10 100 1000 10000 100000'

echo "\nGAUSS2D dataset\n"
echo "values of a from 0.1 to 10,000\n"
python experiment.py gauss2D '.1 1 10 100 1000 10000' '0.1'
echo "\n values of b from 0.1 to 100,000\n"
python experiment.py gauss2D '0.1' '.1 1 10 100 1000 10000 100000'

echo "\nGENDER dataset\n"
echo "values of a from 0.1 to 10,000\n"
python experiment.py gender '.1 1 10 100 1000 10000' '0.1'
echo "\n values of b from 0.1 to 100,000\n"
python experiment.py gender '0.1' '.1 1 10 100 1000 10000 100000'

echo "\nVIDEOS dataset\n"
echo "values of a from 0.1 to 10,000\n"
python experiment.py videos '.1 1 10 100 1000 10000' '0.1'
echo "\n values of b from 0.1 to 100,000\n"
python experiment.py videos '0.1' '.1 1 10 100 1000 10000 100000'