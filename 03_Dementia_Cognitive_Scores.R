# STEP 1: LOAD THE CROSS-SECTIONAL DATA
oasis_cross <- read.csv(file.choose())

# STEP 2: CLEAN DATA (SES uses a 1-5 scale, MMSE is 0-30)
# We remove any rows where SES or MMSE are missing
lifestyle_data <- subset(oasis_cross, !is.na(SES) & !is.na(MMSE))

# STEP 3: RUN THE REGRESSION
# Predicting cognitive score based on Socioeconomic Status
lifestyle_model <- lm(MMSE ~ SES, data = lifestyle_data)

print("--- NEW LIFESTYLE RESULTS: SES vs MMSE ---")
summary(lifestyle_model)

# STEP 4: CREATE FIGURE 4 (The replacement for the flat line)
library(ggplot2)

ggplot(lifestyle_data, aes(x = SES, y = MMSE)) +
  geom_jitter(alpha = 0.5, color = "darkgreen") + # Jitter helps see overlapping dots
  geom_smooth(method = "lm", color = "darkorange", se = TRUE) +
  labs(title = "Impact of Socioeconomic Status on Cognitive Scores",
       subtitle = "OASIS Cross-Sectional Analysis",
       x = "Socioeconomic Status (1 = Highest, 5 = Lowest)",
       y = "MMSE Cognitive Score") +
  theme_minimal()
