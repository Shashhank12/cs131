# A2 - Data Collector Script

This directory contains a script called `datacollector.sh` which provides a summary of CSV files

## What this command does
1. Prompts the user for a URL
2. Downloads and potentially extracts zip data
3. Takes all CSV files in the current directory and creates a summary.md for them.
4. Generates a summary for different feature names and provides a statistical analysis for numerical columns

## How to use this command
1. Clone the repository `git clone https://github.com/Shashhank12/cs131`
2. Make your current working directory to `./cs131/a2`
3. Give appropriate permissions using `chmod 777 datacollector.sh`
4. Run the command using `./datacollector.sh'
5. Provide the URL and recieve the statistical analysis under the a2 directory.

## Demo
```
shashhank_seethula@instance-20250602-163959:~/cs131/a2$ ./datacollector.sh
Enter URL for dataset:
https://archive.ics.uci.edu/static/public/186/wine+quality.zip
Downloading data
--2025-07-02 06:56:30--  https://archive.ics.uci.edu/static/public/186/wine+quality.zip
Resolving archive.ics.uci.edu (archive.ics.uci.edu)... 128.195.10.252
Connecting to archive.ics.uci.edu (archive.ics.uci.edu)|128.195.10.252|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified
Saving to: ‘wine+quality.zip’

wine+quality.zip                                         [ <=>                                                                                                                ]  89.21K  --.-KB/s    in 0.05s

2025-07-02 06:56:31 (1.61 MB/s) - ‘wine+quality.zip’ saved [91353]

Download complete
Archive:  wine+quality.zip
  inflating: winequality-red.csv
  inflating: winequality-white.csv
  inflating: winequality.names
Feature summary completed for winequality-red.csv with the name winequality-red_summary.md
Feature summary completed for winequality-white.csv with the name winequality-white_summary.md
Script completed
```
