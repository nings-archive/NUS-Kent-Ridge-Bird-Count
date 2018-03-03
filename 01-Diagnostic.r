#! /usr/bin/env Rscript

library(ggplot2)

df <- read.csv('data.csv')
summary(df$Bird.Species)

g <- ggplot(df) +
    geom_bar(aes(x=Bird.Species, fill=Bird.Species), stat='count')

ggsave('01-Diagnostic.png', plot=g, width=9, height=5)
