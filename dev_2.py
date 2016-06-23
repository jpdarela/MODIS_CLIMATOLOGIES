import os
import arcpy


def dec_to_bin(x):
    return int(bin(x)[2:])


def bit_info(x):
    pass


def get_layer(x):
    pass

parent_dir = r"C:\Users\JoãoPaulo\Documents\Revolution"
output_dir = r"C:\Users\JoãoPaulo\Documents\Revolution\lst_qc"

arcpy.env.workspace = parent_dir
os.chdir(parent_dir)
lista = arcpy.ListDatasets()
#os.system('mkdir lst_qc')


hdf_files = [x for x in lista if '.hdf' in x]

for img in hdf_files:
    cur_filename = img[0:42]
    day = str(img.split('.')[1][5:])
    for index in ['0', '1', '4', '5']:
        print cur_filename
        outname = output_dir + cur_filename +  day + '_'
        if index == '0':
            outname += r'\da.bmp'
        elif index == '1':
            outname += r'\qc_day.bmp'
        elif index == '4':
            outname += r'\ni.bmp'
        else:
            outname += r'\qc_ni.bmp'

        print img
        print outname , '-----', index
        #curlayer = arcpy.ExtractSubDataset_management(img, outname, index)

