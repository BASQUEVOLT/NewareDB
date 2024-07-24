# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 12:58:01 2024

@author: EugenioCalandrini
"""

from galvani import BioLogic
import pandas as pd
import numpy as np
import glob
import os

# =============================================================================
# WITH BIOLOGIC LIBRARY
# =============================================================================

#use your path to SP
vmp_path = r"C:\Users\EugenioCalandrini\Basquevolt S.A\Basquevolt R&D - Lab raw data\VMP300\Quality checks\1Ah\CIC CELLS"

MPRfile_list = glob.glob(vmp_path+"\*.mpr")
mpr_file = BioLogic.MPRfile(MPRfile_list[10])
for module in mpr_file.modules:
    print(module)

for file in MPRfile_list:
    
    #find the state of the cell (first 3 character of the filename)
    state = file.split('\\')[-1].split("-")[0].split("_")[0]
    
    #find the barcode
    barcode = file.split('\\')[-1][4:-3].split("_C")[0].split("_D")[0]
    
    #find the channel (number after the _C)
    channel = file.split('\\')[-1][4:-3].split("_C")[1][:2]
    
    mpr_file = BioLogic.MPRfile(file)
    df = pd.DataFrame(mpr_file.data)
    df["Date"] = mpr_file.startdate
    df["Barcode"] = barcode
    df["State"] = state
    df["Channel"] = channel
    print(f"importing cell {barcode} at stage {state}")

# =============================================================================
# WITHOUT BIOLOGIC LIBRARY
# =============================================================================

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

# =============================================================================
# FUNCTION TO READ THE FILENAMES
# =============================================================================

def filename_split_bqv(filename):
    """
    Function to retrieve cell_ID, State and Channel from the VMP filename for BQV cells
    This search algorithm should be independent of the separator.
    Use this function for the cells in the folder: 'C:\\Users\testlab\Documents\GEIS QUALITY MEASUREMENTS\Quality checks\1Ah\BSQV CELLS'

    Parameters
    ----------
    filename : str
        filename of the mpr file, no absolute path.

    Returns
    -------
    cell_ID : str
        ID of the measured cell, can be a vicarli ID or the old RDML format.
    channel : int
        VMP channel used for the measurement.
    state : str
        State of the cell, e.g. BWT (before wetting), AWT (after wetting) 
    """
    # print(filename)
    #remove unwanted characters $ or ñ
    test = os.path.splitext(filename.replace("ñ", "").replace("$", ""))[0]
    
    #split the string
    temp, channel = test.split("_C")
    
    #cast the channel from string to int
    channel = int(channel)
    
    #find the position of the string 'bqv' or 'rdml' if not found find returns -1
    bqv_position = temp.lower().find('bqv')
    rdml_position = temp.lower().find('rdml')
    
    if bqv_position > 0:
        #find the vicarli ID
        cell_ID = temp[bqv_position-len("1003-"):][:25]
        #find the state
        state = temp[:bqv_position-len("1003-")-1]
        
    elif rdml_position > 0:
        cell_ID = temp[rdml_position:-1]
        state = temp[:rdml_position-1]
    print(cell_ID, channel, state)

    return cell_ID, channel, state

def filename_split_cic(filename):
    """
    Function to retrieve cell_ID, State and Channel from the VMP filename for CIC cells
    This search algorithm should be independent of the separator.
    Use this function for the cells in the folder: C:\\Users\testlab\Documents\GEIS QUALITY MEASUREMENTS\Quality checks\1Ah\CIC CELLS

    Parameters
    ----------
    filename : str
        filename of the mpr file, no absolute path.

    Returns
    -------
    cell_ID : str
        ID of the measured cell.
    channel : int
        VMP channel used for the measurement.
    state : str
        State of the cell, e.g. BWT (before wetting), AWT (after wetting) etc etc.

    """
    # print(filename)
    test = os.path.splitext(filename.replace("ñ", "").replace("$", ""))[0]
    cic_position = test.lower().find('cic')
    if cic_position > 0:
        state = test[:cic_position-1]
        temp = test[cic_position:]
        # print(temp)
        ID, channel = temp.lower().split("_c")
    
    print(ID, int(channel), state)

    return ID, int(channel), state

folder = r"C:\Users\EugenioCalandrini\OneDrive - Basquevolt S.A\Documents\Lavoro\Results\vmp_files\\"
bqv_cell_file = "bqv_vmp_files.txt"
cic_cell_file = "cic_vmp_files.txt"

# Initialize an empty list to store file names
cic_files = []

# Open and read the file
with open(folder+cic_cell_file, 'r') as file:
    # Read all lines from the file and strip newline characters
    cic_files = [line.strip() for line in file.readlines() if line.strip().endswith('.mpr')]
    
bqv_files = []

# Open and read the file
with open(folder+bqv_cell_file, 'r') as file:
    # Read all lines from the file and strip newline characters
    bqv_files = [line.strip() for line in file.readlines() if line.strip().endswith('.mpr')]

    

    
for file in bqv_files:
    filename_split_bqv(file)
    
for file in cic_files:
    filename_split_cic(file)
