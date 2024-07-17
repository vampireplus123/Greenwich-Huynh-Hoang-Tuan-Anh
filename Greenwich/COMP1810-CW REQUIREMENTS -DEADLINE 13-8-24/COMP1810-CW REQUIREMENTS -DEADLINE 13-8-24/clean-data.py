import pandas as pd

# Load your data from the Excel file (replace with your actual file path and sheet name)
file_path = 'e-shop clothing 2008 raw.xlsx'
sheet_name = 'e-shop clothing 2008'
df = pd.read_excel(file_path, sheet_name=sheet_name, header=None)

# Split the entire row into separate columns
df_split = df[0].str.split(';', expand=True)

# Convert all columns to numeric, setting errors='coerce' to handle non-numeric data
df_split = df_split.apply(pd.to_numeric, errors='coerce')

# Create a new Excel writer
output_file = 'CleanedData.xlsx'
with pd.ExcelWriter(output_file) as writer:
    # Write the cleaned data to a new sheet
    df_split.to_excel(writer, sheet_name='CleanedData', index=False)

print(f"Cleaned data exported to '{output_file}' in the 'CleanedData' sheet.")
