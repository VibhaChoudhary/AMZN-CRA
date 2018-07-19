library(data.table)
library(doParallel)
registerDoParallel(detectCores())

tsv_path ="data/input"
output_path = "data/input"
files = list.files(path = tsv_path, pattern=".tsv.gz$")

setwd(tsv_path)

foreach(f = 1:length(files)) %dopar% {
  #Read the data bydropping unnecessary columns
  uncompressed <- R.utils::gunzip(files[f])
  data <- fread(uncompressed,fill=TRUE,header=TRUE,quote='',drop=c(1,11,14))
  #quote the text columns 
  data$product_title <- paste0("'",data$product_title,"'")
  data$review_headline <- paste0("'",data$review_headline,"'")
  #define output path
  fname = str_split(uncompressed,'[_]',n = 4)[[1]][4]
  fname = str_split(fname,'_v1')[[1]][1]
  dest = paste0(output_path,"/",fname,".tsv")
  #Write data to output path
  unlink(uncompressed)
  fwrite(data,file=dest,row.names=FALSE ,col.names=TRUE,sep='\t')
}