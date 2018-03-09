#! /usr/bin/env Rscript

# Calculates, basic aggregates values
# 1. Total observations
# 2. Total selected 5 species observations
# 3. Observations for each of the 5 species
# 4. Histogram for (3)

library(ggplot2)
library(plyr)

df <- read.csv('data.csv')

filter_species <- function(df, species) {
    # @returns observations for Bird.Species == species,
    # and Distance Bin != na
    df <- df[df$Bird.Species == species, ]
    df <- df[!is.na(df$Distance.Bin), ]
    df
}

count_locations <- function(df) {
    counts <- count(df$Location.Hash)
    nrow(counts)
}

all_obs <- df[!is.na(df$Bird.Species), ]
all_obs <- all_obs[!is.na(df$Distance.Bin), ]
cat('All valid observations:', nrow(all_obs), fill=TRUE)
cat('Locations with all valid observations:', 
    count_locations(all_obs), fill=TRUE)

myna <- filter_species(df, 'Javan myna')
bulbul <- filter_species(df, 'Yellow-vented bulbul')
sunbird <- filter_species(df, 'Olive-backed sunbird')
pigeon <- filter_species(df, 'Rock pigeon')
oriole <- filter_species(df, 'Black-naped oriole')

cat('Javan myna observations:',            nrow(myna),    fill=TRUE)
cat('Yellow-vented bulbul observations:',  nrow(bulbul),  fill=TRUE)
cat('Olive-backed sunbird  observations:', nrow(sunbird), fill=TRUE)
cat('Rock pigeon observations:',           nrow(pigeon),  fill=TRUE)
cat('Black-naped oriole observations:',    nrow(oriole),  fill=TRUE)
cat('Total observations:', 
    nrow(myna) + nrow(bulbul) + nrow(sunbird) + nrow(pigeon) + nrow(oriole),
    fill=TRUE
)
selected_obs <- rbind(myna, bulbul, sunbird, pigeon, oriole)
cat('Locations with observations of selected species:', 
    count_locations(selected_obs), fill=TRUE)

counts_per_bird <- count(selected_obs$Bird.Species)
names(counts_per_bird) <- c('Bird Species', 'Observations')

g <- ggplot(selected_obs) +
    geom_bar(aes(x=Bird.Species, fill=Bird.Species), stat='count') +
    labs(y='Observations', x='Bird Species') +
    guides(fill=FALSE)  # remove legend

# TODO: sort bars in descending/ascending order

ggsave('03-basic_aggregates.png', width=6, height=4)
