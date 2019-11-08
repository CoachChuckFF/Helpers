#Python code to illustrate parsing of XML files 
# importing the required modules 
import csv 
import copy
import xml.etree.ElementTree as ET 
import glob
import os

xml_preamble = "put_pre-parsed_xml_here"
csv_preamble = "resulting_csv_here"

def getAllXmls():
    files = []

    os.chdir(xml_preamble)
    for file in glob.glob("*.xml"):
        files.append(file)
    os.chdir("..")
    return files

def parseXML(xmlfile): 

    data = []

    tree = ET.parse(xmlfile) 

    root = tree.getroot() 

    for job in root.iter('Job'):
        entry = {}
        time = job.attrib['Time']
        id = job.find('Id').text
        printer = job.find('Printer').text
        for name in job.iter('Standard'):
            name = name.find('Name').text
        entry['Id'] = id
        entry['Time'] = time
        entry['Printer'] = printer
        entry['Name'] = name
        data.append(entry)

    return data


def saveToCSV(data, filename): 

    fields = ['Id', 'Time', 'Printer', 'Name'] 

    with open(filename, 'w') as csvfile: 

        writer = csv.DictWriter(csvfile, fieldnames = fields) 

        writer.writeheader() 

        writer.writerows(data) 


def main(): 
    global_data = []
    files = getAllXmls()
    for file in files:
        data = parseXML(xml_preamble+'/'+file)
        for item in data:
            global_data.append(item)
        saveToCSV(data, csv_preamble+'/'+file[:-3]+'csv')

    saveToCSV(global_data, csv_preamble+'/global.csv')



if __name__ == "__main__": 

    # calling main function 
    main() 
