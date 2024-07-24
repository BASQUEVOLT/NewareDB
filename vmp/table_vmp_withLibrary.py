# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 12:58:01 2024

@author: EugenioCalandrini
"""

from galvani import BioLogic
import pandas as pd
import glob
import os

# =============================================================================
# WITH BIOLOGIC LIBRARY
# =============================================================================

# DO THE UPLOAD ONLY ONCE IN THE PATH C:\Users\testlab\Documents\GEIS QUALITY MEASUREMENTS\Quality checks\1Ah\CIC CELLS
# SCHEDULE THE UPLOAD IN THE PATH C:\Users\testlab\Documents\GEIS QUALITY MEASUREMENTS\Quality checks\1Ah\BSQV CELLS

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
        State of the cell, e.g. BWT (before wetting), AWT (after wetting) etc etc.
    """
    # print(filename)
    #remove unwanted characters $ or ñ
    test = os.path.splitext(filename.replace("ñ", "").replace("$", ""))[0]
    
    #split the string
    split_string = test.split("_C")
    
    #cast the channel from string to int
    channel = int(split_string[-1])
    
    #find the position of the string 'bqv' or 'rdml' if not found find returns -1
    bqv_position = split_string[0].lower().find('bqv')
    rdml_position = split_string[0].lower().find('rdml')
    
    if bqv_position > 0:
        #find the vicarli ID
        cell_ID = split_string[0][bqv_position-len("1003-"):][:25]
        #find the state
        state = split_string[0][:bqv_position-len("1003-")-1]
        
    elif rdml_position > 0:
        cell_ID = split_string[0][rdml_position:-1]
        state = split_string[0][:rdml_position-1]
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
    print(test)
    cic_position = test.lower().find('cic')
    if cic_position > 0:
        state = test[:cic_position-1]
        temp = test[cic_position:]
        # print(temp)
        split_string = temp.lower().split("_c")
        ID = split_string[0]
        channel = split_string[-1]
    
    print(ID, int(channel), state)

    return ID, int(channel), state

#use your path to SP -> CHANGE ON THE SERVER WITH THE PATH C:\Users\testlab\Documents\GEIS QUALITY MEASUREMENTS\Quality checks\1Ah\BSQV CELLS
vmp_path = r"C:\Users\EugenioCalandrini\Basquevolt S.A\Basquevolt R&D - VMP300\Quality checks\1Ah\CIC CELLS"

os.chdir(vmp_path)

MPRfile_list = glob.glob(vmp_path+"\*.mpr")

for file in MPRfile_list:
    
    filename = file.split("\\") [-1]
    print(f"importing file {filename}")
    
    if "cic" in filename.lower():
        barcode, channel, state = filename_split_cic(filename)
    else:
        barcode, channel, state = filename_split_bqv(filename)
    
    mpr_file = BioLogic.MPRfile(file)
    df = pd.DataFrame(mpr_file.data)
    df = df[['freq/Hz', 'Re(Z)/Ohm', '-Im(Z)/Ohm', 'time/s', '<Ewe>/V', '<I>/mA', 'Cs/µF', 'Cp/µF']]
    df["Date"] = mpr_file.startdate
    df["Barcode"] = barcode
    df["State"] = state
    df["Channel"] = channel
    df["id"] = filename

    print(len(df.columns))
    
    #THE DF DATAFRAME HAS THE STRUCTURE OF THE TABLE TO UPLOAD ON THE DATABASE
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    






    
    
    

# =============================================================================
# WITHOUT BIOLOGIC LIBRARY
# =============================================================================

# def MPTfile_read(MPTfile):
    
#     #find the state of the cell (first character of the filename)
#     state = MPTfile.split('\\')[-1].split("-")[0].split("_")[0]
    
#     #find the barcode
#     barcode = MPTfile.split('\\')[-1][4:-3].split("_C")[0].split("_D")[0]
    
#     #read the file content
#     with open(MPTfile, 'r') as f:
#             lines = f.readlines()
            
#             #read the lines to skip
#             skiplines = int(lines[1].split(" : ")[1].strip())
            
#             #search for the start date and used channel
#             for line in lines:
#                 if "Acquisition started on" in line:
#                     date_meas = line.split(" : ")[1].strip()
#                 if "Run on channel" in line:
#                     channel = int(line.split(" : ")[1].strip()[:2])
    
#     #import the data into a pd dataframe
#     usecols = ['freq/Hz', 'Re(Z)/Ohm', '-Im(Z)/Ohm', '|Z|/Ohm', 'Phase(Z)/deg',
#            'time/s', '<Ewe>/V', '<I>/mA', 'Cs/µF', 'Cp/µF', 'cycle number',
#            '|Ewe|/V', '|I|/A', 'Ns', 'I Range', '(Q-Qo)/mA.h']
    
#     # df = pd.read_csv(file, skiprows=skiplines-1, encoding='ISO-8859-1', sep="\t", header=0)
#     df = pd.read_csv(MPTfile, skiprows=skiplines-1, usecols=usecols, encoding='ISO-8859-1', sep="\t", header=0)
    
#     #add the other values to the dataframe
#     df["Barcode"] = barcode
#     df["Date"] = date_meas
#     df["State"] = state
#     df["Channel"] = channel
#     print(f"importing cell {barcode} at stage {state}")
#     return df

# #use your path to SP
# vmp_path = r"C:\Users\EugenioCalandrini\Basquevolt S.A\Basquevolt R&D - Lab raw data\VMP300\Quality checks\1Ah\BSQV CELLS"

# #find all the mpt files
# MPTfile_list = glob.glob(vmp_path+"\*.mpt")

# for file in MPTfile_list[10:11]:    
#     df = MPTfile_read(file)
# print(df)


# folder = r"C:\Users\EugenioCalandrini\OneDrive - Basquevolt S.A\Documents\Lavoro\Results\vmp_files\\"
# bqv_cell_file = "bqv_vmp_files.txt"
# cic_cell_file = "cic_vmp_files.txt"

# # Initialize an empty list to store file names
# cic_files = []

# # Open and read the file
# with open(folder+cic_cell_file, 'r') as file:
#     # Read all lines from the file and strip newline characters
#     cic_files = [line.strip() for line in file.readlines() if line.strip().endswith('.mpr')]
    
# bqv_files = []

# # Open and read the file
# with open(folder+bqv_cell_file, 'r') as file:
#     # Read all lines from the file and strip newline characters
#     bqv_files = [line.strip() for line in file.readlines() if line.strip().endswith('.mpr')]

    
# test_filename = "AFM-1003ñ-BQV000000000000316ñ-1_C05.mpr"
# filename_split_bqv(test_filename)

    
# for file in bqv_files:
#     filename_split_bqv(file)
    
# for file in cic_files:
#     filename_split_cic(file)
