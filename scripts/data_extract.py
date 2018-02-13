"""

Script to extract vulnerability data and create skeleton YAML File.


"""

import csv
import sys
import yaml


skeletonYaml = "cve-skeleton.yml"

def read_yaml(filepath):
    with open(filepath, "r") as inputFile:
        data = yaml.load(inputFile)
    return data

def write_yaml(filepath, data):
    with open(filepath, "w") as outputFile:
        yaml.dump(data, outputFile)


"""  read_CSV_File reads in CSV file and data to dictionary """

def read_CSV_File(filename):
    inputFile = open(str(filename), 'rb')
    reader = csv.reader(inputFile)
    for row in reader:
        if "CVE-" in row[0]:
            print(row[0])
            cve_entry = row[0]
            outputfile = open((str(cve_entry) + ".yml"),"w" )
            secondFile = open(skeletonYaml, "r")
            fileLine = secondFile.readline()
            while fileLine:
                if "CVE:" in fileLine:
                    outputfile.write("CVE: " + cve_entry + "\n")
                else:
                    outputfile.write(fileLine)
                fileLine = secondFile.readline()

            outputfile.close()
"""
Main method
"""

if __name__ == '__main__':
    print("###\nScript to extract vulnerability data and create skeleton YAML file.\n###")
    vul_data_file = "../vul_data/httpd-vulnerabilities.csv"
#    data = read_yaml(skeletonYaml)
#    print(data)
    read_CSV_File(vul_data_file)
    
 
