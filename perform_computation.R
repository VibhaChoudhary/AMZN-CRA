start_time = Sys.time()

#initialise dir path
input = "data/input"
output = "data/output"
scripts = "scripts"
  
#import all defined functions
source(paste0(scripts,"/import_libraries.R"))
source(paste0(scripts,"/calculate_counts.R"))
source(paste0(scripts,"/create_groups.R"))
source(paste0(scripts,"/group_analysis.R"))
source(paste0(scripts,"/compute_total.R"))
source(paste0(scripts,"/total_analysis.R"))

#create directories to store output
dir.create(paste0(output,"/RData"))
dir.create(paste0(output,"/RData/total"))
dir.create(paste0(output,"/plots"))

files = list.files(path = input, pattern=".tsv$")
exclude = c(4,9,11)
setwd(input)

saveplot = function(plotname,filenmae){
  png(file=filenmae)
  print(plotname)
  dev.off()
}
print(paste0("Total Categories: ",length(files))) 

total <- foreach (f = 1:(length(files)),.combine=rbind) %dopar% {
     fname = strsplit(files[f],'[.]')[[1]][1]
     dir.create(paste0(output,"/RData/",fname))
     #Read the .tsv file
     category_data = fread(files[f],sep='\t',drop=exclude)
     #Compute all counts
     count_data <- count_all(category_data,fname)
     #group by products
     product_group <- group_by_products(category_data,fname)
     #group by customers
     customer_group <- group_by_customers(category_data,fname)
     #group by years
     year_group <- group_by_years(category_data,fname)
     #group by ratings
     ratings_group <- group_by_ratings(category_data,fname)
     #Do analysis on product group
     product_analysis <- analysis_by_product(product_group,fname)
     #Do analysis on customer group
     customer_analysis <- analysis_by_customer(customer_group,fname)
     #Do analysis on year group
     year_analysis <- analysis_by_year(year_group,fname)
     l1 = names(ratings_group)
     l2 = names(product_analysis)
     l3 = names(customer_analysis)
     l4 = names(year_analysis)
     obj = c(l1,l2,l3,l4)
     attach(customer_analysis)
     attach(product_analysis)
     attach(ratings_group)
     attach(year_analysis)
     #Save RData
     save(list=obj,file=paste0(output,"/RData/",fname,"/analysis.RData"))
     #Collect all data in total
     list("cd"=count_data,"pg"=product_group,"cg"=customer_group,"yg"=year_group,"rg"=ratings_group,
     "pa"=product_analysis,"ca"=customer_analysis,"ya"=year_analysis)
}
# calculate counts on total 
compute_total(total)
# do analysis on total 
analyse_total(total)
    
print(paste("Whole script executed in time:",Sys.time()- start_time ))
