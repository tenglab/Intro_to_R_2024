library(tidyverse)

# import data
clinical <- read_csv("data/tcga_clinical.csv")
gene_exp <- read_csv("data/tcga_gene_exp.txt")

# merging data
full_data <- clinical %>%
  # mutate(OS_month = OS.time/30.5) %>%
  full_join(gene_exp, by = "bcr_patient_barcode")

left_data <- clinical %>%
  filter(acronym == "KIRC") %>%
  left_join(gene_exp)

right_data <- clinical %>%
  filter(acronym == "KIRC") %>%
  right_join(gene_exp)

semi_data <- clinical %>%
  filter(acronym == "KIRC") %>%
  semi_join(gene_exp)

anti_data <- clinical %>%
  filter(acronym == "KIRC") %>%
  anti_join(gene_exp)

# transposing data

long_gene <- gene_exp %>%
  pivot_longer(cols = contains("_exp"), names_to = "gene", values_to = "expression")

wide_gene <- long_gene %>%
  mutate(expression = log(expression)) %>%
  pivot_wider(id_cols = bcr_patient_barcode, names_from = gene, values_from = expression)

# NAs

clinical %>% drop_na(race)

clinical %>% fill(race)

clinical %>%
  replace_na(list(race = "UNKNOWN",
                  tobacco_smoking_history = "Probably not"))

# working with strings

strings <- clinical %>%
  unite("race_and_ethnicity", race, ethnicity, sep = "-")

strings %>%
  separate(race_and_ethnicity, into = c("race", "ethnicity"), "-")
