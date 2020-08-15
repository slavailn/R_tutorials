library(lattice)

## Going through "Introduction to R" by Deepayan Sarkar
## https://www.isid.ac.in/~deepayan/R-tutorials/labs/04_lattice_lab.pdf

## Load data
data(Chem97, package = "mlmRev")
head(Chem97)

#   lea school student score gender age gcsescore   gcsecnt
# 1   1      1       1     4      F   3     6.625 0.3393157
# 2   1      1       2    10      F  -3     7.625 1.3393157
# 3   1      1       3    10      F  -4     7.250 0.9643157

## Draw the distributions of all average scores with histogram
histogram(~ gcsescore, data=Chem97)

## Histogram split by subgroups (A-level score)
histogram(~ gcsescore|factor(score), data=Chem97)

## Direct superposition of distributions with kernel density plots
## Note the argument "group = gender"
densityplot(~ gcsescore|factor(score), data=Chem97, group = gender,
            auto.key = T)

## When "factor" statement is ommitted, the score is considered a numeric 
## variable and converted to shingle
densityplot(~ gcsescore|score, data=Chem97, group = gender,
            auto.key = T)

## Examine normal qq-plots
qqmath(~ gcsescore | factor(score), Chem97, groups = gender,
       f.value = ppoints(100), auto.key = list(columns = 2),
       type = c("p", "g"), aspect = "xy")

## Compare quantiles of two samples with QQ plot
## Here we compare gscescore for males and females conditioned on A-leve
## score
qq(gender ~ gcsescore | factor(score), Chem97,
   f.value = ppoints(100), type = c("p", "g"), aspect = 1)

qq(gender ~ gcsescore |factor(score), Chem97, f.value = ppoints(100), 
   type = c("p", "g"), aspect = 1)

## Box and whisker plot of gcsescore by A-level score and 
## conditioned by gender
bwplot(factor(score) ~ gcsescore | gender, Chem97)

## Genders shown side-by-side
bwplot(gcsescore ~ gender | factor(score), Chem97, layout = c(6, 1))

## Boxplots and QQ plots are only useful for unimodal distributions
data(gvhd10, package = "latticeExtra")
head(gvhd10)
bwplot(Days ~ log(FSC.H), data = gvhd10)
densityplot( ~ log(FSC.H)|factor(Days), data = gvhd10)


## Stripplot based on quakes dataset
## Plot depth vs magnitude
head(quakes)
stripplot(depth ~ factor(mag), data = quakes,
          jitter.data = TRUE, alpha = 0.6,
          main = "Depth of earthquake epicenters by magnitude",
          xlab = "Magnitude (Richter)",
          ylab = "Depth (km)")

## Cleavland dot plot (same use as barchart) based on State Virginia
## death rate data
VADeaths
## Convert to long format
VADeathsDF <- as.data.frame.table(VADeaths, responseName = "Rate")
VADeathsDF
dotplot(Var1 ~ Rate | Var2, VADeathsDF, layout = c(4, 1))
## Even better choice is to put the variables on the same graph
## and join the dots with lines
dotplot(Rate ~ Var1, data = VADeathsDF, groups = Var2, type = "o",
        auto.key = list(space = "right", points = TRUE, lines = TRUE))

## Scatterplot based on Earthquake data
data(Earthquake, package = "nlme")
head(Earthquake)
xyplot(accel ~ distance, data = Earthquake)

## Plot on a log scale and add smooth
xyplot(accel ~ distance, data = Earthquake, scales = list(log = TRUE),
       type = c("p", "g", "smooth"), xlab = "Distance From Epicenter (km)",
       ylab = "Maximum Horizontal Acceleration (g)")

## Condition on shingles (factors on continuous variables)
Depth <- equal.count(quakes$depth, number=8, overlap=.1)
Depth
xyplot(lat ~ long | Depth, data = quakes)

## Three-dimentional scatter plot (cloud) plot
cloud(depth ~ lat * long, data = quakes,
      zlim = rev(range(quakes$depth)),
      screen = list(z = 105, x = -70), panel.aspect = 0.75,
      xlab = "Longitude", ylab = "Latitude", zlab = "Depth")























