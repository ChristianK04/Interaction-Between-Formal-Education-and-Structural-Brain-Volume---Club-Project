# --- PART 1: LOAD AND CLEAN DATA ---
# Load necessary libraries
library(ggplot2)

# Load the longitudinal dataset (update file name to .xlsx if needed)
dementia_data <- read.csv(file.choose())

# Remove rows with missing values
dementia_data <- na.omit(dementia_data)

# Filter out the CDR 2 group (the 3 patients with moderate dementia)
dementia_filtered <- subset(dementia_data, CDR != 2)

# Prepare categorical factors
dementia_filtered[["CDR_Group"]] <- as.factor(dementia_filtered[["CDR"]])
dementia_filtered[["Education_Factor"]] <- as.factor(dementia_filtered[["EDUC"]])
dementia_filtered[["Clinical_Group"]] <- as.factor(dementia_filtered[["Group"]])

# Create separate datasets for the sub-group plots
demented_only <- subset(dementia_filtered, Group == "Demented")
nondemented_only <- subset(dementia_filtered, Group == "Nondemented")


# --- PART 2: STATISTICAL TABLES ---

# Table 3 & 4: Education across Dementia Stages
anova_educ_cdr <- aov(EDUC ~ CDR_Group, data = dementia_filtered)
print("--- ANOVA: Education across CDR Stages ---")
summary(anova_educ_cdr)
print("--- Tukey Post-Hoc Results ---")
TukeyHSD(anova_educ_cdr)

# Table 5: Brain Volume by Clinical Group
anova_nwbv_group <- aov(nWBV ~ Clinical_Group, data = dementia_filtered)
print("--- ANOVA: Brain Volume by Clinical Group ---")
summary(anova_nwbv_group)

# Table 6: Brain Volume across Education Levels
anova_nwbv_educ <- aov(nWBV ~ Education_Factor, data = dementia_filtered)
print("--- ANOVA: Brain Volume by Education Levels ---")
summary(anova_nwbv_educ)

# Interaction Test: Group x Education
interaction_test <- aov(nWBV ~ Clinical_Group * Education_Factor, data = dementia_filtered)
print("--- Two-Way ANOVA: Interaction Effect ---")
summary(interaction_test)


# --- PART 3: GENERATING THE FOUR PLOTS ---

# Load visualization library
library(ggplot2)

# --- PLOT A: THE AGE ATROPHY GAP ---
# This shows how dementia lowers the "baseline" of brain volume compared to healthy aging
plot_age_overlay <- ggplot(dementia_filtered, aes(x = Age, y = nWBV, color = Clinical_Group)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", se = TRUE) +
  scale_color_manual(values = c("Demented" = "darkred", "Nondemented" = "darkblue")) +
  labs(title = "Accelerated Brain Atrophy: Demented vs. Healthy Aging",
       x = "Participant Age (Years)",
       y = "Normalized Whole Brain Volume (nWBV)",
       color = "Clinical Diagnosis") +
  theme_minimal()

# --- PLOT B: THE EDUCATION INTERACTION ---
# This shows if education provides a different structural benefit for different groups
plot_educ_overlay <- ggplot(dementia_filtered, aes(x = EDUC, y = nWBV, color = Clinical_Group)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", se = TRUE) +
  scale_color_manual(values = c("Demented" = "darkred", "Nondemented" = "darkblue")) +
  labs(title = "Educational Reserve: Impact on Structural Brain Volume",
       x = "Years of Education",
       y = "Normalized Whole Brain Volume (nWBV)",
       color = "Clinical Diagnosis") +
  theme_minimal()

# Print the plots
print(plot_age_overlay)
print(plot_educ_overlay)
