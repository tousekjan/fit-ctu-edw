import pandas as pd
import numpy as np
import math

def isNaN(num):
    return num != num

def getDataTypes(filename, columnNames = None):
    df = pd.read_csv(filename)
    if columnNames is not None:
        df.columns = columnNames

    dataTypeDict = dict(df.dtypes)

    print('\n' + filename + '\n')

    for column in dataTypeDict:
        values = df[column]
        maxLength = 0
        nullable = False
        for value in values:
            if not value or isNaN(value):
                nullable = True
                continue
            length = len(str(value))
            if dataTypeDict[column] == object and length > maxLength:
                maxLength = length
        res = ''
        if dataTypeDict[column] == object:
            res += 'varchar(' + str(maxLength) + ')'
        else:
            res += str(dataTypeDict[column])
        if nullable == True:
            res += ' NULL'
        print(column + ': ' + res)



getDataTypes('data\\airports\\countries_20190227.csv')


columnNamesAirline = ['id', 'name', 'alternative_name', 'IATA', 'ICAO', 'callsign', 'country', 'active']
getDataTypes('data\\airports\\airlines_20190227.dat', columnNamesAirline)


columnNamesAirport = ['Id', 'name', 'city', 'country', 'IATA', 'ICAO', 
'latitude', 'longtitude', 'altitude', 'timezone', 'DST', 'Tz database time zone', 'type', 'source']
getDataTypes('data\\airports\\airports_20190227.dat', columnNamesAirport)


columnNamesPlane = ['name', 'IATA', 'ICAO']
getDataTypes('data\\airports\\planes_20180123.dat', columnNamesPlane)


getDataTypes('data\\airports\\regions_20190227.csv')


columnNamesRoute = ['airline_code', 'airline_id', 'source_airport_code', 
'source_airport_id', 'destination_airport_code', 'destination_airport_id', 'codeshare', 'number_of_stops', 'equipment']
getDataTypes('data\\airports\\routes_20190227.dat', columnNamesRoute)


getDataTypes('data\\airports\\airport-frequencies_20190227.csv')


getDataTypes('data\\airports\\runways_20190227.csv')


getDataTypes('data\\airports\\navaids_20190227.csv')