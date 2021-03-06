# -*- coding: utf-8 -*-

#Author: jpDarela

## python 2.7.3 in windows 6.3.9600
## require arcpy - ArcGIS 10.2.0.3348

# This ArcGIS script reprojects and crops original MODIS.
# HDF_EOS () files for some area (mask data) in the image. 
 
# REPROJECTION: from original (sinusoidal) for UTM_WGS84 24S 
# CROP: a raster mask is provided in this repo. It is a GRID file named mask_data  
# MODIS DATA: https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod11a2
 
import arcpy
import os

# Check out any necessary licenses
arcpy.CheckOutExtension("spatial")


# 'parent_dir' is the pathway for the folder containing raw HDF_EOS (MOD11A2 product) files
parent_dir = "your_pathway\\to_the\\folder\\with\\modis\\data " # Note the "\\".

#'path2mask' is is the pathway for the mask data (shapefile or raster)
# I provided a mask for Kaparao National Park in MODIS_CLIMATOLOGIES repo. 
path2mask = "your_path_to_mask\\mask_data" # Note the "\\" 
mask_data = arcpy.Raster(path2mask)

arcpy.env.workspace = parent_dir
os.chdir(parent_dir)

os.mkdir(hdf2raster)
os.mkdir(parent_dir + '\\pro_data')
os.mkdir(parent_dir + '\\final')
hdf2raster = parent_dir + '\\hdf2raster'
prodata = parent_dir + "\\pro_data"
final = parent_dir + '\\final'

lista = arcpy.ListDatasets()
hdf_files = [x for x in lista if '.hdf' in x]

fn_vars = ['a14', 'da', 'ni']
for img in hdf_files:
    day = str(img.split('.')[1][5:])
    for index in ['0', '4']:
        outname = hdf2raster + '\\' + fn_vars[0] + day + 'lst' + '_'
        if index == '0':
            outname += 'da'
        else:
            outname += 'ni'
        print img
        print outname , '-----', index
        arcpy.ExtractSubDataset_management(img, outname, index)

arcpy.env.workspace = hdf2raster
os.chdir(hdf2raster)

# poject
lista = arcpy.ListDatasets()
for img in lista:
    raster_file = arcpy.Raster(img)
    print 
    outname = prodata + '\\' + raster_file.name
    print outname
    arcpy.ProjectRaster_management(raster_file, outname, 
                               "PROJCS['WGS_1984_UTM_zone_24S',GEOGCS['GCS_WGS_1984',DATUM['D_WGS_1984',SPHEROID['WGS_1984',6378137.0,298.257223563]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]],PROJECTION['Transverse_Mercator'],PARAMETER['false_easting',500000.0],PARAMETER['false_northing',10000000.0],PARAMETER['central_meridian',-39.0],PARAMETER['scale_factor',0.9996],PARAMETER['latitude_of_origin',0.0],UNIT['Meter',1.0]]", "NEAREST", "926.625433138333", "", "", "PROJCS['Unknown_datum_based_upon_the_custom_spheroid_Sinusoidal',GEOGCS['GCS_Unknown_datum_based_upon_the_custom_spheroid',DATUM['D_Not_specified_based_on_custom_spheroid',SPHEROID['Custom_spheroid',6371007.181,0.0]],PRIMEM['Greenwich',0.0],UNIT['Degree',0.0174532925199433]],PROJECTION['Sinusoidal'],PARAMETER['false_easting',0.0],PARAMETER['false_northing',0.0],PARAMETER['central_meridian',0.0],UNIT['Meter',1.0]]")

#extract
arcpy.env.workspace = prodata
os.chdir(prodata) 

lista = arcpy.ListDatasets()

for img in lista:
    raster_file = arcpy.Raster(img)
    output = final + '\\' + raster_file.name
    print output
    arcpy.gp.ExtractByMask_sa(raster_file, mask_data, output)

