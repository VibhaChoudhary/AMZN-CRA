group_by_products = function(product_data,fname){
    product_group <- product_data[,.(reviews = length(review_id),verified = length(verified_purchase[verified_purchase=='Y'])),
                      by = .(product_id,product_title)]
    product_group                          
}
group_by_customers = function(product_data,fname){
  customer_group <- product_data[,.(reviews = length(review_id),verified = length(verified_purchase[verified_purchase=='Y'])),by = customer_id]
  customer_group

}
group_by_years = function(product_data,fname){

  year_group <- product_data[,.(reviews = length(review_id),verified = length(verified_purchase[verified_purchase=='Y'])),
                            by = .(year=year(as.Date(product_data$review_date)))]
  year_group                       
}
group_by_ratings = function(product_data,fname){

  product_ratings <- product_data[,.(count = length(review_id)),by = star_rating]
  plot_ratings = ggplot(product_ratings,aes(x=star_rating,y=count)) 
  plot_ratings = plot_ratings + labs(x="Star Ratings",y="Review count",title = "Plot of reviews by star rating") 
  plot_ratings = plot_ratings + geom_bar(stat="identity",fill="blue")
  plot_ratings = plot_ratings + scale_y_continuous(label=comma)
  plot_ratings = plot_ratings + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0))
  plot_ratings = plot_ratings + theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
  saveplot(plot_ratings,paste0(output,"/plots/ratings_distribution_",fname,".png"))
  list("product_ratings"=product_ratings)
}

