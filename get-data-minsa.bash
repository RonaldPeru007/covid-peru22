#!/bin/bash
#/usr/local/bin/get-data-minsa.bash
#
# Version 1.0 06-02-2022
#
# Script to download archives from MINSA SINADEF INS - Datos Abiertos PERU
# Get all interesting .csv archives and optionally combine them all in a .tar.gz
# 
# Usage : get-data-minsa.bash <base-directory> [ -c ]
#
# Where : <base-directory> is the directory from where the subdirectories by date are being created with all the .csv files
#
# 	      -c             - compress all .csv files into a .tar.gz and delete all .csv to save space 
#
# Using the -c option comes in handy when you run this on a VPS in a cloud and store only the .tar.gz.
# Then you can pull it from the VPS , currently 2.4 GB compressed, 11 GB uncompressed.
#	
#	example :
#
#	get-data-minsa.bash /home/user/claudia -c 
#
# The URL's and names of the archives used in this script can change, even the columnames !		
# If they change some of the columnnames of the .csv archives,
# in this script you can easy use the sed command to replace the columnnames of an archive
# to maintain compatibility in the .Rmd files.
# As they changed/switched id_persona with UUID in several datafiles more than once.
# 
# 

Year=`date +%Y`
Month=`date +%m`
Day=`date +%d`
Date=$Year$Month$Day
FileDate=${Year}_${Month}_${Day}_

usage()
{
   # Display Help
   echo
   echo "Syntax: get-data-minsa.bash <base-directory> [-c]"
   echo 
   echo "<base-directory> = base directory from where subdir by date are created."
   echo "-c	= compress all .csv to a daily YYYY_MM_DD_.tar.gz and then delete the related .csv files "
   echo 
   echo "Example : get-data-minsa.bash /home/$USER -c"
} 

if [ "$1" == "" ]; then
	usage
	exit 1
fi

if [ "$2" == "-c" ]; then
	compress=1
elif
   [ "$2" == "" ]; then
	compress=0
else
   echo "Unkown parameter : $2"
   usage
   exit 1
fi

# Check if $basedir exists and if subdirectory $Date already exists

basedir=$1
cd /
if [ -d $basedir ]
	then
	echo "Entering $basedir "
	cd /$basedir
     else
        echo "Directory $basedir does not exist!"
	exit 1
fi	
	
# Timestamp logfile

echo "starttime = $(date +%Y-%m-%d_%H:%M:%S)" >> $basedir/get-data-minsa.log

if [ -d "$Date" ]
then
echo "Directory $Date already exist"
else
`mkdir $Date`
echo "Directory $Date created"
fi
echo 
echo "Entering directory $Date for storing archives"
echo 
cd $Date

# Source DataSet de Información de Fallecidos del Sistema Nacional de Defunciones - [Ministerio de Salud] - WITHOUT ID_PERSONA
# URL : https://www.datosabiertos.gob.pe/dataset/informaci%C3%B3n-de-fallecidos-del-sistema-nacional-de-defunciones-ministerio-de-salud/resource
# Archive name : fallecidos_sinadef.csv from URL : https://www.datosabiertos.gob.pe/node/6450/download
# Archive name : fallecidos_sinadef.csv from https://cloud.minsa.gob.pe/s/nqF2irNbFomCLaa/download

fallecidos_sinadef=${FileDate}fallecidos_sinadef.csv 
wget --show-progress -O $fallecidos_sinadef https://cloud.minsa.gob.pe/s/nqF2irNbFomCLaa/download

# Source SINADEF: Certificado Defunciones - WITH ID_PERSONA
# URL : https://www.datosabiertos.gob.pe/dataset/sinadef-certificado-defunciones
# Archive name : TB_SINADEF.7z from URL : https://cloud.minsa.gob.pe/s/g9KdDRtek42X3pg/download
# Archive name decompressed : TB_SINADEF.csv

tb_sinadef=${FileDate}TB_SINADEF.7z
tb_sinadef_csv=${FileDate}TB_SINADEF.csv
wget --show-progress -O $tb_sinadef https://cloud.minsa.gob.pe/s/g9KdDRtek42X3pg/download

# Decompress and rename with date as prefix

p7zip -d $tb_sinadef
mv ./TB_SINADEF.csv ./$tb_sinadef_csv

# Source DataSet de Fallecidos por COVID-19 - [Ministerio de Salud - MINSA]- Centro Nacional de Epidemiologia, prevención y Control de Enfermedades 
# Deaths caused by COVID, with field info from SINADEF Datasets
# URL : https://www.datosabiertos.gob.pe/dataset/fallecidos-por-covid-19-ministerio-de-salud-minsa/resource/4b7636f3-5f0c-4404-8526
# Archive name : fallecidos_covid.csv from URL : https://www.datosabiertos.gob.pe/node/6460/download
# Archive name : fallecidos_covid.csv from URL : https://cloud.minsa.gob.pe/s/xJ2LQ3QyRW38Pe5/download

fallecidos_covid=${FileDate}fallecidos_covid.csv
wget --show-progress -O $fallecidos_covid https://cloud.minsa.gob.pe/s/xJ2LQ3QyRW38Pe5/download

# Replace UUID with id_persona, if in the future field name changes just change UUID & id_persona

sed -i 's/UUID/id_persona/g' $fallecidos_covid   

# Source : Fallecidos, hospitalizados y vacunados por COVID-19 
# URL : https://www.datosabiertos.gob.pe/dataset/fallecidos-hospitalizados-y-vacunados-por-covid-19
# Archive name : TB_FALLECIDO_HOSP_VAC.csv from URL : https://www.datosabiertos.gob.pe/node/8426/download
# Archive name : TB_FALLECIDO_HOSP_VAC.csv from URL : https://cloud.minsa.gob.pe/s/8EsmTzyiqmaySxk/download

tb_fallecido_hosp_vac=${FileDate}TB_FALLECIDO_HOSP_VAC.csv
wget --show-progress -O $tb_fallecido_hosp_vac https://www.datosabiertos.gob.pe/node/8426/download

# Source Vacunación contra COVID - 19 [Ministerio de Salud - MINSA] Dataset 1
# URL : https://www.datosabiertos.gob.pe/dataset/vacunaci%C3%B3n-contra-covid-19-ministerio-de-salud-minsa
# Archive name : vacunas_covid.7z from URL : https://cloud.minsa.gob.pe/s/To2QtqoNjKqobfw/download

vacunas_covid=${FileDate}vacunas_covid.7z
vacunas_covid_csv=${FileDate}vacunas_covid.csv
wget --show-progress -O $vacunas_covid https://cloud.minsa.gob.pe/s/To2QtqoNjKqobfw/download

# Decompress and rename with date as prefix

p7zip -d $vacunas_covid
mv ./vacunas_covid.csv ./$vacunas_covid_csv

# Source Vacunación contra COVID - 19 [Ministerio de Salud - MINSA] Dataset 2 
# Contiene la lista de las personas vacunadas, según fecha, lugar, grupo de riesgo y dosis aplicadas contra la Covid19.
# URL : https://www.datosabiertos.gob.pe/dataset/vacunacion
# Archive name : TB_VACUNACION_COVID19.7z from URL : https://cloud.minsa.gob.pe/s/oHF5JSLEk8KzpPW/download

tb_vacunacion_covid19=${FileDate}TB_VACUNACION_COVID19.7z
tb_vacunacion_covid19_csv=${FileDate}TB_VACUNACION_COVID19.csv
wget --show-progress -O $tb_vacunacion_covid19 https://cloud.minsa.gob.pe/s/oHF5JSLEk8KzpPW/download

# Decompress and rename with date as prefix

p7zip -d $tb_vacunacion_covid19
mv ./TB_VACUNACION_COVID19.csv ./$tb_vacunacion_covid19_csv

# Rewriting data Vacunacion to vacunas_proyeccion.csv

vacunas_proyeccion=${FileDate}vacunas_proyeccion.csv
awk -F, '{print $2}' $vacunas_covid_csv > $vacunas_proyeccion

# Replace UUID with id_persona, if in the future field name changes just change UUID & id_persona

sed -i 's/UUID/id_persona/g' $vacunas_proyeccion

# Rewriting data Vacunacion to TB_vacunacion_proyeccion.csv"

tb_vacunas_proyeccion=${FileDate}TB_vacunas_proyeccion.csv
awk -F, '{print $1}' $tb_vacunacion_covid19_csv > $tb_vacunas_proyeccion

# Source : Casos positivos por COVID-19 - [Ministerio de Salud - MINSA] Get Pruebas Positivas - with ID_PERSONA
# Instituto Nacional de Salud y Centro Nacional de Epidemiologia, prevención y Control de Enfermedades – MINSA.
# URL : https://www.datosabiertos.gob.pe/dataset/casos-positivos-por-covid-19-ministerio-de-salud-minsa
# Archive name : positivos_covid.csv from URL : https://cloud.minsa.gob.pe/s/AC2adyLkHCKjmfm/download

positivos_covid=${FileDate}positivos_covid.csv
wget --show-progress -O $positivos_covid https://cloud.minsa.gob.pe/s/AC2adyLkHCKjmfm/download

# Source : Dataset de Pruebas Moleculares del Instituto Nacional de Salud para COVID-19 (INS)  
# URL : https://www.datosabiertos.gob.pe/dataset/dataset-de-pruebas-moleculares-del-instituto-nacional-de-salud-para-covid-19-ins
# Archive name : pm04feb2022.zip from URL : https://datos.ins.gob.pe/dataset/a219dc7b-bd79-4ba8-b4ce-65120ea3d461/resource/88d09b64-1e2c-48cf-9941-6017d6e7005e/download/pm04feb2022.zip

wget --show-progress --no-check-certificate -O pm04feb2022.zip https://datos.ins.gob.pe/dataset/a219dc7b-bd79-4ba8-b4ce-65120ea3d461/resource/88d09b64-1e2c-48cf-9941-6017d6e7005e/download/pm04feb2022.zip

# Decompress Pruebas PCR - INS and remove .zip file to save space

unzip pm04feb2022.zip
rm ./pm04feb2022.zip

# Get Hospitalizados, vacunados y fallecidos por COVID-19
# Esta tabla toma como referencia el universo de hospitalizados de la f500 
#(en base al último registro de la fecha de hospitalización), 
# vinculando información de dosis de vacunas y fallecimiento por COVID (obtenida por fallecimientos informados por el CDC).
# URL : https://www.datosabiertos.gob.pe/dataset/hospitalizados-vacunados-y-fallecidos-por-covid-19
# Archive name : TB_HOSP_VAC_FALLECIDOS.csv from URL : https://cloud.minsa.gob.pe/s/BosSrQ5wDf86xxg/download

tb_hosp_vac_fallecidos=${FileDate}TB_HOSP_VAC_FALLECIDOS.csv
wget --show-progress -O $tb_hosp_vac_fallecidos https://cloud.minsa.gob.pe/s/BosSrQ5wDf86xxg/download

# Source : Población INEI 2021 PERU 
# URL : https://www.datosabiertos.gob.pe/dataset/poblaci%C3%B3n-peru
# Archive name : TB_POBLACION_INEI.csv from URL : https://cloud.minsa.gob.pe/s/Jwck8Z59snYAK8S/download

tb_poblacion_inei=${FileDate}TB_POBLACION_INEI.csv
wget --show-progress -O $tb_poblacion_inei https://cloud.minsa.gob.pe/s/Jwck8Z59snYAK8S/download

# Check if we compress to .tar.gz & remove .csv in date subdir to save space 

if [ $compress == 1 ]; then
	output=datos_abiertos_${Date}.tar.gz
	echo "Creating .tar.gz file : $basedir/$Date/$output "
	tar -cvzf $output ./*.csv 
	echo "Deleting .csv to save disk space"
	rm ./*.csv
  else
	echo "Archives created in : $basedir/$Date"
	echo "`ls -al`"
fi

# stamp logfile

echo "DONE....!"
echo "stoptime =  $(date +%Y-%m-%d_%H:%M:%S)" >> $basedir/get-data-minsa.log

