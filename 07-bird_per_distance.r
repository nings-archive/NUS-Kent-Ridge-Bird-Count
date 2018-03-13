#! /usr/bin/env Rscript

# Find the number of birds spotted per group

library(ggplot2)
library(plyr)

filter_5 <- function(df) {
    # @returns only observations of 5 species
    df[
        df$Bird.Species == 'Javan myna' |
        df$Bird.Species == 'Yellow-vented bulbul' |
        df$Bird.Species == 'Olive-backed sunbird' |
        df$Bird.Species == 'Rock pigeon' |
        df$Bird.Species == 'Black-naped oriole'
    , ]
}

df <- read.csv('data.csv')
df <- df[!is.na(df$Bird.Species), ]  # only confident IDs
df <- df[!is.na(df$Distance.Bin), ]  # no flybys or heard-not-seens
df <- filter_5(df)

make_distance_hist <- function(species) {
    df.species <- df[df$Bird.Species == species, ]
    bins = nrow(count(df.species$Distance.Bin))
    g <- ggplot(df.species, aes(x=Distance.Bin)) +
         geom_histogram(bins=bins) +
         labs(y='Observations', x='Distance Bin',
         title=paste('Observations per Distance bin (', species, ')', sep=''))
    ggsave(paste('07-bird_per_distance_', species, '.png', sep=''),
         width=5, height=2)
}

make_distance_hist('Javan myna')
make_distance_hist('Yellow-vented bulbul')
make_distance_hist('Olive-backed sunbird')
make_distance_hist('Rock pigeon')
make_distance_hist('Black-naped oriole')

# make a plot for all species,
g <- ggplot(df, aes(x=Distance.Bin)) +
    geom_histogram(bins=4) +
    labs(y='Observations', x='Distance Bin')

ggsave('07-bird_per_distance_general.png', width=5, height=2)
