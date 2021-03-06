##Script b�sico para an�lisis de textos en archivos pdf

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
library(pdftools)		#Funci�n pdf_text
library(stringr)
library(tidytext)
library(stringi)
library(wordcloud)

##Lista de palabras frecuentes
stop_es <- c("palabra1", "palabra2", "palabraN", stopwords("es"))	#Agregar palabras a la lista de stopwords
#stopwords("es") es el diccionario de palabras frecuentes en espa�ol que se carga por default

##Limpieza y tratamiento b�sico de un pdf
archivo <- pdf_text("Ruta/archivo.pdf") %>%
strsplit(split = "\n") %>% 			#Separa el texto por l�neas
tolower() %>%					#Convierte el texto en min�sculas
stri_trans_general("Latin-ASCII")%>%	#Elimina acentos
removeWords(stop_es)%>%				#Palabras por default m�s palabras seleccionadas
removePunctuation(ucp=TRUE)			#ucp=TRUE para eliminar puntos en caracteres ASCII


##CORPUS
corpus_text <- Corpus(VectorSource(archivo))
#Se crea un Corpus para conjuntar todo el texto


##EXPLORACI�N INICIAL
##Palabras con mayor n�mero de ocurrencias
ft <- freq_terms(corpus_text, n, stopwords= stop_es)	
ft
##n indica el n�mero de palabras frecuentes a desplegar
##stopwords=stop_es indica que la salida omitir�, adem�s de las palabras frecuentes por default,
##aquellas que nosotros mismos especificamos
plot(ft)	#Genera un gr�fico de barras para los t�rminos frecuentes


##Nube de palabras
wordcloud(words = ft$WORD, freq = ft$FREQ, min.freq = 30,
          max.words=35, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(10, "Dark2"))

##Para elegir entre paletas de colores, se puede utilizar display.brewer.all()


###Plots de correlaci�n de palabras clave
##
cor_plot <- apply_as_df(corpus_text, word_cor, word = "palabra_clave", r=)
#El comando anterior sirve para obtener una lista de palabras asociadas a una palabra clave
#Se indica la funci�n word_cor para la correlaci�n
#r debe ser un valor entre 0 y 1
sort(cor_plot$palabra_clave, decreasing=T)	#Lista de palabras por orden de asociaci�n de mayor a menor
plot(edu_plot)	#Plot

