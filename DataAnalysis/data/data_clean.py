import pandas as pd

campaign2015 = pd.read_csv('2015ytd', values=('FilerName', 'Year', 'Cycle',	'DocType', 'EntityName',
                                              'EntityAddressLine1', 'EntityAddressLine2',
                                              'EntityCity', 'EntityState', 'EntityZip', 'Occupation', 'EmployerName',
                                              'EmployerAddressLine1', 'EmployerAddressLine2', 'EmployerCity',
                                              'EmployerState', 'EmployerZip', 'Date', 'Amount', 'Description',
                                              'Amended', 'SubDate', 'FiledBy'))