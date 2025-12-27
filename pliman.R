remove(list=ls())

setwd("c:/Users/Maggie/Desktop/Agrianalysis/PLIMAN")

pak::pkg_install("TiagoOlivoto/pliman") # Ortomosaicos


library(pliman)


#####################  EXEMPLO 1: 1 Bloco para ser analisado  ####################

pot<-mosaic_input("potato.tif")# CARREGA IMAGEM
mosaic_view(pot)

res_pot<-mosaic_analyze(pot,
                        r=1,g=2,b=3,
                        nrow=3,
                        ncol=1,
                        buffer_row = -0.15, #  15% não é considerado entre filas
                        buffer_col = -0.05, #  5% não é considerado entre colunas
                        plot_index = c("GLI","NGRDI","VARI","BGI"),
                        summarize_fun = c("mean","stdev"),
                        plot=FALSE)

mosaic_view(pot,
            r=1,g=2,b=3,
            shapefile = res_pot$result_plot,
            attribute = "mean.NGRDI")


# Shapefile usado para a análise
shp<-res_pot$shapefile[[1]]|>shapefile_input()
shapefile_plot(shp)


# modelo digital de superfície --- 1A - Altura de Planta

dsm0<-mosaic_input("dsm_0.tif")    # mosaico que representa um campo sem plantas
mosaic_view(dsm0)
dsm70<-mosaic_input("dsm_70.tif")  # mosaico que representa um campo com plantas 70 dias depois
mosaic_view(dsm70)
dsm0<-mosaic_resample(dsm0,dsm70)
dsm<-dsm70-dsm0
names(dsm)<-"ph"

ph<-mosaic_analyze(dsm,
                   segment_plot = TRUE,
                   segment_index = "ph",
                   shapefile = shp,
                   plot=FALSE)

mosaic_view(dsm,
            shapefile=ph$result_plot,
            attribute="coverage")


######################EXEMPLO 2: # Blocos com diferentes filas e colunas ################

mosaic<-mosaic_input("trigo_ex.tif") # CARREGA IMAGEM
mosaic_view(mosaic)
an<-mosaic_analyze(mosaic,        
                   nrow=c(5,3),
                   ncol=c(21,20),
                   buffer_col = c(-0.1,-0.2),   # entre 10% e 20% é removido entre colunas
                   buffer_row = c(-0.02,0),     # entre 0% e 2% é removido entre filas
                   attribute="mean.NDVI",
                   summarize_fun = c("mean","stdev"),
                   check_shapefile = TRUE)           

an$map_plot   # plot level analysis
############################

mosaic<-mosaic_input("tomate2.tif") # CARREGA IMAGEM
mosaic_view(mosaic)
an<-mosaic_analyze(mosaic,        
                   nrow=3,
                   ncol=2,
                   buffer_col = -0.03,  
                   buffer_row = -0.05,  
                   plot_index = c("GLI","NGRDI","VARI","BGI"),
                   summarize_fun = c("mean","stdev"),
                   plot=FALSE)

mosaic_view(mosaic,
            r=1,g=2,b=3,
            shapefile = an$result_plot,
            attribute = "mean.NGRDI")


#### Quantidade de Plantas

mosaic<-mosaic_input("tomate2.tif")
mosaic_view(mosaic)

an3<-mosaic_analyze(mosaic,
                    nrow=4,
                    ncol=1,
                    buffer_col = -0.03,
                    buffer_row = -0.01,
                    segment_individuals = TRUE,
                    segment_index = "NGRDI",
                    map_individuals = TRUE)

an3$map_indiv

an3$map_plot


######################EXEMPLO 3: # Mensuração de Plantas ###############################

mos<-mosaic_input("standcount.tif")
mosaic_view(mos)

an2<-mosaic_analyze(mos,
                   ncol=7,
                   nrow=1,
                   segment_individuals = TRUE,
                   segment_index = "NGRDI",
                   map_individuals = TRUE)

an2$map_indiv

an2$map_plot
