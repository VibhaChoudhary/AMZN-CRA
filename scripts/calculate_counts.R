count_all = function(product_data,fname){

##calculate all counts for product_data
print(paste0("********************************************"))

#Total count
reviews_count <- nrow(product_data)
print(paste0("Total reviews made in the category: ",reviews_count)) 

#product count
product_count <- length(unique(product_data$product_id))
print(paste0("Total products in the category :",product_count))

#customer count
customer_count <- length(unique(product_data$customer_id))
print(paste0("Total cutomers in the category :",customer_count))

#year count
year_count <- length(unique( substr(product_data$review_date,1,4)))
print(paste0("Total years in the category :",year_count))
count_5 = nrow(product_data[star_rating==5])
print(paste0("Number of 5 star reviews :",count_5))
count_4 = nrow(product_data[star_rating==4])
print(paste0("Number of 4 star reviews :",count_4))
count_3 = nrow(product_data[star_rating==3])
print(paste0("Number of 3 star reviews :",count_3))
count_2 = nrow(product_data[star_rating==2])
print(paste0("Number of 2 star reviews :",count_2))
count_1 = nrow(product_data[star_rating==1])
print(paste0("Number of 1 star reviews :",count_1))

#find verified purchases
verified_purchases_count <- nrow(product_data[verified_purchase == 'Y'])
print(paste0("Number of reviews that came from verified purchases: ",verified_purchases_count))

#find helpful reviews
helpful_reviews_count <- nrow(product_data[helpful_votes > 0])
print(paste0("Number of reviews that were voted helpful by customers: ",helpful_reviews_count))

objlist = list("reviews_count"=reviews_count,"verified_purchases_count"=verified_purchases_count,"helpful_reviews_count"=helpful_reviews_count,
"product_count"=product_count,"customer_count"=customer_count,"year_count"=year_count)
save(list=names(objlist),file=paste0(output,"/RData/",fname,"/all_counts.RData"))           
objlist   
}
