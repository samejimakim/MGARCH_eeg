require(seewave)
dados<-read.table("JoaoSato_REST_MRI.dat",h=F,dec=",")
dim(dados)
db.eeg<-data.frame(t(dados[,2:202761]))
head(db.eeg)
db.eeg[1,1]
colnames(db.eeg)<-dados[,1]
rownames(db.eeg)<-NULL
###### Lembrar de fazer a filtragem ######
### A filtragem elimina pontos diferentes entre as series, o que ocasiona no despareamento delas. Precisamos modificar o ffilter para devolver o vetor do mesmo tamanho que o anterior. ####
db.f.eeg<-data.frame(matrix(ncol = dim(db.eeg)[2], nrow = dim(db.eeg)[1]))
  
for(i in fft1:dim(db.eeg)[2]){
  db.f.eeg[,i]<-ffilter(db.eeg[,i],250,1,100,TRUE,output=" ts")
}
  
temp<-ffilter(db.eeg[,1],250,1,100,TRUE,output=" ts")
plot.ts(temp, ylim=c(min(db.eeg[,1]),max(db.eeg[,1])))
par(new=T)
plot.ts(db.eeg[,1],col="red", ylim=c(min(db.eeg[,1]),max(db.eeg[,1])))
