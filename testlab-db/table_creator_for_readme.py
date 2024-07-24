# -*- coding: utf-8 -*-
"""
Created on Wed Jul 24 15:09:48 2024

@author: EugenioCalandrini
"""

import pandas as pd
import re

file_path = r"../README.md"
df = pd.read_excel('neware_database_master2.xlsx', sheet_name='Sheet2')
new_text = df.to_markdown()+ '\n\n\n'

# Read the content of the file
with open(file_path, 'r', encoding='utf-8') as file:
    content = file.read()

# Print the original content for debugging
print("Original Content:\n", content)

# Function to perform the text editing
def edit_content(content, new_text):
    # Allow for optional spaces after '##' in the headers
    pattern = r'(##\s*List of variables and types)(.*?)(##\s*Folder testlab-db)'
    
    # Debug: Print the section to be replaced
    match = re.search(pattern, content, flags=re.DOTALL)
    if match:
        print("Matched Section:\n", match.group(2))
    else:
        print("No match found for the section to replace.")

    # Remove all text between '## List of variables and types' and '## Folder testlab-db'
    # and replace it with new_text
    content = re.sub(pattern, r'\1\n' + new_text + r'\n\3', content, flags=re.DOTALL)
    
    return content

# Edit the content
edited_content = edit_content(content, new_text)

# Print the edited content for debugging
print("Edited Content:\n", edited_content)

# Write the modified content back to the file
with open(file_path, 'w', encoding='utf-8') as file:
    file.write(edited_content)

