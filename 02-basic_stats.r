#! /usr/bin/env Rscript

# Calculates, for the 5 most common species:
# 1. Mean density (r = 0.25km)
# 2. Standard Error
# 3. Confidence Interval
# 4. %CV
# 5. Total individuals on campus

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

get_count_vector <- function(df) {
    # @returns vector of length 200 of densities
    counts <- count(df$Location.Hash)
    counts[200, ] <- NA
    counts <- counts$freq
    counts[is.na(counts)] <- 0
    counts
}

get_density_vector <- function(xs) {
    # @returns vector of densities for r=0.25
    xs / (pi * 0.25 ** 2)
}

get_standard_error <- function(xs) {
    # @returns number of standard error
    n <- 200
    sd(xs)/sqrt(n)
}

get_ci <- function(xs) {
    # @returns the confidence interval (vector length 2)
    # this is a 95% level of confidence
    n <- 200
    error <- (qt(0.975, df=n-1) * sd(xs)) / sqrt(n)
    average <- mean(xs)
    c(average-error, average+error)
}

get_cv <- function(xs) {
    # @returns the coefficient of variation of xs
    sd(xs) / mean(xs)
}

generate_values <- function(df, species) {
    cat('Calculating for', species, fill=TRUE)
    filtered <- filter_species(df, species)
    counts <- get_count_vector(filtered)
    density <- get_density_vector(counts)
    cat('Mean Density:', mean(density), fill=TRUE)
    cat('Std err. of Mean Density:', get_standard_error(density), fill=TRUE)
    ci <- get_ci(density)
    cat('Lower CI:', ci[1], fill=TRUE)
    cat('Upper CI:', ci[2], fill=TRUE)
    cv <- get_cv(density)
    cat('%CV: ', cv*100, '%', sep='', fill=TRUE)
    
    individuals <- density * 1.5
    mean_individuals <- mean(individuals)
    stderror_individuals <- get_standard_error(individuals)
    cat('Total Individuals:', mean_individuals, fill=TRUE)
    cat('Std err. of Total Individuals:', stderror_individuals, fill=TRUE)
    cat('\n')
}

generate_values(df, 'Javan myna')
generate_values(df, 'Yellow-vented bulbul')
generate_values(df, 'Olive-backed sunbird')
generate_values(df, 'Rock pigeon')
generate_values(df, 'Black-naped oriole')
