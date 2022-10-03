##### Laura Morales Vernaza - 201821520 PROBLEM SET 1 #####

## instalar/llamar pacman
require(pacman)

## usar la función p_load de pacman para instalar/llamar las librerías tidyverse y rio
p_load(tidyverse,
       rio,
       janitor)

## 1. VECTORES

a <- c(1:100) # crear un vector que contenga los números del 1 al 100.
b <- seq(1, 100, by=2) # crear un vector que contenga los números impares del 1 al 100.
c <- a[a !=b] # usar el vector b para extaer los valores que no tiene en común con a y crear el vector c.


## 2. Importar/exportar bases de datos
# 2.1 Importar

cg <- import("input/Enero - Cabecera - Caracteristicas generales (Personas).csv")%>%
  clean_names() # importar el archivo de características generales
ocu <- import("input/Enero - Cabecera - Ocupados.csv")%>%
  clean_names() # importar el archivo de ocupados.

# 2.2 exportar

export(cg,"output/Características generales (Personas).rds") #exportar a carpeta de output
export(ocu, "output/Ocupados.rds")

## 3. Generar variables




