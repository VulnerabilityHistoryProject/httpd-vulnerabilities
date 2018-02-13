"""
Script to extract vulnerability data and create skeleton YAML File.

"""
import yaml
import csv
import sys

"""
 readingFile reads in CSV file and data to dictionary
"""

def readingFile(filename):
    inputFile = open(str(filename), 'rb')
    reader = csv.reader(inputFile)
    for row in reader:
        if "CVE-" in row[0]:
            print(row[0])
"""
Main method
"""

if __name__ == '__main__':
    print("###\nScript to extract vulnerability data and create skeleton YAML file.\n###")
    # reading in file "httpdData.csv"
    readingFile("../vul_data/httpd-vulnerabilities.csv") 
