# Load the visualization library
library(ggplot2)

# Step 1: Load the Cross-Sectional (Lifespan) dataset
# Make sure the file name matches exactly what is on your computer
oasis_cross <- read.csv(file.choose())

# Step 2: Generate the Lifespan Plot
# We are plotting Age on the X-axis and nWBV on the Y-axis
figure_1_lifespan <- ggplot(oasis_cross, aes(x = Age, y = nWBV)) +
  geom_point(alpha = 0.4, color = "darkslategrey") +
  geom_smooth(method = "lm", color = "blue", se = TRUE) +
  labs(title = "Normalized Whole Brain Volume Across the Adult Lifespan",
       subtitle = "OASIS Cross-Sectional Analysis (Ages 18-96)",
       x = "Participant Age (Years)",
       y = "Normalized Whole Brain Volume (nWBV)") +
  theme_minimal()

# Step 3: Print the plot to the R Studio viewer
print(figure_1_lifespan)

# Step 4: Run a quick regression to get the stats for the caption
baseline_model <- lm(nWBV ~ Age, data = oasis_cross)
summary(baseline_model)