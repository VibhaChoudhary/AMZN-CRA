##perform analysis on groups 
print("**Product wise results** ")

analysis_by_product = function(product_group,fname){
  #most reviewed products
  most_reviewed_product <- product_group[reviews == max(product_group$reviews)]
  most_reviewed_product <- most_reviewed_product[,c(1,2,3)]
  print(paste0("Most reviewed product in the category is as follows:"))
  print(paste0("Product id :",most_reviewed_product[,1]))
  print(paste0("Product title :",most_reviewed_product[,2]))
  print(paste0("Product reviews count:",most_reviewed_product[,3]))
  #find product with most verified purchases
  most_verified_product <- product_group[verified == max(product_group$verified)]
  most_verified_product = most_verified_product[,c(1,2,4)]
  print(paste0("Product with most verified purchases is as follows:"))
  print(paste0("Product id :",most_verified_product[,1]))
  print(paste0("Product title :",most_verified_product[,2]))
  print(paste0("Product verified purchases:",most_verified_product[,3]))
  list("most_reviewed_product"=most_reviewed_product,"most_verified_product"=most_verified_product)
}
analysis_by_customer = function(customer_group,fname){
   print("**Customer wise results** ")
  #find customer who made maximum reviews
  customer_with_most_reviews <- customer_group[reviews == max(customer_group$reviews)]
  customer_with_most_reviews = customer_with_most_reviews[,c(1,2)]
  print(paste0("Customer who made most reviews is as follows :"))
  print(paste0("Customer id :",customer_with_most_reviews[,1]))
  print(paste0("Customer reviews count:",customer_with_most_reviews[,2]))
  
  #find customer with most verified purchases
  most_verified_customer <- customer_group[verified == max(customer_group$verified)]
  most_verified_customer = most_verified_customer[,c(1,3)]
  print(paste0("Customer who made most verified purchases is as follows:"))
  print(paste0("Customer id :",most_verified_customer[,1]))
  print(paste0("Customer verified purchases:",most_verified_customer[,2]))
  list("customer_with_most_reviews"=customer_with_most_reviews,"most_verified_customer"=most_verified_customer)
}

analysis_by_year = function(year_group,fname){
  
  print("**Year wise results** ")
  #find year in which maximum reviews were made
  year_with_most_reviews <- year_group[reviews == max(year_group$reviews)]
  year_with_most_reviews = year_with_most_reviews[,c(1,2)]
  print(paste0("Year with most reviews is as follows :"))
  print(paste0("Year :",year_with_most_reviews[,1]))
  print(paste0("Year reviews count:",year_with_most_reviews[,2]))
  
  #find year with most verified purchases
  most_verified_year <- year_group[verified == max(year_group$verified)]
  most_verified_year <- most_verified_year[,c(1,3)]
  print(paste0("Year with most verified purchases is as follows:"))
  print(paste0("Year :",most_verified_year[,1]))
  print(paste0("Year verified purchases:",most_verified_year[,2]))
  
  #year reviews distribution
  year_reviews <- year_group[,c(1,2)]
  plot_year_reviews = ggplot(year_reviews,aes(x=year,y=reviews)) 
  plot_year_reviews = plot_year_reviews + labs(x="Year",y="Review count",title="Plot of reviews by Year") 
  plot_year_reviews = plot_year_reviews + geom_bar(stat="identity",fill="blue")
  plot_year_reviews = plot_year_reviews + scale_y_continuous(label=comma)
  plot_year_reviews = plot_year_reviews + scale_x_continuous(breaks=1995:2015) + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0)) +
    theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
    saveplot(plot_year_reviews,paste0(output,"/plots/year_reviews_",fname,".png"))
  list("year_with_most_reviews"=year_with_most_reviews,"most_verified_year"=most_verified_year,"year_reviews"=year_reviews)
}
