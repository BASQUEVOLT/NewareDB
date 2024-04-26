# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 12:58:01 2024

@author: EugenioCalandrini
"""

import pandas as pd
import glob

vmp_path = r"C:\Users\EugenioCalandrini\Basquevolt S.A\Basquevolt R&D - Lab raw data\VMP300\Quality checks\1Ah\BSQV CELLS"

file_list = glob.glob(vmp_path+"\*.mpt")
  
for file in file_list[10:11]:    
    state = file.split('\\')[-1].split("-")[0].split("_")[0]
    barcode = file.split('\\')[-1][4:-3].split("_C")[0].split("_D")[0]
    with open(file, 'r') as f:
            lines = f.readlines()
            skiplines = int(lines[1].split(" : ")[1].strip())
            
            for line in lines:
                if "Acquisition started on" in line:
                    date_meas = line.split(" : ")[1].strip()
                if "Run on channel" in line:
                    channel = int(line.split(" : ")[1].strip()[:2])
    print(state, barcode, date_meas, channel)

    df = pd.read_csv(file, skiprows=skiplines-1, usecols=['freq/Hz', 'Re(Z)/Ohm', '-Im(Z)/Ohm'], encoding='ISO-8859-1', sep="\t", header=0)
    df["Barcode"] = barcode
    df["Date"] = date_meas
    df["State"] = state
    df["Channel"] = channel