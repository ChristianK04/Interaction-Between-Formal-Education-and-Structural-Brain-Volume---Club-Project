# Load the visualization package
library(ggplot2)

# Step 1: Load the Cross-Sectional dataset
oasis_cross <- read.csv(file.choose())

# Step 2: Clean the data
# Remove rows that are missing a Clinical Dementia Rating (CDR) or an MMSE score
oasis_clean <- subset(oasis_cross, !is.na(CDR) & !is.na(MMSE))

# Step 3: Filter out the extremely small CDR 2 category (only 2 patients)
oasis_filtered <- subset(oasis_clean, CDR != 2)

# Step 4: Convert the CDR numbers into distinct categorical groups
oasis_filtered[["CDR_Group"]] <- as.factor(oasis_filtered[["CDR"]])

# Step 5: Generate the Boxplot
plot_mmse_cross <- ggplot(droplevels(oasis_filtered), aes(x = CDR_Group, y = MMSE, fill = CDR_Group)) +
  geom_boxplot() +
  labs(title = "Cognitive Scores (MMSE) Across Dementia Stages",
       subtitle = "Cross-Sectional Baseline Analysis",
       x = "Clinical Dementia Rating (0 = Healthy, 1 = Mild Dementia)",
       y = "MMSE Cognitive Score") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set2") +
  theme(legend.position = "none")

# Print the graph
print(plot_mmse_cross)
