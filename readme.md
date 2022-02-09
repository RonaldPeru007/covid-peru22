# COVID-19 Perú 2022

Esta es una 'forked branch' de [@grossir](https://github.com/grossir/covid-peru) que usé como punto de comienzo para actualizar el código y también creé un script bash que descarga todos los archivos de datos de diferentes fuentes desde los [Datos Abiertos Gobierno de Perú](https://datosabiertos.gob.pe/). El script get-data-minsa.bash es fácil de usar y produce un set de datos con las fechas en los nombres de los archivos. También tiene una opción para comprimir todos los archivos para almacenarlos y analizarlos en el futuro cuando le interese analizar un set de datos específico publicado en una fecha concreta.

De momento el codigo es un mix de Español y Ingles. Nuestro objetivo es hacerlo bilingual.

Análisis y gráficos sobre el COVID en Perú pueden encontrar la publicación y discusiones en el Twitter del programador inicial : [Twitter](https://twitter.com/gjrossir)

## English

This is a forked branch from [@grossir](https://github.com/grossir/covid-peru) which I used as a starting point to update the code and I also built a bash script which downloads all data archives from different sources from the [Datos Abiertos Gobierno de Peru](https://datosabiertos.gob.pe/). The get-data-minsa.bash script is easy to use and produces a data set with the dates in the filenames. It also has an option to compress all archives for storage and future analysis when you are interested in a specific dataset published on a specific date.

Currently it's a mix of English & Spanish. Our goal is to make it duolingual. 

## Code Languanges

The .Rmd files are developed in [R version 4.1.2](https://www.r-project.org/) with [RStudio Desktop version 2021.09.2 Build 382](https://www.rstudio.com/products/rstudio/) 

## Productos / Products :

[Gráfico borrado por el Minsa: Visualización de fallecidos por Covid según estado de vacunación](https://datawrapper.dwcdn.net/DSWWL/2/)

[Graph deleted by the Ministry of Health Peru : Visualization of proportional Deaths by Covid according to vaccine status, grouped per week](https://datawrapper.dwcdn.net/DSWWL/2/)

![](https://github.com/RonaldPeru007/covid-peru22/blob/master/Examples/proporcion-de-fallecidos-con-sin-vacunas-desde-09-02-2021-actualizado-05-02-2022-.png)

[Muertes toda causa / Muertes por COVID-19 segun grupo de edad por año](https://datawrapper.dwcdn.net/AErIY/1/)

[Graph with all deaths / year vs COVID deaths / year by group of age](https://datawrapper.dwcdn.net/AErIY/1/)

![](https://github.com/RonaldPeru007/covid-peru22/blob/master/Examples/muertes-toda-causa-muertes-por-covid-19-segun-grupo-de-edad-por-a-o-actualizado-05-02-2022.png)

En breve publicamos mas graficos

Shortly we will publish more graphs

# Datos - The Data Set used

El script bash descarga todos los archivos de datos (.csv) utilizados por los ficheros fuente de este repositorio. Y también hace algunas modificaciones en los archivos. Observa los comentarios en el script.

The bash script downloads all the data archives (.csv) used by the source files in this repository. And also makes some changes to the files. See the comments in the script.

# Colaboración - Collaboration 

Les invitamos a colaborar con nosotros y analizar los datos para (re)construir los gráficos que nos dicen la verdad sobre lo que está sucediendo en el Perú. 

We invite you to collaborate with us and analyze the data to (re)construct the graphs that tell us the truth about what is happening in Peru. 
