
remove(list=ls())
setwd("c:/Users/Maggie/Desktop/Agrianalysis/PLIMAN")
devtools::install_github("TiagoOlivoto/pliman", build_vignettes = TRUE)
getwd()
library(raster)
library(pliman)

#Carregamento de Imagem e 

leaves <-image_import("leaves.jpg")
image_index(leaves)

leaves_meas <- 
  analyze_objects(leaves,
                  show_lw = TRUE,
                  index="NB")

plot_measures(leaves_meas,
              measure="width",
              col="green",
              hjust=-90)

plot_measures(leaves_meas,
              measure="length",
              vjust=60,
              col="red")


###########   Medidas de acordo com parâmetro de comparação    ############            

seg<-
  image_segment_iter(leaves,
                     index=c("R/G/B","B-R")) # muda as cores 
leaves_meas_cor<-
  analyze_objects(leaves,
                  reference=TRUE,
                  reference_area=2.25)   #Objeto Referencia (quadrado)=2.25cm quadrados

image_view(leaves, object = leaves_meas_cor)


###### Notas para analisar tamanho da imagem

dimensoes<-dim(leaves)
print(dimensoes)
# 879 941   3  (altura/largura/canal)

#Pegar a medida da imagem em ou centímetros)
#Neste caso as dimensões da imagem são: Altura=5,7 pol x Largura=3,9 polegadas
#Area=AlturaxLargura
#De polegadas para centímetros se multiplica por 2.54

Altura=5.7*2.54     # 14.478
Largura=3.9*2.54    #  9.906
TamanhoImg=Altura*Largura # 143.419 cm

                     
                       
                       
                       