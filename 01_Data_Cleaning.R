
# STEP 1: IMPORT THE EXCEL DATASET
# Load the special Excel package
library(readxl)

# Read the XLSX file instead of a CSV
dementia_data <- read.csv(file.choose())

# STEP 2: CLEAN THE DATA
dementia_data <- na.omit(dementia_data)

# STEP 3: PREPARE THE VARIABLES
# Convert numerical categories into distinct factors
dementia_data[["CDR_Group"]] <- as.factor(dementia_data[["CDR"]])
dementia_data[["Education_Factor"]] <- as.factor(dementia_data[["EDUC"]])
dementia_data[["Clinical_Group"]] <- as.factor(dementia_data[["Group"]])


# STEP 4: REPLICATE THE CORE TESTS

# Test A: Education vs Dementia Rating (Excluding CDR score 2)
dementia_filtered <- subset(dementia_data, CDR != 2)
dementia_filtered[["CDR_Group"]] <- as.factor(dementia_filtered[["CDR"]])

anova_educ_cdr <- aov(EDUC ~ CDR_Group, data = dementia_filtered)
print("--- ANOVA: Education across Dementia Ratings (excluding 2) ---")
summary(anova_educ_cdr)

print("--- Post-hoc test results (Tukey HSD) ---")
TukeyHSD(anova_educ_cdr)

# Test B: Brain Volume vs Clinical Group (Demented vs Nondemented)
dementia_binary <- subset(dementia_data, Group %in% c("Demented", "Nondemented"))
dementia_binary[["Clinical_Group"]] <- as.factor(dementia_binary[["Group"]])

anova_nwbv_group <- aov(nWBV ~ Clinical_Group, data = dementia_binary)
print("--- ANOVA: Brain Volume between Demented and Nondemented ---")
summary(anova_nwbv_group)

# Test C: Brain Volume vs Education Levels
anova_nwbv_educ <- aov(nWBV ~ Education_Factor, data = dementia_data)
print("--- ANOVA: Brain Volume across different Education Levels ---")
summary(anova_nwbv_educ)


# STEP 5: THE ADVANCED INTERACTION TEST

# Two-Way ANOVA testing the interaction of Education and Diagnosis on Brain Volume
two_way_interaction <- aov(nWBV ~ Clinical_Group * Education_Factor, data = dementia_binary)
print("--- Recommended Test: Two-Way ANOVA (Interaction Effect) ---")
summary(two_way_interaction)

# Load the visualization package
library(ggplot2)

# Graph 1: Education vs Dementia Rating
# This shows that healthy patients (0) have higher education than mild dementia patients (0.5)
plot_educ_cdr <- ggplot(dementia_filtered, aes(x = CDR_Group, y = EDUC, fill = CDR_Group)) +
  geom_boxplot() +
  labs(title = "Years of Education Across Dementia Stages",
       x = "Clinical Dementia Rating (0 = Healthy, 1 = Mild Dementia)",
       y = "Years of Education") +
  theme_minimal() +
  scale_fill_brewer(palette = "Blues") +
  theme(legend.position = "none")

# Graph 2: Brain Volume vs Clinical Diagnosis
# This shows the physical brain shrinkage in the demented group
plot_brain_group <- ggplot(dementia_binary, aes(x = Clinical_Group, y = nWBV, fill = Clinical_Group)) +
  geom_boxplot() +
  labs(title = "Normalized Brain Volume by Clinical Diagnosis",
       x = "Clinical Group",
       y = "Normalized Whole Brain Volume (nWBV)") +
  theme_minimal() +
  scale_fill_manual(values = c("Demented" = "darkred", "Nondemented" = "steelblue")) +
  theme(legend.position = "none")

# Graph 3: The Interaction Effect
# This groups brain volume by education, colored by clinical diagnosis
plot_interaction <- ggplot(dementia_binary, aes(x = Education_Factor, y = nWBV, fill = Clinical_Group)) +
  geom_boxplot() +
  labs(title = "Interaction of Education and Diagnosis on Brain Volume",
       x = "Years of Education",
       y = "Normalized Whole Brain Volume (nWBV)",
       fill = "Diagnosis") +
  theme_minimal() +
  scale_fill_manual(values = c("Demented" = "darkred", "Nondemented" = "steelblue"))

# Command R to display the plots one by one
print(plot_educ_cdr)
print(plot_brain_group)
print(plot_interaction)
