#! /usr/bin/env Rscript

library(ggplot2)

df <- read.csv('counts_per_site.csv')
# summary(df)

myna    <- subset(df, Bird.Species == 'Javan myna')
bulbul  <- subset(df, Bird.Species == 'Yellow-vented bulbul')
pigeon  <- subset(df, Bird.Species == 'Rock pigeon')
sunbird <- subset(df, Bird.Species == 'Olive-backed sunbird')
oriole  <- subset(df, Bird.Species == 'Black-naped oriole')

print('Javan myna')
summary(myna$Density)
print(var(myna$Density))
print('Yellow-vented bulbul')
summary(bulbul$Density)
print(var(bulbul$Density))
print('Rock pigeon')
summary(pigeon$Density)
print(var(pigeon$Density))
print('Olive-backed sunbird')
summary(sunbird$Density)
print(var(sunbird$Density))
print('Black-naped oriole')
summary(oriole$Density)
print(var(oriole$Density))

gm <- ggplot(myna, aes(x=1, y=Density)) +
    geom_boxplot()
gb <- ggplot(bulbul, aes(x=1, y=Density)) +
    geom_boxplot()
gp <- ggplot(pigeon, aes(x=1, y=Density)) +
    geom_boxplot()
gs <- ggplot(sunbird, aes(x=1, y=Density)) +
    geom_boxplot()
go <- ggplot(oriole, aes(x=1, y=Density)) +
    geom_boxplot()

ggsave('03-Density-myna.png',    plot=gm, width=9, height=5)
ggsave('03-Density-bulbul.png',  plot=gb, width=9, height=5)
ggsave('03-Density-pigeon.png',  plot=gp, width=9, height=5)
ggsave('03-Density-sunbird.png', plot=gs, width=9, height=5)
ggsave('03-Density-oriole.png',  plot=go, width=9, height=5)
