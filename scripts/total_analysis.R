analyse_total = function(total){
fcount=length(files)
    
    y_list <- foreach (f = ((fcount*3)+1):(fcount*4),.combine=rbind)%dopar%{
      total[[f]][,c(1,2)]
    }
    r_list <- foreach (f = ((fcount*4)+1):(fcount*5),.combine=rbind)%dopar%{
      total[[f]]$product_ratings
    }
    mrp <- foreach (f = ((fcount*5)+1):(fcount*6),.combine=rbind)%dopar%{
      total[[f]]$most_reviewed_product
    }
    mvp <- foreach (f = ((fcount*5)+1):(fcount*6),.combine=rbind)%dopar%{
      total[[f]]$most_verified_product
    }
    mrc <- foreach (f = ((fcount*6)+1):(fcount*7),.combine=rbind)%dopar%{
      total[[f]]$customer_with_most_reviews
    }
    mvc <- foreach (f = ((fcount*6)+1):(fcount*7),.combine=rbind)%dopar%{
      total[[f]]$most_verified_customer
    }
    mry <- foreach (f = ((fcount*7)+1):(fcount*8),.combine=rbind)%dopar%{
      total[[f]]$year_with_most_reviews
    }
    mvy <- foreach (f = ((fcount*7)+1):(fcount*8),.combine=rbind)%dopar%{
      total[[f]]$most_verified_year
    }
      
      #most reviewed products
      most_reviewed_product <- mrp[reviews == max(mrp$reviews)]
      print(paste0("Most reviewed product in the category is as follows:"))
      print(paste0("Product id :",most_reviewed_product[,1]))
      print(paste0("Product title :",most_reviewed_product[,2]))
      print(paste0("Product reviews count:",most_reviewed_product[,3]))
      #find product with most verified purchases
      most_verified_product <- mvp[verified == max(mvp$verified)]
      print(paste0("Product with most verified purchases is as follows:"))
      print(paste0("Product id :",most_verified_product[,1]))
      print(paste0("Product title :",most_verified_product[,2]))
      print(paste0("Product verified purchases:",most_verified_product[,3]))
      list("most_reviewed_product"=most_reviewed_product,"most_verified_product"=most_verified_product)
    
       print("**Customer wise results** ")
      #find customer who made maximum reviews
      customer_with_most_reviews <- mrc[reviews == max(mrc$reviews)]
      print(paste0("Customer who made most reviews is as follows :"))
      print(paste0("Customer id :",customer_with_most_reviews[,1]))
      print(paste0("Customer reviews count:",customer_with_most_reviews[,2]))
      
      #find customer with most verified purchases
      most_verified_customer <- mvc[verified == max(mvc$verified)]
      print(paste0("Customer who made most verified purchases is as follows:"))
      print(paste0("Customer id :",most_verified_customer[,1]))
      print(paste0("Customer verified purchases:",most_verified_customer[,2]))
      list("customer_with_most_reviews"=customer_with_most_reviews,"most_verified_customer"=most_verified_customer)
      
      print("**Year wise results** ")
      #find year in which maximum reviews were made
      year_with_most_reviews <- mry[reviews == max(mry$reviews)]
      print(paste0("Year with most reviews is as follows :"))
      print(paste0("Year :",year_with_most_reviews[,1]))
      print(paste0("Year reviews count:",year_with_most_reviews[,2]))
      
      #find year with most verified purchases
      most_verified_year <- mvy[verified == max(mvy$verified)]
      print(paste0("Year with most verified purchases is as follows:"))
      print(paste0("Year :",most_verified_year[,1]))
      print(paste0("Year verified purchases:",most_verified_year[,2]))
      
      all_y = y_list %>% group_by(year) %>% summarise(reviews=sum(reviews))
      all_r = r_list %>% group_by(star_rating) %>% summarise(count=sum(count))
    
    
    plot_all_year_reviews = ggplot(all_y,aes(x=year,y=reviews)) 
    plot_all_year_reviews = plot_all_year_reviews + labs(x="Year",y="Review count",title="Plot of reviews by Year") 
    plot_all_year_reviews = plot_all_year_reviews + geom_bar(stat="identity",fill="blue")
    plot_all_year_reviews = plot_all_year_reviews + scale_y_continuous(label=comma)
    plot_all_year_reviews = plot_all_year_reviews + scale_x_continuous(breaks=1995:2015) + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0)) + theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
    
    plot_all_ratings = ggplot(all_r,aes(x=star_rating,y=count)) + labs(title = "Plot of reviews by star rating",x="Star Ratings",y="Review count") + geom_bar(stat="identity",fill="blue") + scale_y_continuous(label=comma) + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0)) + theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
    
    saveplot(plot_all_ratings,paste0(output,"/plots/all_ratings.png"))
    saveplot(plot_all_year_reviews,paste0(output,"/plots/all_year_reviews.png"))
    obj = c("most_verified_customer","customer_with_most_reviews","most_verified_product","most_reviewed_product",
        "most_verified_year","year_with_most_reviews","all_r","all_y")
    save(list = obj,file=paste0(output,"/RData/total/analysis.RData"))

}