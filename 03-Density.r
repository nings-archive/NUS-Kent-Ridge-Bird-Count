#! /usr/bin/env Rscript

library(ggplot2)

df <- read.csv('counts_per_site.csv')
# summary(df)

myna    <- subset(df, Bird.Species == 'Javan myna')
bulbul  <- subset(df, Bird.Species == 'Yellow-vented bulbul')
pigeon  <- subset(df, Bird.Species == 'Rock pigeon')
sunbird <- subset(df, Bird.Species == 'Olive-backed sunbird')
oriole  <- subset(df, Bird.Species == 'Black-naped oriole')

n <- 200  # sample size
area <- 1.5  # assume 1.5km^2 area for NUS

print('Javan myna')
myna_mean <- mean(myna$Density)
myna_var  <- var(myna$Density)
paste('  mean: ', myna_mean, ', var: ', myna_var, sep='')
myna_ci <- qt(0.9750, df=n-1) * sqrt(myna_var) / sqrt(n)
paste('  err: ', myna_ci, 
      ', %CV: ', (sqrt(myna_var)/myna_mean)*100,
    sep='')
paste('  total pop: ', myna_mean * 1.5, ' +- ', myna_ci * 1.5, sep='')

print('Yellow-vented bulbul')
bulbul_mean <- mean(bulbul$Density)
bulbul_var  <- var(bulbul$Density)
paste('  mean: ', bulbul_mean, ', var: ', bulbul_var, sep='')
bulbul_ci <- qt(0.9750, df=n-1) * sqrt(bulbul_var) / sqrt(n)
paste('  err: ', bulbul_ci, 
      ', %cv: ', (sqrt(bulbul_var)/bulbul_mean)*100,
    sep='')
paste('  total pop: ', bulbul_mean * 1.5, ' +- ', bulbul_ci * 1.5, sep='')

print('Olive-backed sunbird')
sunbird_mean <- mean(sunbird$Density)
sunbird_var  <- var(sunbird$Density)
paste('  mean: ', sunbird_mean, ', var: ', sunbird_var, sep='')
sunbird_ci <- qt(0.9750, df=n-1) * sqrt(sunbird_var) / sqrt(n)
paste('  err: ', sunbird_ci, 
      ', %cv: ', (sqrt(sunbird_var)/sunbird_mean)*100,
    sep='')
paste('  total pop: ', sunbird_mean * 1.5, ' +- ', sunbird_ci * 1.5, sep='')

print('Rock pigeon')
pigeon_mean <- mean(pigeon$Density)
pigeon_var  <- var(pigeon$Density)
paste('  mean: ', pigeon_mean, ', var: ', pigeon_var, sep='')
pigeon_ci <- qt(0.9750, df=n-1) * sqrt(pigeon_var) / sqrt(n)
paste('  err: ', pigeon_ci, 
      ', %CV: ', (sqrt(pigeon_var)/pigeon_mean)*100,
    sep='')
paste('  total pop: ', pigeon_mean * 1.5, ' +- ', pigeon_ci * 1.5, sep='')

print('Black-naped oriole')
oriole_mean <- mean(oriole$Density)
oriole_var  <- var(oriole$Density)
paste('  mean: ', oriole_mean, ', var: ', oriole_var, sep='')
oriole_ci <- qt(0.9750, df=n-1) * sqrt(oriole_var) / sqrt(n)
paste('  err: ', oriole_ci, 
          ', %CV: ', (sqrt(oriole_var)/oriole_mean)*100,
    sep='')
paste('  total pop: ', oriole_mean * 1.5, ' +- ', oriole_ci * 1.5, sep='')

gm <- ggplot(myna, aes(x='Javan myna', y=Density)) +
    geom_boxplot() + 
    labs(y=parse(text='Density (km^-2)'), x='')
gb <- ggplot(bulbul, aes(x='Yellow-vented bulbul', y=Density)) +
    geom_boxplot() +
    labs(y=parse(text='Density (km^-2)'), x='')
gp <- ggplot(pigeon, aes(x='Rock pigeon', y=Density)) +
    geom_boxplot() +
    labs(y=parse(text='Density (km^-2)'), x='')
gs <- ggplot(sunbird, aes(x='Olive-backed sunbird', y=Density)) +
    geom_boxplot() +
    labs(y=parse(text='Density (km^-2)'), x='')
go <- ggplot(oriole, aes(x='Black-naped oriole', y=Density)) +
    geom_boxplot() +
    labs(y=parse(text='Density (km^-2)'), x='')

ggsave('03-Density-myna.png',    plot=gm, width=3, height=5)
ggsave('03-Density-bulbul.png',  plot=gb, width=3, height=5)
ggsave('03-Density-pigeon.png',  plot=gp, width=3, height=5)
ggsave('03-Density-sunbird.png', plot=gs, width=3, height=5)
ggsave('03-Density-oriole.png',  plot=go, width=3, height=5)
