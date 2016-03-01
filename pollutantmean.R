pollutantmean<-function(directory, pollutant, id=1:332){
  list<-list.files(directory, full.names=TRUE)
  a<-data.frame()
  mean_select_pol<-c()
  for(i in id){
    a<- rbind(a, read.csv(list[i]))
  }
  pl<-mean(a[, pollutant], na.rm=TRUE)
  pl
}