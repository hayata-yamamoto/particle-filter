#######
# This data was downloaded from https://sites.google.com/site/iwanamidatascience/vol6/time-series
# I added some additional codes to execute visualization on Mac
######

plot.fig1 = function(){
  range=3.5
  add.lines = function(z){
    lines(c(1:(tmax-1)), z[2:tmax], col=1)
    }

  if(.Platform$OS.type == "windows")
    windows()
  if(.Platform$OS.type == "mac")
    quartz()

  par(mfrow=c(2, 2))
  plot(0, xlim=c(1, (tmax-1)), ylim=c(-range, range), type="n", xlab="", ylab="")
  points(dat$x, dat$y, pch=19, col=grey(0.5))
  lines(c(1:(tmax-1)), dat$ytrue, col=1, lwd=1, lty=1)

  plot(0, xlim=c(1, (tmax-1)), ylim=c(-range, range), type="n", xlab="", ylab="")
  points(dat$x, dat$y, pch=19, col=grey(0.5))
  apply(x[1:5, ], 1, add.lines)
}

plot.fig23 = function(){
  range = 3.5
  add.lines = function(z){
    lines(c(1:(tmax-1)), z[2:tmax], col=1)
    }

  if(.Platform$OS.type == "windows")
    windows()
  if(.Platform$OS.type == "mac")
    quartz()

  par(mfrow=c(2, 2))
  plot(0, xlim=c(1, (tmax-1)), ylim=c(-range, range), type="n", xlab="", ylab="")
  points(dat$x, dat$y, pch=19, col=grey(0.5))
  apply(x[1:5,], 1, add.lines)

  plot(0, xlim=c(1, (tmax-1)), ylim=c(-range, range), type="n", xlab="", ylab="")
  lines(c(1:(tmax-1)), apply(x[, 2:tmax], 2, "median"), col=gray(0.5), lwd=3)
}

#---------------------------------------------------------

dat = read.table("testdata.txt")
tmax = length(dat$x) + 1
nmax = 5000

sd.ini = 1.0
sd.sys = 0.15
sd.obs = 0.2
sc.sys = 0.04

set.seed(1985)
x = matrix(0, nmax, tmax)
x[, 1] = rnorm(nmax, sd=sd.ini)
for (t in 1:(tmax-1)){
  x[, t+1] = x[, t] + rnorm(nmax, sd=sd.sys)
##  weight = exp(-(x[ ,t+1] - dat$y[t])^2 / (2*sd.obs^2))
##  x[, t+1] = sample(x[, t+1], prob=weight, replace=TRUE)
}
plot.fig1()

set.seed(1985)
x = matrix(0, nmax, tmax)
x[ ,1] = rnorm(nmax, sd=sd.ini)
for (t in 1:(tmax-1)){
  x[, t+1] = x[, t] + rnorm(nmax, sd=sd.sys)
  weight = exp(-(x[,t+1] - dat$y[t])^2 / (2*sd.obs^2))
  x[, t+1] = sample(x[, t+1], prob=weight, replace=TRUE)
}
plot.fig23()

set.seed(1985)
x = matrix(0, nmax, tmax)
x[ ,1] = rnorm(nmax, sd=sd.ini)
for (t in 1:(tmax-1)){
  x[ ,t+1] = x[ ,t] + rcauchy(nmax, scale=sc.sys)
  weight = exp(-(x[ ,t+1] - dat$y[t])^2 / (2*sd.obs^2))
  x[ ,t+1] = sample(x[ ,t+1], prob=weight, replace=TRUE)
}
plot.fig23()