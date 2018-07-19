compute_total = function(total){
    print("**Overall results are as follows**")
    fcount=length(files)
    total_r <- foreach (f = 1:fcount,.combine='+')%dopar%{
     total[[f]]$reviews_count
    }
    total_vp <- foreach (f = 1:fcount,.combine='+')%dopar%{
     total[[f]]$verified_purchases_count
    }
    total_hp <- foreach (f = 1:fcount,.combine='+')%dopar%{
      total[[f]]$helpful_reviews_count
    }
    p_list <- foreach (f = (fcount+1):(fcount*2),.combine=rbind)%dopar%{
      total[[f]][,1]
    }
    c_list <- foreach (f = ((fcount*2)+1):(fcount*3),.combine=rbind)%dopar%{
      total[[f]][,1]
    }
    all_c <- foreach (f = ((fcount*2)+1):(fcount*3),.combine=rbind)%dopar%{
      list(total[[f]][,1])
    }
    y_list <- foreach (f = ((fcount*3)+1):(fcount*4),.combine=rbind)%dopar%{
      total[[f]][,c(1,2)]
    }
    
    total_y = length(unique(y_list$year))  
    total_p = length(unique(p_list[[1]]))
    total_c = length(unique(c_list[[1]]))
    
    print(paste0("Total reviews:",total_r))
    print(paste0("Total customers:",total_c))
    print(paste0("Total products :",total_p))
    print(paste0("Total years :",total_y))
    print(paste0("Total verified purchases :",total_vp))
    print(paste0("Total helpful votes:",total_hp))
    
    totallist = c("total_r","total_p","total_c","total_y","total_vp","total_hp",
                  "fcount")
    save(list = totallist,file=paste0(output,"/RData/total/all_counts.RData"))
}