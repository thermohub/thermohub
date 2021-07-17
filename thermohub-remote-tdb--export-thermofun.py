# -*- coding: utf-8 -*-
import thermohubclient as client
dbc = client.DatabaseClient()
datasets = dbc.availableThermoDataSets()
#print(datasets)

for d in datasets:
    print(d)
    dbc.saveDatabase(d[1:-1])