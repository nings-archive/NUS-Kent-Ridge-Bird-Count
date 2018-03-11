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

df$Time.Period <- as.character(df$Time.Period)
# LHS: select values len equals 3, then add a leading '0' to those values
# RHS: select values len equals 3
# operation: replace RHS values by LHS
df$Time.Period[nchar(df$Time.Period) == 3] <- 
    paste('0', df$Time.Period[nchar(df$Time.Period) == 3], sep='')
df$Time.Period <- as.POSIXct(df$Time.Period, format='%H%M')

timeperiod <- function(loc_hash) {
    # returns the timeperiod for the location hash
    rows <- df[df$Location.Hash == loc_hash, ]
    row  <- rows[1, ]
    row$Time.Period
}

obs_per_site <- count(df$Location.Hash)
obs_per_site$x <- as.character(obs_per_site$x)
obs_per_site <- data.frame(obs_per_site)
colnames(obs_per_site) <- c('Location Hash', 'Observations')
hashes <- obs_per_site[, 'Location Hash']
mapping <- sapply(hashes, timeperiod, simplify=FALSE)
mapping <- as.numeric(mapping[hashes])  # numeric vectors of epoch times
timestamps <- as.POSIXct(mapping, origin="1970-01-01")
obs_per_site$Time.Period <- timestamps

lfit <- lm(data=obs_per_site, formula=Observations~Time.Period)
attributes(lfit)
r.2 <- summary(lfit)$r.squared

g <- ggplot(obs_per_site, aes(x=Time.Period, y=Observations)) +
    geom_point() + 
    geom_smooth(method='lm') +
    labs(x='Survey start time') +
    annotate(x=as.POSIXct(1520752000, origin='1970-01-01'), y=30.00,
        'text', label=paste('r^2 == ',r.2), parse=TRUE)

ggsave('06-obs_per_survey_per_timeperiod.png', width=6, height=2)

# sample size
nrow(obs_per_site)
