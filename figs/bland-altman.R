# Load packages and functions ---------------------------------------------

library(here)
library(tidyverse)
library(ragg)
library(patchwork)
library(ggsci)
library(scales)
source(here("code/functions/plot_functions.R"))

# Load data ---------------------------------------------------------------

running_df <- read_csv(here("data/processed/running_data.csv")) %>%
  mutate(
    BMI_cat = fct_relevel(
      as_factor(BMI_cat),
      levels = c(
        "Normal weight", "Overweight", "Obesity class I"
      )
    )
  ) %>%
  select(subj, BMI_cat)

jumping_df <- read_csv(here("data/processed/jumping_data.csv")) %>%
  mutate(
    BMI_cat = fct_relevel(
      as_factor(BMI_cat),
      levels = c(
        "Normal weight", "Overweight", "Obesity class I",
        "Obesity class II", "Obesity class III"
      )
    )
  ) %>%
  select(subj, BMI_cat)

# LOOCV data
GRF_loocv_running <- read_csv(here("data/processed/GRF_loocv_running.csv")) %>%
  full_join(running_df)
GRF_loocv_jumping <- read_csv(here("data/processed/GRF_loocv_jumping.csv")) %>%
  full_join(jumping_df)
LR_loocv_jumping <- read_csv(here("data/processed/LR_loocv_jumping.csv")) %>%
  full_join(jumping_df)

# GRF plots ---------------------------------------------------------------

# Running
BA_GRF_running_ankle_res <- GRF_loocv_running %>%
  filter(acc_placement == "ankle" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-1500, 600),
    expand = c(0, 0),
    breaks = seq(-1500, 600, 300)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Ankle",
    x = "Mean of Actual and Predicted pRGRF (N)",
    y = "Actual - Predicted pRGRF (N)"
  )

BA_GRF_running_back_res <- GRF_loocv_running %>%
  filter(acc_placement == "lower_back" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-600, 600),
    expand = c(0, 0),
    breaks = seq(-600, 600, 200)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Lower Back",
    x = "Mean of Actual and Predicted pRGRF (N)",
    y = "Actual - Predicted pRGRF (N)"
  )

BA_GRF_running_hip_res <- GRF_loocv_running %>%
  filter(acc_placement == "hip" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-600, 600),
    expand = c(0, 0),
    breaks = seq(-600, 600, 200)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Hip",
    x = "Mean of Actual and Predicted pRGRF (N)",
    y = "Actual - Predicted pRGRF (N)"
  )

BA_GRF_running_ankle_ver <- GRF_loocv_running %>%
  filter(acc_placement == "ankle" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-900, 600),
    expand = c(0, 0),
    breaks = seq(-900, 600, 300)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Ankle",
    x = "Mean of Actual and Predicted pVGRF (N)",
    y = "Actual - Predicted pVGRF (N)"
  )

BA_GRF_running_back_ver <- GRF_loocv_running %>%
  filter(acc_placement == "lower_back" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-600, 600),
    expand = c(0, 0),
    breaks = seq(-600, 600, 200)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Lower Back",
    x = "Mean of Actual and Predicted pVGRF (N)",
    y = "Actual - Predicted pVGRF (N)"
  )

BA_GRF_running_hip_ver <- GRF_loocv_running %>%
  filter(acc_placement == "hip" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-600, 600),
    expand = c(0, 0),
    breaks = seq(-600, 600, 200)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Hip",
    x = "Mean of Actual and Predicted pVGRF (N)",
    y = "Actual - Predicted pVGRF (N)"
  )

# Jumping
BA_GRF_jumping_ankle_res <- GRF_loocv_jumping %>%
  filter(acc_placement == "ankle" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-1500, 2000),
    expand = c(0, 0),
    breaks = seq(-1500, 2000, 500)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Ankle",
    x = "Mean of Actual and Predicted pRGRF (N)",
    y = "Actual - Predicted pRGRF (N)"
  )

BA_GRF_jumping_back_res <- GRF_loocv_jumping %>%
  filter(acc_placement == "lower_back" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-1600, 1600),
    expand = c(0, 0),
    breaks = seq(-1600, 1600, 400)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Lower Back",
    x = "Mean of Actual and Predicted pRGRF (N)",
    y = "Actual - Predicted pRGRF (N)"
  )

BA_GRF_jumping_hip_res <- GRF_loocv_jumping %>%
  filter(acc_placement == "hip" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-2000, 1500),
    expand = c(0, 0),
    breaks = seq(-2000, 1500, 500)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Hip",
    x = "Mean of Actual and Predicted pRGRF (N)",
    y = "Actual - Predicted pRGRF (N)"
  )

BA_GRF_jumping_ankle_ver <- GRF_loocv_jumping %>%
  filter(acc_placement == "ankle" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-1600, 2000),
    expand = c(0, 0),
    breaks = seq(-1600, 2000, 400)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Ankle",
    x = "Mean of Actual and Predicted pVGRF (N)",
    y = "Actual - Predicted pVGRF (N)"
  )

BA_GRF_jumping_back_ver <- GRF_loocv_jumping %>%
  filter(acc_placement == "lower_back" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-1600, 1600),
    expand = c(0, 0),
    breaks = seq(-1600, 1600, 400)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Lower Back",
    x = "Mean of Actual and Predicted pVGRF (N)",
    y = "Actual - Predicted pVGRF (N)"
  )

BA_GRF_jumping_hip_ver <- GRF_loocv_jumping %>%
  filter(acc_placement == "hip" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    limits = c(-2000, 1600),
    expand = c(0, 0),
    breaks = seq(-2000, 1600, 400)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Hip",
    x = "Mean of Actual and Predicted pVGRF (N)",
    y = "Actual - Predicted pVGRF (N)"
  )

# LR plots ----------------------------------------------------------------

# Jumping
BA_LR_jumping_ankle_res <- LR_loocv_jumping %>%
  filter(acc_placement == "ankle" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    labels = label_number(),
    limits = c(-100000, 125000),
    expand = c(0, 0),
    breaks = seq(-100000, 125000, 50000)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Ankle",
    x = quote("Mean of Actual and Predicted pRLR" ~ (N %.% s^-1)),
    y = quote("Actual - Predicted pRLR" ~ (N %.% s^-1))
  )

BA_LR_jumping_back_res <- LR_loocv_jumping %>%
  filter(acc_placement == "lower_back" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    labels = label_number(),
    limits = c(-100000, 100000),
    expand = c(0, 0),
    breaks = seq(-100000, 100000, 50000)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Lower Back",
    x = quote("Mean of Actual and Predicted pRLR" ~ (N %.% s^-1)),
    y = quote("Actual - Predicted pRLR" ~ (N %.% s^-1))
  )

BA_LR_jumping_hip_res <- LR_loocv_jumping %>%
  filter(acc_placement == "hip" & vector == "resultant") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    labels = label_number(),
    limits = c(-100000, 100000),
    expand = c(0, 0),
    breaks = seq(-100000, 100000, 50000)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Hip",
    x = quote("Mean of Actual and Predicted pRLR" ~ (N %.% s^-1)),
    y = quote("Actual - Predicted pRLR" ~ (N %.% s^-1))
  )

BA_LR_jumping_ankle_ver <- LR_loocv_jumping %>%
  filter(acc_placement == "ankle" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    labels = label_number(),
    limits = c(-100000, 150000),
    expand = c(0, 0),
    breaks = seq(-100000, 150000, 50000)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Ankle",
    x = quote("Mean of Actual and Predicted pVLR" ~ (N %.% s^-1)),
    y = quote("Actual - Predicted pVLR" ~ (N %.% s^-1))
  )

BA_LR_jumping_back_ver <- LR_loocv_jumping %>%
  filter(acc_placement == "lower_back" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    labels = label_number(),
    limits = c(-100000, 100000),
    expand = c(0, 0),
    breaks = seq(-100000, 100000, 50000)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Lower Back",
    x = quote("Mean of Actual and Predicted pVLR" ~ (N %.% s^-1)),
    y = quote("Actual - Predicted pVLR" ~ (N %.% s^-1))
  )

BA_LR_jumping_hip_ver <- LR_loocv_jumping %>%
  filter(acc_placement == "hip" & vector == "vertical") %>%
  publication_bland_altman() +
  scale_color_nejm() +
  scale_y_continuous(
    labels = label_number(),
    limits = c(-100000, 100000),
    expand = c(0, 0),
    breaks = seq(-100000, 100000, 50000)
  ) +
  theme_light() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.title = element_blank()
  ) +
  labs(
    title = "Hip",
    x = quote("Mean of Actual and Predicted pVLR" ~ (N %.% s^-1)),
    y = quote("Actual - Predicted pVLR" ~ (N %.% s^-1))
  )

# Combine and save plots --------------------------------------------------

# Running GFR
  BA_GRF_running_hip_res +
  BA_GRF_running_ankle_ver +
  BA_GRF_running_back_ver +
  BA_GRF_running_hip_ver +
  plot_annotation(tag_levels = "A") +
  plot_layout(guides = "collect") &
  theme(legend.position = "bottom")
agg_tiff(
  here("figs/bland-altman_GRF_running.tiff"),
  width = 120,
  height = 50,
  units = "cm",
  res = 100,
  scaling = 2
)
plot(BA_GRF_running)
dev.off()

# Jumping GFR
BA_GRF_jumping <- BA_GRF_jumping_ankle_res +
  BA_GRF_jumping_back_res +
  BA_GRF_jumping_hip_res +
  BA_GRF_jumping_ankle_ver +
  BA_GRF_jumping_back_ver +
  BA_GRF_jumping_hip_ver +
  plot_annotation(tag_levels = "A") +
  plot_layout(guides = "collect") &
  theme(legend.position = "bottom")
agg_tiff(
  here("figs/bland-altman_GRF_jumping.tiff"),
  width = 120,
  height = 50,
  units = "cm",
  res = 100,
  scaling = 2
)
plot(BA_GRF_jumping)
dev.off()

# Jumping LR
BA_LR_jumping <- BA_LR_jumping_ankle_res +
  BA_LR_jumping_back_res +
  BA_LR_jumping_hip_res +
  BA_LR_jumping_ankle_ver +
  BA_LR_jumping_back_ver +
  BA_LR_jumping_hip_ver +
  plot_annotation(tag_levels = "A") +
  plot_layout(guides = "collect") &
  theme(legend.position = "bottom")
agg_tiff(
  here("figs/bland-altman_LR_jumping.tiff"),
  width = 120,
  height = 50,
  units = "cm",
  res = 100,
  scaling = 2
)
plot(BA_LR_jumping)
dev.off()
