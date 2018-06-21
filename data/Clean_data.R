start_time = Sys.time()
library(data.table)
tsv_path = "D://Data//input_tsv"
output_path = "D://Data//output_tsv"
files = list.files(path = tsv_path, pattern=".tsv$")
setwd(tsv_path)
for(f in files){
  system.time(wr <- fread(f,fill=TRUE,header=TRUE,quote='',drop=c(1,11,14)))
  system.time(wr$product_title <- paste0("'",wr$product_title,"'"))
  system.time(wr$review_headline <- paste0("'",wr$review_headline,"'"))
  dest = paste0(output_path,"/",f)
  system.time(fwrite(wr,file=dest,row.names=FALSE ,col.names=TRUE,sep='\t'))
}
print(paste0("Executed in time: ",(Sys.time()-start_time)))
