library(tidyverse)

# import data
clinical <- read_csv("data/tcga_clinical.csv")
gene_exp <- read_csv("data/tcga_gene_exp.txt")

# take a look at our data
print(clinical)
str(clinical)
View(clinical)

colnames(clinical)
dim(clinical)

# subsetting (columns)

clinical$acronym
clinical[["acronym"]]
clinical[[2]]

clinical %>% select(acronym, bcr_patient_barcode, height)

gene_exp %>% select(bcr_patient_barcode, starts_with("DNAH"))

# create columns

clinical %>%
  mutate(os_time_months = OS.time/30.5) %>%
  select(bcr_patient_barcode, OS.time, os_time_months)

# subset rows

clinical %>% filter(acronym == "HNSC") %>% filter(vital_status == "ALIVE")

# summarise

clinical %>%
  group_by(acronym) %>%
  summarise( n = n())

# arrange

clinical %>%
  arrange(desc(OS.time)) %>% select(bcr_patient_barcode, OS.time)
