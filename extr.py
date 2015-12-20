# -*- coding: utf-8 -*-

import os
import arcpy
import time

arcpy.env.workspace = "C:\\Estagio\\raw_data"
os.chdir("C:\\Estagio\\raw_data")
#os.mkdir("C:\\Estagio\\raw_data\\GRID_DATA")

path = "C:\\Estagio\\raw_data\\GRID_DATA"

# Check out any necessary licenses
arcpy.CheckOutExtension("spatial")

lista = arcpy.ListRasters()

# Local variables:

maskRaster = arcpy.Raster("MOD11A2.MRTWEB.A2000065.005.LST_Day_1km.tif")

# Process: Extract by Mask

print 'iniciando processamento: ', time.ctime()
for raster in lista:
    ## vars_int
    x = arcpy.Raster(raster)
    saida = path + '\\' + 'a' + (x.name[18:23] + x.name[28:34])
    arcpy.gp.ExtractByMask_sa(x, maskRaster, saida)
    #print saida
 
print 'fim do processamento: ', time.ctime()   


###converter to npy/npd?? para acelerar o calc...
