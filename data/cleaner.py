'''
import pandas as pd
import numpy as np

# 2015 is the last available year right now
years = range(2007, 2015)
pieces = []
columns = ['FilerName', 'Year', 'Cycle', 'DocType', 'EntityName', 'EntityAddressLine1', 'EntityAddressLine2',
           'EntityCity', 'EntityState', 'EntityZip', 'Occupation', 'EmployerName', 'EmployerAddressLine1',
           'EmployerAddressLine2', 'EmployerCity', 'EmployerState', 'EmployerZip', 'Date', 'Amount', 'Description',
           'Amended', 'SubDate', 'FiledBy']
for year in years:
    path = 'data_set/%dytd.csv' % year
    frame = pd.read_csv(path, names=columns, low_memory=False)
    frame['year'] = year
    pieces.append(frame)

# Concatenate everything into a single DataFrame
campaigns = pd.concat(pieces, ignore_index=True)

#group = campaigns.groupby(['year', 'EmployerName'])

# Aggregate data by the amount
#total_amount = grouped.aggregate(np.sum)


def get_top100(group):
    return group.sort_index(by='Amount', ascending=False)[:100]


def group_top100():
    grouped = campaigns.groupby(['year', 'EmployerName'])
    top100 = grouped.apply(get_top100)
    return top100

#
# and employer name

#total_amount = pd.pivot_table(campaigns, values='Amount', index='year', columns='EmployerName', aggfunc=sum)

#total_amount.tail()
#total_amount.plot(title='Total contribution by employer and year')

#print campaigns
'''