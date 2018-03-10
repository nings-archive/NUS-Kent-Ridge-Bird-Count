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
old_df <- df
obs_count <- count(df$Time.Period)

# separate those with 3 digits, and those with 4
digits_3 <- obs_count[obs_count < 1000, ]
digits_3 <- digits_3[!is.na(digits_3$x), ]
digits_4 <- obs_count[obs_count > 999, ]
digits_4 <- digits_4[!is.na(digits_4$x), ]
# add a leading zero to digits_3's timeperiod (x) column
digits_3$x <- as.character(digits_3$x)
digits_3$x <- paste('0', digits_3$x, sep='')
# recombine the two into one dataframe
obs_count <- rbind(digits_3, digits_4)
obs_count$x <- as.POSIXct(obs_count$x, format='%H%M')
obs_count <- data.frame(obs_count)
names(obs_count) <- c('Time', 'Observations')

g <- ggplot(obs_count, aes(x=Time)) +
    geom_histogram(binwidth=1800) +
    labs(y='Observations', x='Survey start time')

ggsave('05-obs_per_timeperiod.png', width=6, height=2)
