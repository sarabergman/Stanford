MPFC, ELS, and Social Support
========================================================


```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
setwd("~/Box Sync/9.9.14/58N_maineffect_HOatlas_union/")
mpfc = read.csv("ant+out_58subs_mPFC09-Sep-2014.csv")  #mPFC - conjuntion of H-O atlas with cope13 (gain > nongain)
```



```r
library("png")
library("grid")
mpfc.png = readPNG("~/Box Sync/9.9.14/58N_maineffect_HOatlas_union/mpfc.png")
grid.raster(mpfc.png)
```

![plot of chunk nacc image](figure/nacc_image.png) 



```r
boxplot(mpfc$antgain, mpfc$antloss, mpfc$antnongain, mpfc$antnonloss, mpfc$gain, 
    mpfc$loss, mpfc$nongain, mpfc$nonloss, names = c("antgain", "antloss", "antnongain", 
        "antnonloss", "gain", "loss", "nongain", "nonloss"), ylab = ("percent signal change in mpfc"), 
    las = 2)
```

![plot of chunk boxplot mpfc](figure/boxplot_mpfc.png) 



```r
#create dataframe to make bargraphs
mpfc.pe = c(mpfc$antgain,mpfc$antloss,mpfc$antnongain,mpfc$antnongain,mpfc$gain, mpfc$loss, mpfc$nongain, mpfc$nonloss)
condition.2 = c(rep(x = "antgain", times = 58), rep(x = "antloss", times = 58), rep(x = "antnongain", times = 58), rep(x = "antnonloss", times = 58),rep(x = "gain", times = 58), rep(x = "loss", times = 58), rep(x = "nongain", times = 58), rep(x = "nonloss", times = 58))
mpfcbar = data.frame(condition.2,mpfc.pe)

mpfc.summary = data.frame(
  condition = levels(mpfcbar$condition.2),
  mean = tapply(mpfcbar$mpfc.pe, mpfcbar$condition, mean),
  n = tapply(mpfcbar$mpfc.pe, mpfcbar$condition, length),
  sd = tapply(mpfcbar$mpfc.pe, mpfcbar$condition, sd)
  )

#calculate standard error of the mean 
mpfc.summary$sem = mpfc.summary$sd/sqrt(mpfc.summary$n) 

#calculate margin of error for CI
alpha = .05 #95% confidence interval
mpfc.summary$me = qt(1-alpha/2, df = mpfc.summary$n)*mpfc.summary$sem

#error bars represent 95% CI
#png('barplot.CI.vSTR.anticipation.png')
g3.CI = ggplot(mpfc.summary, aes(x = condition, y = mean)) + 
  geom_bar(position = position_dodge(), stat="identity", fill="blue", width=.5) +
  geom_errorbar(aes(ymin=mean-me, ymax=mean+me), width=.3) +
  ggtitle("Reward-Related mpfc Activity / (Error bars represent 95% CI)") + # plot title
  geom_hline(yintercept=0, linetype = 1) +
  labs(x = "Anticipation and Outcome", y = "Percent BOLD signal change in mpfc") +
  theme_bw() +
  #theme_classic()
  theme(panel.grid.major = element_blank()) # remove x and y major grid lines
print(g3.CI)
```

![plot of chunk mpfc bar](figure/mpfc_bar1.png) 

```r
#dev.off()

#error bars represent standard error of the mean
g3.SE = ggplot(mpfc.summary, aes(x = condition, y = mean)) + 
  geom_bar(position = position_dodge(), stat="identity", fill="blue", width=.5) +
  geom_errorbar(aes(ymin=mean-sem, ymax=mean+sem), width=.3) +
  labs(x = "Anticipation and Outcome", y = "Percent BOLD signal change in mpfc") +
  ggtitle("Reward-Related mpfc Activity / (Error bars represent SEM)") +
  geom_hline(yintercept=0, linetype = 1) +
  theme_bw() +
  theme(panel.grid.major = element_blank())
print(g3.SE)
```

![plot of chunk mpfc bar](figure/mpfc_bar2.png) 



### Anticipation

```r
cor.test(mpfc$antgain, mpfc$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgain and mpfc$TotEventsExpUSE
## t = 0.0967, df = 56, p-value = 0.9233
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2462  0.2703
## sample estimates:
##     cor 
## 0.01292
```

```r
cor.test(mpfc$antgain, mpfc$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgain and mpfc$TotNumCategUSE
## t = 0.1815, df = 56, p-value = 0.8567
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2355  0.2808
## sample estimates:
##     cor 
## 0.02424
```

```r
cor.test(mpfc$antgain, mpfc$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgain and mpfc$TotChildSubjRatUSE
## t = 0.2196, df = 56, p-value = 0.827
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2307  0.2855
## sample estimates:
##     cor 
## 0.02933
```

```r
plot(mpfc$antgain, mpfc$TotEventsExpUSE)  # example plot, no relation
```

![plot of chunk mpfc cor ant](figure/mpfc_cor_ant1.png) 

```r

cor.test(mpfc$antloss, mpfc$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antloss and mpfc$TotEventsExpUSE
## t = -0.625, df = 56, p-value = 0.5345
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3343  0.1789
## sample estimates:
##      cor 
## -0.08323
```

```r
cor.test(mpfc$antloss, mpfc$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antloss and mpfc$TotNumCategUSE
## t = -0.5608, df = 56, p-value = 0.5772
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3267  0.1872
## sample estimates:
##      cor 
## -0.07472
```

```r
cor.test(mpfc$antloss, mpfc$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antloss and mpfc$TotChildSubjRatUSE
## t = -0.6309, df = 56, p-value = 0.5307
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3350  0.1782
## sample estimates:
##      cor 
## -0.08401
```

```r

cor.test(mpfc$antgain, mpfc$ss.total)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgain and mpfc$ss.total
## t = 1.066, df = 51, p-value = 0.2914
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1277  0.4019
## sample estimates:
##    cor 
## 0.1477
```

```r
cor.test(mpfc$antloss, mpfc$ss.total)  #r = .25, p = .065
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antloss and mpfc$ss.total
## t = 1.883, df = 51, p-value = 0.06544
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.0165  0.4914
## sample estimates:
##    cor 
## 0.2549
```

```r

mpfc$antgainvnongain = mpfc$antgain - mpfc$antnongain
mpfc$antlossvnonloss = mpfc$antloss - mpfc$antnonloss

cor.test(mpfc$antgainvnongain, mpfc$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgainvnongain and mpfc$TotEventsExpUSE
## t = -0.7163, df = 56, p-value = 0.4768
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3451  0.1671
## sample estimates:
##      cor 
## -0.09529
```

```r
cor.test(mpfc$antgainvnongain, mpfc$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgainvnongain and mpfc$TotNumCategUSE
## t = -0.6107, df = 56, p-value = 0.5439
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3326  0.1808
## sample estimates:
##      cor 
## -0.08134
```

```r
cor.test(mpfc$antgainvnongain, mpfc$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgainvnongain and mpfc$TotChildSubjRatUSE
## t = -0.4925, df = 56, p-value = 0.6243
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3186  0.1959
## sample estimates:
##      cor 
## -0.06567
```

```r
cor.test(mpfc$antgainvnongain, mpfc$ss.total)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antgainvnongain and mpfc$ss.total
## t = -0.2729, df = 51, p-value = 0.786
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3053  0.2345
## sample estimates:
##      cor 
## -0.03819
```

```r

# summary(lm(mpfc$TotChildSubjRatUSE ~ mpfc$antgainvnongain)) #same as above

plot(mpfc$antlossvnonloss, mpfc$TotEventsExpUSE)
```

![plot of chunk mpfc cor ant](figure/mpfc_cor_ant2.png) 

```r
cor.test(mpfc$antlossvnonloss, mpfc$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antlossvnonloss and mpfc$TotEventsExpUSE
## t = -0.8359, df = 56, p-value = 0.4068
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3590  0.1516
## sample estimates:
##    cor 
## -0.111
```

```r
cor.test(mpfc$antlossvnonloss, mpfc$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antlossvnonloss and mpfc$TotNumCategUSE
## t = -0.7463, df = 56, p-value = 0.4586
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3486  0.1632
## sample estimates:
##      cor 
## -0.09924
```

```r
cor.test(mpfc$antlossvnonloss, mpfc$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$antlossvnonloss and mpfc$TotChildSubjRatUSE
## t = -0.7718, df = 56, p-value = 0.4435
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3516  0.1599
## sample estimates:
##     cor 
## -0.1026
```

```r

summary(lm(mpfc$antlossvnonloss ~ mpfc$TotEventsExpUSE * mpfc$Sex))  #ns
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$TotEventsExpUSE * mpfc$Sex)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.9318 -0.1587  0.0372  0.1620  0.8275 
## 
## Coefficients:
##                                Estimate Std. Error t value Pr(>|t|)
## (Intercept)                     0.07466    0.08401    0.89     0.38
## mpfc$TotEventsExpUSE           -0.00964    0.01337   -0.72     0.47
## mpfc$SexM                      -0.09331    0.16510   -0.57     0.57
## mpfc$TotEventsExpUSE:mpfc$SexM -0.00887    0.03132   -0.28     0.78
## 
## Residual standard error: 0.329 on 54 degrees of freedom
## Multiple R-squared:  0.0518,	Adjusted R-squared:  -0.000837 
## F-statistic: 0.984 on 3 and 54 DF,  p-value: 0.407
```

```r
summary(lm(mpfc$antlossvnonloss ~ mpfc$TotEventsExpUSE * mpfc$Age.at.scan))  #ns
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$TotEventsExpUSE * mpfc$Age.at.scan)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.7760 -0.2013  0.0593  0.1717  0.8258 
## 
## Coefficients:
##                                       Estimate Std. Error t value Pr(>|t|)
## (Intercept)                             1.9122     0.8581    2.23    0.030
## mpfc$TotEventsExpUSE                   -0.3645     0.1500   -2.43    0.018
## mpfc$Age.at.scan                       -0.1612     0.0731   -2.20    0.032
## mpfc$TotEventsExpUSE:mpfc$Age.at.scan   0.0305     0.0129    2.37    0.022
##                                        
## (Intercept)                           *
## mpfc$TotEventsExpUSE                  *
## mpfc$Age.at.scan                      *
## mpfc$TotEventsExpUSE:mpfc$Age.at.scan *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.318 on 54 degrees of freedom
## Multiple R-squared:  0.11,	Adjusted R-squared:  0.06 
## F-statistic: 2.21 on 3 and 54 DF,  p-value: 0.0971
```

**Main effect of ELS on anticipation of loss > nonloss in mPFC when considering the interactive effect with age...**


```r
summary(lm(mpfc$antlossvnonloss ~ mpfc$ss.total))
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$ss.total)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.8578 -0.2126  0.0305  0.2111  0.6508 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept)   -0.25249    0.22084   -1.14     0.26
## mpfc$ss.total  0.00320    0.00334    0.96     0.34
## 
## Residual standard error: 0.311 on 51 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0178,	Adjusted R-squared:  -0.00149 
## F-statistic: 0.923 on 1 and 51 DF,  p-value: 0.341
```

```r
summary(lm(mpfc$antlossvnonloss ~ mpfc$ss.total + mpfc$Sex))
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$ss.total + mpfc$Sex)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.8887 -0.1910  0.0407  0.1938  0.6196 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept)   -0.20168    0.22736   -0.89     0.38
## mpfc$ss.total  0.00293    0.00335    0.88     0.39
## mpfc$SexM     -0.08370    0.08772   -0.95     0.34
## 
## Residual standard error: 0.311 on 50 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0353,	Adjusted R-squared:  -0.00325 
## F-statistic: 0.916 on 2 and 50 DF,  p-value: 0.407
```

```r
summary(lm(mpfc$antlossvnonloss ~ mpfc$ss.total + mpfc$Age.at.scan))
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$ss.total + mpfc$Age.at.scan)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.8357 -0.1770  0.0234  0.2190  0.6333 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)
## (Intercept)      -0.02217    0.54692   -0.04     0.97
## mpfc$ss.total     0.00344    0.00340    1.01     0.32
## mpfc$Age.at.scan -0.02105    0.04567   -0.46     0.65
## 
## Residual standard error: 0.313 on 50 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0219,	Adjusted R-squared:  -0.0172 
## F-statistic: 0.56 on 2 and 50 DF,  p-value: 0.575
```

```r

summary(lm(mpfc$antlossvnonloss ~ mpfc$ss.total * mpfc$TotEventsExpUSE, na.action = na.omit))
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$ss.total * mpfc$TotEventsExpUSE, 
##     na.action = na.omit)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.8557 -0.2111  0.0428  0.1999  0.6481 
## 
## Coefficients:
##                                     Estimate Std. Error t value Pr(>|t|)
## (Intercept)                         0.049901   0.380212    0.13     0.90
## mpfc$ss.total                      -0.001016   0.005594   -0.18     0.86
## mpfc$TotEventsExpUSE               -0.066506   0.068122   -0.98     0.33
## mpfc$ss.total:mpfc$TotEventsExpUSE  0.000935   0.001007    0.93     0.36
## 
## Residual standard error: 0.314 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0369,	Adjusted R-squared:  -0.022 
## F-statistic: 0.626 on 3 and 49 DF,  p-value: 0.602
```

```r
summary(lm(mpfc$antlossvnonloss ~ mpfc$ss.total * mpfc$TotNumCategUSE, na.action = na.omit))
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$ss.total * mpfc$TotNumCategUSE, 
##     na.action = na.omit)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.8518 -0.2019  0.0337  0.2054  0.6449 
## 
## Coefficients:
##                                    Estimate Std. Error t value Pr(>|t|)
## (Intercept)                        0.006112   0.389950    0.02     0.99
## mpfc$ss.total                     -0.000536   0.005783   -0.09     0.93
## mpfc$TotNumCategUSE               -0.062075   0.076684   -0.81     0.42
## mpfc$ss.total:mpfc$TotNumCategUSE  0.000908   0.001155    0.79     0.44
## 
## Residual standard error: 0.315 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0307,	Adjusted R-squared:  -0.0286 
## F-statistic: 0.518 on 3 and 49 DF,  p-value: 0.672
```

```r
summary(lm(mpfc$antlossvnonloss ~ mpfc$ss.total * mpfc$TotChildSubjRatUSE, na.action = na.omit))
```

```
## 
## Call:
## lm(formula = mpfc$antlossvnonloss ~ mpfc$ss.total * mpfc$TotChildSubjRatUSE, 
##     na.action = na.omit)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -0.860 -0.219  0.038  0.208  0.656 
## 
## Coefficients:
##                                        Estimate Std. Error t value
## (Intercept)                           -0.139243   0.312337   -0.45
## mpfc$ss.total                          0.001723   0.004807    0.36
## mpfc$TotChildSubjRatUSE               -0.018261   0.034898   -0.52
## mpfc$ss.total:mpfc$TotChildSubjRatUSE  0.000240   0.000545    0.44
##                                       Pr(>|t|)
## (Intercept)                               0.66
## mpfc$ss.total                             0.72
## mpfc$TotChildSubjRatUSE                   0.60
## mpfc$ss.total:mpfc$TotChildSubjRatUSE     0.66
## 
## Residual standard error: 0.316 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0254,	Adjusted R-squared:  -0.0342 
## F-statistic: 0.426 on 3 and 49 DF,  p-value: 0.735
```



###Outcome


```r
plot(mpfc$gain, mpfc$TotChildSubjRatUSE)
```

![plot of chunk mpfc cor outcome](figure/mpfc_cor_outcome.png) 

```r
cor.test(mpfc$gain, mpfc$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$gain and mpfc$TotEventsExpUSE
## t = -0.1612, df = 56, p-value = 0.8725
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2783  0.2381
## sample estimates:
##      cor 
## -0.02153
```

```r
cor.test(mpfc$gain, mpfc$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$gain and mpfc$TotNumCategUSE
## t = -0.1965, df = 56, p-value = 0.845
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2826  0.2336
## sample estimates:
##      cor 
## -0.02624
```

```r
cor.test(mpfc$gain, mpfc$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$gain and mpfc$TotChildSubjRatUSE
## t = 0.1608, df = 56, p-value = 0.8729
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2381  0.2782
## sample estimates:
##     cor 
## 0.02148
```

```r

cor.test(mpfc$loss, mpfc$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$loss and mpfc$TotEventsExpUSE
## t = -0.0927, df = 56, p-value = 0.9265
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2698  0.2467
## sample estimates:
##      cor 
## -0.01239
```

```r
cor.test(mpfc$loss, mpfc$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$loss and mpfc$TotNumCategUSE
## t = -0.0975, df = 56, p-value = 0.9227
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2704  0.2461
## sample estimates:
##      cor 
## -0.01303
```

```r
cor.test(mpfc$loss, mpfc$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$loss and mpfc$TotChildSubjRatUSE
## t = -0.0541, df = 56, p-value = 0.9571
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2650  0.2515
## sample estimates:
##       cor 
## -0.007228
```

```r

mpfc$gainvnongain = mpfc$gain - mpfc$nongain
mpfc$lossvnonloss = mpfc$loss - mpfc$nonloss

cor.test(mpfc$gainvnongain, mpfc$TotEventsExpUSE)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$gainvnongain and mpfc$TotEventsExpUSE
## t = 1.169, df = 56, p-value = 0.2473
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1082  0.3968
## sample estimates:
##    cor 
## 0.1544
```

```r
cor.test(mpfc$gainvnongain, mpfc$TotNumCategUSE)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$gainvnongain and mpfc$TotNumCategUSE
## t = 1.042, df = 56, p-value = 0.3019
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1248  0.3826
## sample estimates:
##    cor 
## 0.1379
```

```r
cor.test(mpfc$gainvnongain, mpfc$TotChildSubjRatUSE)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$gainvnongain and mpfc$TotChildSubjRatUSE
## t = 0.765, df = 56, p-value = 0.4475
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1608  0.3508
## sample estimates:
##    cor 
## 0.1017
```

```r

cor.test(mpfc$lossvnonloss, mpfc$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$lossvnonloss and mpfc$TotEventsExpUSE
## t = 0.8416, df = 56, p-value = 0.4036
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1509  0.3597
## sample estimates:
##    cor 
## 0.1118
```

```r
cor.test(mpfc$lossvnonloss, mpfc$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$lossvnonloss and mpfc$TotNumCategUSE
## t = 0.8628, df = 56, p-value = 0.392
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1481  0.3621
## sample estimates:
##    cor 
## 0.1145
```

```r
cor.test(mpfc$lossvnonloss, mpfc$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  mpfc$lossvnonloss and mpfc$TotChildSubjRatUSE
## t = 0.7366, df = 56, p-value = 0.4645
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.1645  0.3475
## sample estimates:
##     cor 
## 0.09796
```




```r
summary(lm(mpfc$gainvnongain ~ mpfc$TotEventsExpUSE * mpfc$ss.total, na.action = na.omit))  #ns
```

```
## 
## Call:
## lm(formula = mpfc$gainvnongain ~ mpfc$TotEventsExpUSE * mpfc$ss.total, 
##     na.action = na.omit)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.6951 -0.1828  0.0261  0.1675  0.8713 
## 
## Coefficients:
##                                     Estimate Std. Error t value Pr(>|t|)
## (Intercept)                        -0.329609   0.345425   -0.95     0.34
## mpfc$TotEventsExpUSE                0.057576   0.061889    0.93     0.36
## mpfc$ss.total                       0.006559   0.005082    1.29     0.20
## mpfc$TotEventsExpUSE:mpfc$ss.total -0.000766   0.000915   -0.84     0.41
## 
## Residual standard error: 0.285 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0393,	Adjusted R-squared:  -0.0196 
## F-statistic: 0.667 on 3 and 49 DF,  p-value: 0.576
```

```r
summary(lm(mpfc$gainvnongain ~ mpfc$TotNumCategUSE * mpfc$Sex))  #same pattern as NAcc and insula
```

```
## 
## Call:
## lm(formula = mpfc$gainvnongain ~ mpfc$TotNumCategUSE * mpfc$Sex)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.5767 -0.1878  0.0257  0.1854  0.8756 
## 
## Coefficients:
##                               Estimate Std. Error t value Pr(>|t|)  
## (Intercept)                     0.0799     0.0754    1.06    0.294  
## mpfc$TotNumCategUSE             0.0239     0.0138    1.73    0.090 .
## mpfc$SexM                       0.1192     0.1454    0.82    0.416  
## mpfc$TotNumCategUSE:mpfc$SexM  -0.0517     0.0296   -1.75    0.086 .
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.28 on 54 degrees of freedom
## Multiple R-squared:  0.097,	Adjusted R-squared:  0.0468 
## F-statistic: 1.93 on 3 and 54 DF,  p-value: 0.135
```

```r

m1 = lm(gainvnongain ~ TotNumCategUSE + Sex + TotNumCategUSE:Sex, data = mpfc)
gp = ggplot(data = mpfc, aes(x = TotNumCategUSE, y = gainvnongain, color = factor(Sex)))
gp + geom_point(size = 4) + stat_smooth(method = "lm")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

**MPFC shows the same pattern of activation for outcome of gains > nongain with respect to the interaction between ELS and gender, however, here the effects are not statistically significant.**


```r
summary(lm(mpfc$lossvnonloss ~ mpfc$TotChildSubjRatUSE * mpfc$Age.at.scan))  #ns
```

```
## 
## Call:
## lm(formula = mpfc$lossvnonloss ~ mpfc$TotChildSubjRatUSE * mpfc$Age.at.scan)
## 
## Residuals:
##    Min     1Q Median     3Q    Max 
## -0.519 -0.140 -0.020  0.120  0.824 
## 
## Coefficients:
##                                          Estimate Std. Error t value
## (Intercept)                              -0.04909    0.62559   -0.08
## mpfc$TotChildSubjRatUSE                  -0.01752    0.06819   -0.26
## mpfc$Age.at.scan                          0.00444    0.05352    0.08
## mpfc$TotChildSubjRatUSE:mpfc$Age.at.scan  0.00186    0.00590    0.32
##                                          Pr(>|t|)
## (Intercept)                                  0.94
## mpfc$TotChildSubjRatUSE                      0.80
## mpfc$Age.at.scan                             0.93
## mpfc$TotChildSubjRatUSE:mpfc$Age.at.scan     0.75
## 
## Residual standard error: 0.257 on 54 degrees of freedom
## Multiple R-squared:  0.0154,	Adjusted R-squared:  -0.0392 
## F-statistic: 0.282 on 3 and 54 DF,  p-value: 0.838
```

```r
summary(lm(mpfc$lossvnonloss ~ mpfc$TotChildSubjRatUSE + mpfc$Age.at.scan))  #ns
```

```
## 
## Call:
## lm(formula = mpfc$lossvnonloss ~ mpfc$TotChildSubjRatUSE + mpfc$Age.at.scan)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.5368 -0.1461 -0.0208  0.1233  0.8313 
## 
## Coefficients:
##                         Estimate Std. Error t value Pr(>|t|)
## (Intercept)             -0.19397    0.42181   -0.46     0.65
## mpfc$TotChildSubjRatUSE  0.00395    0.00518    0.76     0.45
## mpfc$Age.at.scan         0.01695    0.03572    0.47     0.64
## 
## Residual standard error: 0.255 on 55 degrees of freedom
## Multiple R-squared:  0.0136,	Adjusted R-squared:  -0.0222 
## F-statistic: 0.38 on 2 and 55 DF,  p-value: 0.686
```

```r

summary(lm(mpfc$lossvnonloss ~ mpfc$ss.total))  #ns
```

```
## 
## Call:
## lm(formula = mpfc$lossvnonloss ~ mpfc$ss.total)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4823 -0.1561 -0.0165  0.1027  0.8139 
## 
## Coefficients:
##                Estimate Std. Error t value Pr(>|t|)
## (Intercept)   -0.012378   0.183220   -0.07     0.95
## mpfc$ss.total  0.000427   0.002767    0.15     0.88
## 
## Residual standard error: 0.258 on 51 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.000467,	Adjusted R-squared:  -0.0191 
## F-statistic: 0.0238 on 1 and 51 DF,  p-value: 0.878
```

```r
summary(lm(mpfc$lossvnonloss ~ mpfc$ss.total * mpfc$TotNumCategUSE))  #ns
```

```
## 
## Call:
## lm(formula = mpfc$lossvnonloss ~ mpfc$ss.total * mpfc$TotNumCategUSE)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4825 -0.1743  0.0037  0.1124  0.8065 
## 
## Coefficients:
##                                    Estimate Std. Error t value Pr(>|t|)
## (Intercept)                        0.306232   0.318709    0.96     0.34
## mpfc$ss.total                     -0.004795   0.004726   -1.01     0.32
## mpfc$TotNumCategUSE               -0.079583   0.062675   -1.27     0.21
## mpfc$ss.total:mpfc$TotNumCategUSE  0.001317   0.000944    1.39     0.17
## 
## Residual standard error: 0.258 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0428,	Adjusted R-squared:  -0.0158 
## F-statistic: 0.73 on 3 and 49 DF,  p-value: 0.539
```

