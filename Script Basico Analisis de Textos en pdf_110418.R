##Script básico para análisis de textos en archivos pdf

##Si no se tienen los siguientes paquetes, deben instalarse quitando el signo #
#install.packages("pdftools")
#install.packages("qdap")
#install.packages("tm")
#install.packages("rJava")
#install.packages("tidyverse")
#install.packages("stringr")
#install.packages("tidytext")
#install.packages("stringi")
#install.packages("wordcloud")

library(rJava)
library(tm)
library(qdap)
library(tidyverse)
library(pdftools)		#Función pdf_text
library(stringr)
library(tidytext)
library(stringi)
library(wordcloud)

##Lista de palabras frecuentes
stop_es <- c("palabra1", "palabra2", "palabraN", stopwords("es"))	#Agregar palabras a la lista de stopwords
#stopwords("es") es el diccionario de palabras frecuentes en español que se carga por default

##Limpieza y tratamiento básico de un pdf
archivo <- pdf_text("Ruta/archivo.pdf") %>%
strsplit(split = "\n") %>% 			#Separa el texto por líneas
tolower() %>%					#Convierte el texto en minúsculas
stri_trans_general("Latin-ASCII")%>%	#Elimina acentos
removeWords(stop_es)%>%				#Palabras por default más palabras seleccionadas
removePunctuation(ucp=TRUE)			#ucp=TRUE para eliminar puntos en caracteres ASCII


##CORPUS
corpus_text <- Corpus(VectorSource(archivo))
#Se crea un Corpus para conjuntar todo el texto


##EXPLORACIÓN INICIAL
##Palabras con mayor número de ocurrencias
ft <- freq_terms(corpus_text, n, stopwords= stop_es)	
ft
##n indica el número de palabras frecuentes a desplegar
##stopwords=stop_es indica que la salida omitirá, además de las palabras frecuentes por default,
##aquellas que nosotros mismos especificamos
plot(ft)	#Genera un gráfico de barras para los términos frecuentes


##Nube de palabras
wordcloud(words = ft$WORD, freq = ft$FREQ, min.freq = 30,
          max.words=35, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(10, "Dark2"))

##Para elegir entre paletas de colores, se puede utilizar display.brewer.all()


###Plots de correlación de palabras clave
##
cor_plot <- apply_as_df(corpus_text, word_cor, word = "palabra_clave", r=)
#El comando anterior sirve para obtener una lista de palabras asociadas a una palabra clave
#Se indica la función word_cor para la correlación
#r debe ser un valor entre 0 y 1
sort(cor_plot$palabra_clave, decreasing=T)	#Lista de palabras por orden de asociación de mayor a menor
plot(edu_plot)	#Plot

