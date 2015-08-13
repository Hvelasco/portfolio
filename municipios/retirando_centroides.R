setwd("D:/work/porfolio/")
library(rgeos)
library(maptools)
library(ks)
teste <- readShapeSpatial("estados/estados_2010")
teste2 <- readShapeSpatial("municipios/municipios_2010")
centroides <- matrix(NA, nrow = 1, ncol = 2)
for (i in 1:dim(teste2)[1]) {
  centroides <- rbind(centroides, teste2@polygons[[i]]@labpt)  
}
centroides <- centroides[-1,]
dados <- as.data.frame(cbind(centroides, pib = teste2@data$pib))
teste <- loess(pib ~ lon + lat, dados)
teste2@data$pib2 <- teste$fitted
plot(teste2, col = color.scale(teste2@data$pib2))
