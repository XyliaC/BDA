library(dplyr)
test <- read.csv("happiness_train_abbr.csv")

#数据处理方法
#socialize、relax、learn异常值删去
#equity异常值填3
#class异常值删去
#work_status异常值填9（其他）
#work_yr异常值删去，空值填0
#work_type、work_manage NA值填0

attach(test)
nrow(test)
test <- test[socialize != -8 & relax != -8 & learn != -8 & class != -8,]
nrow(test)
test <- within(test,{equity[equity == -8] <- 3

#test <- within(test,{class[work_exper == 1&class == -8] <- 8
#class[work_exper == 2&class == -8] <- 7
#class[work_exper == 3&class == -8] <- 6
#class[work_exper == 4&class == -8] <- 5
#class[work_exper == 5&class == -8] <- 4
#class[work_exper == 6&class == -8] <- 5})
#test <- test[class != -8,]
#nrow(test)

work_status[work_status == -8] <- 9})
#用within()函数对变量进行重编码
test <- within(test,{work_status[is.na(work_status)] <- 9})
#dplyr中的mutate_at将函数应用于字符向量选择的特定列
test <- dplyr::mutate_at(test, .vars = vars("work_yr","work_type","work_manage"), .fun = function(x) ifelse(is.na(x), 0, x)) 
#dplyr中的filter()函数选择行
test <- test%>%filter(work_yr >= 0 & work_type != -8 & work_manage != -8)
nrow(test)
detach(test)
