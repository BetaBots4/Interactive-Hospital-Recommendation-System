## Merge data to one data frame & Make the one table to explain the column
## Kazunori Kasahara

library(tidyverse)

## Merge data to one data frame
# Import data to join
filelist <- list.files("data_to_join")[c(-1,-2,-3,-5,-7,-10,-12)] # exclude the data about mean and median and the table about column
for (i in seq_along(filelist)){
file <- filelist[i]
path <- paste0("data_to_join/",file)
data <- read.csv(path)
name <- str_sub(file,start = 1, end = -5)
assign(name,data)
remove(data)
}

# Edit the data to prepare for joining
complication_summary=read.csv("C:\\Users\\lenovo\\Downloads\\Hospital-Recommendation-System-master (1)\\Hospital-Recommendation-System-master\\data_to_join\\complication_summary.csv")
colnames(complication_summary)[1] <- "Provider.ID"
hvbp=read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\hvbp.csv")
colnames(hvbp)[1] <- "Provider.ID"
ipfqr=read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\ipfqr.csv")
ipfqr <- ipfqr[,-1]
colnames(ipfqr)[1] <- "Provider.ID"
joined_payments=read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\joined_payments.csv")
joined_payments <- joined_payments[,-1]
outpatient_imagery_effect_summary=read_csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\outpatient_imagery_effect_summary.csv")
outpatient_imagery_effect_summary <- outpatient_imagery_effect_summary[,-1]
timely_effective_care_summary=read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\timely_effective_care_summary.csv")
timely_effective_care_summary <- timely_effective_care_summary[,-1]

# Join the data
complete_joined_data <- left_join(joined_payments,complication_summary, by = "Provider.ID") %>%
  left_join(hvbp) %>% 
  left_join(ipfqr) %>%
  left_join(outpatient_imagery_effect_summary) %>%
  left_join(timely_effective_care_summary) %>%
  left_join(joined_payments)

write_csv(complete_joined_data,"C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\complete_joined_data")


## Merge the tables about columns

rm(list = ls())
effectivecare <- read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\coltable_effectivecare")
imagery <- read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\coltable_imagery")
complication <- read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\complication_summary_Measureid_measurename.csv")
payment <- read.csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\Payment_ids.csv")
payment <- payment[,-1]
payment <- payment %>% select(2,1)
colnames(payment) <- colnames(effectivecare)
medical_code <- read_csv("C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\medical_codes.csv")
colnames(medical_code) <- colnames(effectivecare)

complete_col_table <- rbind(effectivecare,imagery) %>% 
  rbind(complication) %>% 
  rbind(payment) %>%
  rbind(medical_code)

write_csv(complete_col_table,"C:\\Users\\lenovo\\OneDrive\\Desktop\\sem 7\\complete_col_table")



