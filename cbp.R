library(tidyverse)

crop <- read_csv("agriculture_climate_yield_tableau_2.csv",
                 show_col_types = FALSE)

glimpse(crop)

colSums(is.na(crop))
n_distinct(crop$Country)
n_distinct(crop$Crop)
range(crop$Year)
sum(duplicated(crop))

all(abs(crop$Yield_kg_per_ha * 10 -
        crop$Yield_hg_per_ha) < 1e-6, na.rm = TRUE)

crop %>%
  summarise(
    avg_rainfall_mm = mean(Annual_Rainfall_mm, na.rm = TRUE),
    avg_temp_c = mean(Avg_Temperature_C, na.rm = TRUE),
    avg_yield_kg_ha = mean(Yield_kg_per_ha, na.rm = TRUE)
  )

crop_summary <- crop %>%
  group_by(Crop) %>%
  summarise(
    records = n(),
    countries = n_distinct(Country),
    mean_yield = mean(Yield_kg_per_ha, na.rm = TRUE),
    median_yield = median(Yield_kg_per_ha, na.rm = TRUE),
    min_yield = min(Yield_kg_per_ha, na.rm = TRUE),
    max_yield = max(Yield_kg_per_ha, na.rm = TRUE),
    total_yield = sum(Yield_kg_per_ha, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(mean_yield))

print(crop_summary)

yield_trend <- crop %>%
  group_by(Crop, Year) %>%
  summarise(
    avg_yield = mean(Yield_kg_per_ha, na.rm = TRUE),
    .groups = "drop"
  )

yield_trend %>%
  filter(Year %in% c(1990, 2013)) %>%
  pivot_wider(
    names_from = Year,
    values_from = avg_yield
  ) %>%
  mutate(
    change_pct = (`2013` / `1990` - 1) * 100
  )

rain_bands <- crop %>%
  mutate(
    band = cut(
      Annual_Rainfall_mm,
      breaks = c(0, 500, 1000, 1500, 2000, 2500, Inf),
      right = FALSE
    )
  ) %>%
  group_by(band) %>%
  summarise(
    records = n(),
    mean_yield = mean(Yield_kg_per_ha, na.rm = TRUE),
    .groups = "drop"
  )

temp_bands <- crop %>%
  mutate(
    band = cut(
      Avg_Temperature_C,
      breaks = c(0, 10, 15, 20, 25, Inf),
      right = FALSE
    )
  ) %>%
  group_by(band) %>%
  summarise(
    records = n(),
    mean_yield = mean(Yield_kg_per_ha, na.rm = TRUE),
    .groups = "drop"
  )

crop %>%
  group_by(Crop) %>%
  summarise(
    r_rain = cor(Yield_kg_per_ha, Annual_Rainfall_mm,
                 use = "complete.obs"),
    r_temp = cor(Yield_kg_per_ha, Avg_Temperature_C,
                 use = "complete.obs"),
    r_pest = cor(Yield_kg_per_ha, Pesticides_tonnes,
                 use = "complete.obs"),
    .groups = "drop"
  )

palette <- c(
  "Cassava" = "#4E79A7",
  "Maize" = "#F28E2B",
  "Plantains and others" = "#E15759",
  "Potatoes" = "#76B7B2",
  "Rice, paddy" = "#59A14F",
  "Sorghum" = "#EDC948",
  "Soybeans" = "#B07AA1",
  "Sweet potatoes" = "#FF9DA7",
  "Wheat" = "#9C755F",
  "Yams" = "#BAB0AC"
)

p1 <- ggplot(
  yield_trend,
  aes(x = Year, y = avg_yield, colour = Crop)
) +
  geom_line(linewidth = 1) +
  scale_colour_manual(values = palette) +
  labs(
    x = "Year",
    y = "Average yield (kg/ha)"
  ) +
  theme_minimal()

print(p1)

ggsave(
  "yield_trend.png",
  plot = p1,
  width = 8,
  height = 4.5,
  dpi = 300
)

p2 <- ggplot(
  crop,
  aes(x = Annual_Rainfall_mm,
      y = Yield_kg_per_ha,
      colour = Crop)
) +
  geom_point(alpha = 0.6) +
  scale_colour_manual(values = palette) +
  labs(
    x = "Annual rainfall (mm)",
    y = "Yield (kg/ha)"
  ) +
  theme_minimal()

print(p2)

ggsave(
  "rainfall_vs_yield.png",
  plot = p2,
  width = 8,
  height = 4.5,
  dpi = 300
)

crop_clean <- distinct(crop)

write_csv(
  crop_clean,
  "agriculture_climate_yield_clean.csv"
)

nrow(crop_clean)
