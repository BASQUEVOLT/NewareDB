# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 12:58:01 2024

@author: EugenioCalandrini
"""

# from galvani import BioLogic
# MPRfile_list = glob.glob(vmp_path+"\*.mpr")
# mpr_file = BioLogic.MPRfile(MPRfile_list[10])
# df1 = pd.DataFrame(mpr_file.data)
# print(df1)
import pandas as pd
import glob

def MPTfile_read(MPTfile):
    
    #find the state of the cell (first character of the filename)
    state = MPTfile.split('\\')[-1].split("-")[0].split("_")[0]
    
    #find the barcode
    barcode = MPTfile.split('\\')[-1][4:-3].split("_C")[0].split("_D")[0]
    
    #read the file content
    with open(MPTfile, 'r') as f:
            lines = f.readlines()
            
            #read the lines to skip
            skiplines = int(lines[1].split(" : ")[1].strip())
            
            #search for the start date and used channel
            for line in lines:
                if "Acquisition started on" in line:
                    date_meas = line.split(" : ")[1].strip()
                if "Run on channel" in line:
                    channel = int(line.split(" : ")[1].strip()[:2])
    
    #import the data into a pd dataframe
    usecols = ['freq/Hz', 'Re(Z)/Ohm', '-Im(Z)/Ohm', '|Z|/Ohm', 'Phase(Z)/deg',
           'time/s', '<Ewe>/V', '<I>/mA', 'Cs/µF', 'Cp/µF', 'cycle number',
           '|Ewe|/V', '|I|/A', 'Ns', 'I Range', '(Q-Qo)/mA.h']
    
    # df = pd.read_csv(file, skiprows=skiplines-1, encoding='ISO-8859-1', sep="\t", header=0)
    df = pd.read_csv(MPTfile, skiprows=skiplines-1, usecols=usecols, encoding='ISO-8859-1', sep="\t", header=0)
    
    #add the other values to the dataframe
    df["Barcode"] = barcode
    df["Date"] = date_meas
    df["State"] = state
    df["Channel"] = channel
    print(f"importing cell {barcode} at stage {state}")
    return df

#use your path to SP
vmp_path = r"C:\Users\EugenioCalandrini\Basquevolt S.A\Basquevolt R&D - Lab raw data\VMP300\Quality checks\1Ah\BSQV CELLS"

#find all the mpt files
MPTfile_list = glob.glob(vmp_path+"\*.mpt")

for file in MPTfile_list[10:11]:    
    df = MPTfile_read(file)
print(df)
