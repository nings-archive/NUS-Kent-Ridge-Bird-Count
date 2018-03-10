#! /usr/bin/env Rscript

# Find the number of birds spotted per group

library(ggplot2)
library(plyr)

get_cv <- function(df) {
    # @returns coefficient of variation in %
    sd <- sd(df)
    avg <- mean(df)
    cat('s =', sd, 'and mean =', avg, fill=TRUE)
    sd/avg * 100
}

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
obs_per_group <- count(df$Group.Name)
names(obs_per_group) <- c('Group Name', 'Observations')
obs_per_group <- data.frame(obs_per_group)

print(obs_per_group)  # tabular print
cat('Total:', sum(obs_per_group$Observations), fill=TRUE)

cv <- get_cv(obs_per_group$Observations)
cv <- round(cv, digits=3)
cv_text <- paste('Coefficient of Variation = ', cv, '%', sep='')
cat(cv_text, fill=TRUE)

# annotate: inverted (x, y) because of coord_flip
g <- ggplot(obs_per_group, aes(x='', y=Observations)) +
    geom_boxplot() + coord_flip() +  # horiziontal boxplot
    labs(x='') +
    annotate('text', label=cv_text, x=0.6, y=152)  

ggsave('04-group_counts.png', width=6, height=2)
