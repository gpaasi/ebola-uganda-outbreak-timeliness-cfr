# meta_analysis.R
# Reproduce meta-analysis and meta-regression for Ebola outbreaks in Uganda (2000-2023)

# 1. Load required libraries
library(metafor)   # for meta-analysis
library(ggplot2)   # for visualization
library(dplyr)     # for data manipulation
library(readr)     # for reading CSV files

# 2. Set file paths
data_file <- file.path("data", "data_extraction_with_guide.csv")

# 3. Read data
df <- read_csv(data_file)

# 4. Example data cleaning: Keep outbreaks with non-missing essential fields
df_clean <- df %>%
  filter(!is.na(Confirmed_Cases),
         !is.na(Deaths),
         !is.na(Days_FirstCase_to_SpecimenCollection),
         !is.na(Days_Onset_of_IndexCase_to_MoHResponse))

# 5. Calculate CFR (proportion)
df_clean <- df_clean %>%
  mutate(CFR = Deaths / Confirmed_Cases)

# 6. Apply Freeman-Tukey double-arcsine transformation for proportions
transformed <- escalc(measure = "PFT", xi = Deaths, ni = Confirmed_Cases, data = df_clean)

# 7. Random-effects meta-analysis for CFR
res_meta <- rma(yi, vi, data = transformed, method = "REML")
print(summary(res_meta))

# 8. Save forest plot
png(filename = file.path("figures", "forest_plot_cfr.png"), width = 800, height = 600)
forest(res_meta, slab = paste(df_clean$Virus_Species, df_clean$Outbreak_Year, sep = " "),
       xlab = "CFR (Freeman-Tukey transformed)", mlab = "Overall")
dev.off()

# 9. Meta-regression: Effect of diagnostic delay on transformed CFR
res_meta_reg1 <- rma(yi, vi, mods = ~ Days_FirstCase_to_SpecimenCollection, data = transformed, method = "REML")
print(summary(res_meta_reg1))

# 10. Save bubble plot for first-case-to-specimen delay
p1 <- ggplot(transformed, aes(x = Days_FirstCase_to_SpecimenCollection, y = yi, size = 1/vi)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE, color = "blue") +
  labs(x = "Days from first case to specimen collection",
       y = "Freeman-Tukey-transformed CFR") +
  theme_minimal()
ggsave(filename = file.path("figures", "bubble_plot_delay_vs_cfr.png"), plot = p1, width = 7, height = 5)

# 11. Meta-regression: Effect of MoH response delay
res_meta_reg2 <- rma(yi, vi, mods = ~ Days_Onset_of_IndexCase_to_MoHResponse, data = transformed, method = "REML")
print(summary(res_meta_reg2))

# 12. Save bubble plot for onset-to-MoH response delay
p2 <- ggplot(transformed, aes(x = Days_Onset_of_IndexCase_to_MoHResponse, y = yi, size = 1/vi)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE, color = "darkgreen") +
  labs(x = "Days from symptom onset to MoH response declaration",
       y = "Freeman-Tukey-transformed CFR") +
  theme_minimal()
ggsave(filename = file.path("figures", "bubble_plot_onset_to_response.png"), plot = p2, width = 7, height = 5)
