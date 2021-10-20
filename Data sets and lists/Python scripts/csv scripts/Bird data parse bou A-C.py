import pandas as pd
f=pd.read_csv("app/Data sets and lists/Python scripts/csv scripts/bou.csv")
keep_col = ['British name', 'Scientific name', 'Thumbnail', 'Images', 'Description']
new_f = f[keep_col]
new_f.to_csv('app/Data sets and lists/Python scripts/csv scripts/Birds A-C Parsed.csv', index=False)