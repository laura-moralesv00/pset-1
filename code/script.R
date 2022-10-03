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

ocu$ocupado <- "1" # crear variable constante (1) en ocu.
cg$joven <- ifelse(cg$p6040>=18 & cg$p6040<=28, yes=1, no=0) # crear variable con un 1 para las personas entre 18 y 28 años.

## 4. Eliminar filas/columnas de un conjunto de datos

cg <- cg[cg$p6040 >= 18 & cg$p6040 <= 70,] # modificar el df para guardar solo las edades entre 18 y 70.
cg %>% select(secuencia_p, orden, hogar, directorio, p6020, p6040, p6269, dpto, fex_c_2011, esc, mes) # seleccionar variables por nombre, la variable p6920 no existe en esta base de datos.
ocu %>% select(secuencia_p, orden, hogar, directorio, ocupado, inglabo) # la variable p6050 no existe en la base de datos.


## 5. Combinar bases de datos

cg_ocu = left_join(x=cg, y=ocu, by=c("directorio", "secuencia_p", "orden"))


## 6. Descriptivas de un conjunto de datos

# tablas

summary(cg_ocu[,c("p6960", "inglabo")]) # años cotizados a fondos de pensiones e ingresos laborales.
select(cg_ocu, c("p760")) %>%  summarize_all(list(min, max, median, mean), na.rm = T) # meses sin empleo o trabajo entre el trabajo actual y el anterior
select(cg_ocu, c("p6800", "p6850")) %>%  summarize_all(list(min, max, median, mean), na.rm = T) # horas trabajadas por trabajadores independientes normalmente y horas trabajadas en la última semana.

# gráficas

grafica_1 <- ggplot(data = cg_ocu , mapping = aes(x = p6040 , y = p760)) +
  geom_point(col = "blue" , size = 0.5) # edad y meses sin empleo o trabajo entre el trabajo actual y el anterior
grafica_1

grafica_2 <- anos_cotizados <- cg_ocu %>% 
  group_by(p6020) %>% 
  summarise(anos_cotizados = mean(p6960, na.rm = T)) %>% 
  ggplot(data=. , mapping = aes(x = as.factor(p6020) , y = anos_cotizados, fill = as.factor(p6020))) + 
  geom_bar(stat = "identity") 
grafica_2

grafica_3 <- ingresos_laborales <- cg_ocu %>% 
  group_by(p6020) %>% 
  summarise(ingresos_laborales = mean(inglabo, na.rm = T)) %>% 
  ggplot(data=. , mapping = aes(x = as.factor(p6020) , y = ingresos_laborales, fill = as.factor(p6020))) + 
  geom_bar(stat = "identity") 
grafica_3

