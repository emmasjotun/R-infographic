# Usage:
# Rscript "infographic.R (fre.20.nov).R" sleep_infographic.png
#
# Argument 1: Name of the output PNG file.

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 1 || !grepl("\\.png$", args[1], ignore.case = TRUE)) {
  stop("Usage: Rscript infographic.R output.png")
}

output_file <- args[1]
library(tidyverse)

# bruker det innebygde sleep-datasettet
data("sleep")

#Prøver å gjøre dataene klare til sammenligning
sleep_data <- sleep %>%
  mutate(
    ID = factor(ID, levels = as.character(1:10)),
    group = paste("Drug", group)
  )

# Ser på dataene
print(sleep_data)
# Lag infografikken
p <- ggplot(sleep_data,
            aes(x = ID, y = extra, fill = group)) +
  geom_col(position = "dodge", width = 0.7) +
  scale_fill_manual(
    values = c("Drug 1" = "#F4A261",
               "Drug 2" = "#2A9D8F")
  ) +
  labs(
    title = "One drug, ten people, different responses",
    subtitle = "How did 10 patients respond to two sleeping drugs?",
    x = "Patient",
    y = "Change in sleep (hours)",
    fill = "Sleeping drug",
    caption = "Source: R built-in sleep dataset"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 18),
    plot.subtitle = element_text(size = 12),
    legend.position = "bottom"
  )

# Vis infografikken
print(p)
ggsave(
  filename = output_file,
  plot = p,
  width = 12,
  height = 7,
  dpi = 300
)