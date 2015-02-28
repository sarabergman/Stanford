ELS, Social Support, and Insula
==================================

bilateral Insula
-----------------


```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
setwd("~/Box Sync/9.9.14/58N_maineffect_HOatlas_union/")
ins = read.csv("ant+out_58subs_bilateralInsula09-Sep-2014.csv")  #Insula - conjuntion of H-O atlas left and right insula with cope14 (ant gain > nongain)
```



```r
library("png")
library("grid")
ins.png = readPNG("~/Box Sync/9.9.14/58N_maineffect_HOatlas_union/insula.png")
grid.raster(ins.png)
```

![plot of chunk nacc image](figure/nacc_image.png) 



```r
boxplot(ins$antgain, ins$antloss, ins$antnongain, ins$antnonloss, ins$gain, 
    ins$loss, ins$nongain, ins$nonloss, names = c("antgain", "antloss", "antnongain", 
        "antnonloss", "gain", "loss", "nongain", "nonloss"), ylab = ("percent signal change in bilateral insula"), 
    las = 2)
```

![plot of chunk boxplot ins](figure/boxplot_ins.png) 



```r
#create dataframe to make bargraphs
ins.pe = c(ins$antgain,ins$antloss,ins$antnongain,ins$antnongain,ins$gain, ins$loss, ins$nongain, ins$nonloss)
condition.2 = c(rep(x = "antgain", times = 58), rep(x = "antloss", times = 58), rep(x = "antnongain", times = 58), rep(x = "antnonloss", times = 58),rep(x = "gain", times = 58), rep(x = "loss", times = 58), rep(x = "nongain", times = 58), rep(x = "nonloss", times = 58))
insbar = data.frame(condition.2,ins.pe)

ins.summary = data.frame(
  condition = levels(insbar$condition.2),
  mean = tapply(insbar$ins.pe, insbar$condition, mean),
  n = tapply(insbar$ins.pe, insbar$condition, length),
  sd = tapply(insbar$ins.pe, insbar$condition, sd)
  )

#calculate standard error of the mean 
ins.summary$sem = ins.summary$sd/sqrt(ins.summary$n) 

#calculate margin of error for CI
alpha = .05 #95% confidence interval
ins.summary$me = qt(1-alpha/2, df = ins.summary$n)*ins.summary$sem

#error bars represent 95% CI
#png('barplot.CI.vSTR.anticipation.png')
g3.CI = ggplot(ins.summary, aes(x = condition, y = mean)) + 
  geom_bar(position = position_dodge(), stat="identity", fill="blue", width=.5) +
  geom_errorbar(aes(ymin=mean-me, ymax=mean+me), width=.3) +
  ggtitle("Reward-Related Insula Activity / (Error bars represent 95% CI)") + # plot title
  geom_hline(yintercept=0, linetype = 1) +
  labs(x = "Anticipation and Outcome", y = "Percent BOLD signal change in Insula") +
  theme_bw() +
  #theme_classic()
  theme(panel.grid.major = element_blank()) # remove x and y major grid lines
print(g3.CI)
```

![plot of chunk ins bar](figure/ins_bar1.png) 

```r
#dev.off()

#error bars represent standard error of the mean
g3.SE = ggplot(ins.summary, aes(x = condition, y = mean)) + 
  geom_bar(position = position_dodge(), stat="identity", fill="blue", width=.5) +
  geom_errorbar(aes(ymin=mean-sem, ymax=mean+sem), width=.3) +
  labs(x = "Anticipation and Outcome", y = "Percent BOLD signal change in Insula") +
  ggtitle("Reward-Related Insula Activity / (Error bars represent SEM)") +
  geom_hline(yintercept=0, linetype = 1) +
  theme_bw() +
  theme(panel.grid.major = element_blank())
print(g3.SE)
```

![plot of chunk ins bar](figure/ins_bar2.png) 


**The anticipatory activation in the insula mirrors that of the NAcc. The insula has been cited as being   region that is activated during the anticipation of loss, but in our sample the insula is not preferentially active for the anticipation of losses; instead it is responding to the anticipatory cues in much the same was as the NAcc. However, the increased response during the receipt of a loss relative to neutral and positive feedback is consistent with prior findings.**


### Anticipation

```r
cor.test(ins$antgain, ins$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgain and ins$TotEventsExpUSE
## t = -0.2743, df = 56, p-value = 0.7848
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2922  0.2238
## sample estimates:
##      cor 
## -0.03663
```

```r
cor.test(ins$antgain, ins$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgain and ins$TotNumCategUSE
## t = -0.2697, df = 56, p-value = 0.7884
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2916  0.2244
## sample estimates:
##      cor 
## -0.03602
```

```r
cor.test(ins$antgain, ins$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgain and ins$TotChildSubjRatUSE
## t = 0.3027, df = 56, p-value = 0.7632
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2202  0.2956
## sample estimates:
##     cor 
## 0.04042
```

```r
cor.test(ins$antgain, ins$ss.total)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgain and ins$ss.total
## t = 0.0285, df = 51, p-value = 0.9774
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2666  0.2740
## sample estimates:
##      cor 
## 0.003985
```

```r

cor.test(ins$antloss, ins$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antloss and ins$TotEventsExpUSE
## t = -0.3613, df = 56, p-value = 0.7192
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3028  0.2127
## sample estimates:
##      cor 
## -0.04823
```

```r
cor.test(ins$antloss, ins$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antloss and ins$TotNumCategUSE
## t = -0.3719, df = 56, p-value = 0.7113
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3040  0.2114
## sample estimates:
##      cor 
## -0.04964
```

```r
cor.test(ins$antloss, ins$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antloss and ins$TotChildSubjRatUSE
## t = 0.0481, df = 56, p-value = 0.9618
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2523  0.2643
## sample estimates:
##      cor 
## 0.006432
```

```r
cor.test(ins$antloss, ins$ss.total)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antloss and ins$ss.total
## t = 0.1846, df = 51, p-value = 0.8542
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2462  0.2941
## sample estimates:
##     cor 
## 0.02585
```

```r
plot(ins$antloss, ins$TotEventsExpUSE)  # example plot, no relation
```

![plot of chunk ins cor ant](figure/ins_cor_ant1.png) 

```r


ins$antgainvnongain = ins$antgain - ins$antnongain
ins$antlossvnonloss = ins$antloss - ins$antnonloss

cor.test(ins$antgainvnongain, ins$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgainvnongain and ins$TotEventsExpUSE
## t = 0.3368, df = 56, p-value = 0.7375
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2158  0.2998
## sample estimates:
##     cor 
## 0.04497
```

```r
cor.test(ins$antgainvnongain, ins$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgainvnongain and ins$TotNumCategUSE
## t = 0.4592, df = 56, p-value = 0.6479
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2002  0.3146
## sample estimates:
##     cor 
## 0.06124
```

```r
cor.test(ins$antgainvnongain, ins$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgainvnongain and ins$TotChildSubjRatUSE
## t = 0.3254, df = 56, p-value = 0.7461
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2173  0.2984
## sample estimates:
##     cor 
## 0.04345
```

```r
cor.test(ins$antgainvnongain, ins$ss.total)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antgainvnongain and ins$ss.total
## t = 0.4786, df = 51, p-value = 0.6343
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2072  0.3312
## sample estimates:
##     cor 
## 0.06687
```

```r

# summary(lm(ins$TotChildSubjRatUSE ~ ins$antgainvnongain)) #same as above

plot(ins$antlossvnonloss, ins$TotEventsExpUSE)
```

![plot of chunk ins cor ant](figure/ins_cor_ant2.png) 

```r
cor.test(ins$antlossvnonloss, ins$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antlossvnonloss and ins$TotEventsExpUSE
## t = 0.2738, df = 56, p-value = 0.7852
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2238  0.2921
## sample estimates:
##     cor 
## 0.03657
```

```r
cor.test(ins$antlossvnonloss, ins$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antlossvnonloss and ins$TotNumCategUSE
## t = 0.2713, df = 56, p-value = 0.7872
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2242  0.2918
## sample estimates:
##     cor 
## 0.03623
```

```r
cor.test(ins$antlossvnonloss, ins$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$antlossvnonloss and ins$TotChildSubjRatUSE
## t = 0.3476, df = 56, p-value = 0.7295
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2145  0.3011
## sample estimates:
##    cor 
## 0.0464
```

```r
summary(lm(ins$antlossvnonloss ~ ins$TotNumCategUSE * ins$Age.at.scan))  #ns
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$TotNumCategUSE * ins$Age.at.scan)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.3804 -0.1297 -0.0177  0.1192  0.4325 
## 
## Coefficients:
##                                    Estimate Std. Error t value Pr(>|t|)
## (Intercept)                         0.22221    0.54898    0.40     0.69
## ins$TotNumCategUSE                 -0.14239    0.10564   -1.35     0.18
## ins$Age.at.scan                    -0.01557    0.04657   -0.33     0.74
## ins$TotNumCategUSE:ins$Age.at.scan  0.01241    0.00899    1.38     0.17
## 
## Residual standard error: 0.195 on 54 degrees of freedom
## Multiple R-squared:  0.0655,	Adjusted R-squared:  0.0136 
## F-statistic: 1.26 on 3 and 54 DF,  p-value: 0.297
```

```r
summary(lm(ins$antlossvnonloss ~ ins$TotEventsExpUSE * ins$Sex))  #ns
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$TotEventsExpUSE * ins$Sex)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4154 -0.1074 -0.0270  0.0924  0.4615 
## 
## Coefficients:
##                              Estimate Std. Error t value Pr(>|t|)
## (Intercept)                   0.00979    0.05066    0.19     0.85
## ins$TotEventsExpUSE           0.00663    0.00807    0.82     0.41
## ins$SexM                      0.12798    0.09956    1.29     0.20
## ins$TotEventsExpUSE:ins$SexM -0.02453    0.01888   -1.30     0.20
## 
## Residual standard error: 0.198 on 54 degrees of freedom
## Multiple R-squared:  0.0338,	Adjusted R-squared:  -0.0198 
## F-statistic: 0.631 on 3 and 54 DF,  p-value: 0.598
```

**There is no significant effect of ELS on bilateral insula activation during the anticipation phase of the task.**



```r
summary(lm(ins$antlossvnonloss ~ ins$ss.total))
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$ss.total)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4601 -0.1107 -0.0108  0.1034  0.4713 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)  
## (Intercept)  -0.22062    0.13655   -1.62    0.112  
## ins$ss.total  0.00421    0.00206    2.04    0.046 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.192 on 51 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0756,	Adjusted R-squared:  0.0575 
## F-statistic: 4.17 on 1 and 51 DF,  p-value: 0.0463
```

```r
summary(lm(ins$antlossvnonloss ~ ins$ss.total + ins$Sex))
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$ss.total + ins$Sex)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4525 -0.1027 -0.0104  0.0911  0.4791 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)  
## (Intercept)  -0.23369    0.14164   -1.65    0.105  
## ins$ss.total  0.00428    0.00209    2.05    0.045 *
## ins$SexM      0.02153    0.05465    0.39    0.695  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.194 on 50 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0784,	Adjusted R-squared:  0.0416 
## F-statistic: 2.13 on 2 and 50 DF,  p-value: 0.13
```

```r
summary(lm(ins$antlossvnonloss ~ ins$ss.total + ins$Age.at.scan))
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$ss.total + ins$Age.at.scan)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4318 -0.0987 -0.0063  0.0870  0.4519 
## 
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)  
## (Intercept)     -0.49428    0.33624   -1.47    0.148  
## ins$ss.total     0.00393    0.00209    1.88    0.066 .
## ins$Age.at.scan  0.02502    0.02808    0.89    0.377  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.193 on 50 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.09,	Adjusted R-squared:  0.0536 
## F-statistic: 2.47 on 2 and 50 DF,  p-value: 0.0945
```

```r

ggplot(ins, aes(x = ss.total, y = antlossvnonloss)) + geom_point(size = 4, color = "blue") + 
    theme_bw() + theme(panel.grid.major = element_blank(), plot.title = element_text(size = 15, 
    hjust = 0.5)) + labs(x = "Social Support", y = "Percent BOLD signal change \n Anticipation of Loss - Nonloss") + 
    ggtitle("Insula Activity \n During Anticipation of Loss>Nonloss \n is Correlated with Social Support") + 
    geom_smooth(method = lm, color = "black")
```

```
## Warning: Removed 5 rows containing missing values (stat_smooth). Warning:
## Removed 5 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

```r

summary(lm(ins$antlossvnonloss ~ ins$ss.total * ins$TotEventsExpUSE, na.action = na.omit))
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$ss.total * ins$TotEventsExpUSE, 
##     na.action = na.omit)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4683 -0.0988 -0.0069  0.0847  0.4533 
## 
## Coefficients:
##                                   Estimate Std. Error t value Pr(>|t|)
## (Intercept)                      -0.146812   0.237066   -0.62     0.54
## ins$ss.total                      0.003152   0.003488    0.90     0.37
## ins$TotEventsExpUSE              -0.016345   0.042475   -0.38     0.70
## ins$ss.total:ins$TotEventsExpUSE  0.000237   0.000628    0.38     0.71
## 
## Residual standard error: 0.196 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0784,	Adjusted R-squared:  0.0219 
## F-statistic: 1.39 on 3 and 49 DF,  p-value: 0.257
```

```r
summary(lm(ins$antlossvnonloss ~ ins$ss.total * ins$TotNumCategUSE, na.action = na.omit))
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$ss.total * ins$TotNumCategUSE, 
##     na.action = na.omit)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4640 -0.1070 -0.0105  0.0939  0.4588 
## 
## Coefficients:
##                                  Estimate Std. Error t value Pr(>|t|)
## (Intercept)                     -0.187533   0.242650   -0.77     0.44
## ins$ss.total                     0.003700   0.003598    1.03     0.31
## ins$TotNumCategUSE              -0.008108   0.047718   -0.17     0.87
## ins$ss.total:ins$TotNumCategUSE  0.000127   0.000719    0.18     0.86
## 
## Residual standard error: 0.196 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0762,	Adjusted R-squared:  0.0196 
## F-statistic: 1.35 on 3 and 49 DF,  p-value: 0.27
```

```r
summary(lm(ins$antlossvnonloss ~ ins$ss.total * ins$TotChildSubjRatUSE, na.action = na.omit))
```

```
## 
## Call:
## lm(formula = ins$antlossvnonloss ~ ins$ss.total * ins$TotChildSubjRatUSE, 
##     na.action = na.omit)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.4563 -0.1090 -0.0088  0.0995  0.4835 
## 
## Coefficients:
##                                      Estimate Std. Error t value Pr(>|t|)
## (Intercept)                         -2.18e-01   1.94e-01   -1.13     0.27
## ins$ss.total                         4.25e-03   2.98e-03    1.43     0.16
## ins$TotChildSubjRatUSE              -3.98e-04   2.17e-02   -0.02     0.99
## ins$ss.total:ins$TotChildSubjRatUSE -5.75e-06   3.38e-04   -0.02     0.99
## 
## Residual standard error: 0.196 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0761,	Adjusted R-squared:  0.0195 
## F-statistic: 1.35 on 3 and 49 DF,  p-value: 0.271
```

### However, anticipation of loss relative to nonloss is significantly correlated with social support: greater social support is associated with greater insula activation during the anticipation of loss compared to nonloss (r = .27, p = .046). This effect holds when controlling for gender, but becomes marginal (p = .066) when controlling for age. This same pattern of results was seen in the NAcc.


###Outcome


```r
plot(ins$gain, ins$TotChildSubjRatUSE)
```

![plot of chunk ins cor outcome](figure/ins_cor_outcome.png) 

```r
cor.test(ins$gain, ins$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$gain and ins$TotEventsExpUSE
## t = 1.502, df = 56, p-value = 0.1388
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.06484  0.43304
## sample estimates:
##    cor 
## 0.1967
```

```r
cor.test(ins$gain, ins$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$gain and ins$TotNumCategUSE
## t = 1.48, df = 56, p-value = 0.1444
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.06762  0.43077
## sample estimates:
##    cor 
## 0.1941
```

```r
cor.test(ins$gain, ins$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$gain and ins$TotChildSubjRatUSE
## t = 1.54, df = 56, p-value = 0.1293
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.0599  0.4371
## sample estimates:
##    cor 
## 0.2015
```

```r

cor.test(ins$loss, ins$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$loss and ins$TotEventsExpUSE
## t = -0.2952, df = 56, p-value = 0.7689
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2947  0.2211
## sample estimates:
##      cor 
## -0.03942
```

```r
cor.test(ins$loss, ins$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$loss and ins$TotNumCategUSE
## t = -0.2655, df = 56, p-value = 0.7916
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2911  0.2249
## sample estimates:
##      cor 
## -0.03545
```

```r
cor.test(ins$loss, ins$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$loss and ins$TotChildSubjRatUSE
## t = -1e-04, df = 56, p-value = 0.9999
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.2583  0.2583
## sample estimates:
##        cor 
## -9.058e-06
```

```r

ins$gainvnongain = ins$gain - ins$nongain
ins$lossvnonloss = ins$loss - ins$nonloss

cor.test(ins$gainvnongain, ins$TotEventsExpUSE)  # r = .31, p = .017
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$gainvnongain and ins$TotEventsExpUSE
## t = 2.466, df = 56, p-value = 0.01676
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.05947 0.52853
## sample estimates:
##   cor 
## 0.313
```

```r
cor.test(ins$gainvnongain, ins$TotNumCategUSE)  # r = .30, p = .02
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$gainvnongain and ins$TotNumCategUSE
## t = 2.38, df = 56, p-value = 0.02075
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.04857 0.52061
## sample estimates:
##    cor 
## 0.3031
```

```r
cor.test(ins$gainvnongain, ins$TotChildSubjRatUSE)  #r = .28, p = .03
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$gainvnongain and ins$TotChildSubjRatUSE
## t = 2.222, df = 56, p-value = 0.03033
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.02845 0.50576
## sample estimates:
##    cor 
## 0.2847
```

```r

cor.test(ins$lossvnonloss, ins$TotEventsExpUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$lossvnonloss and ins$TotEventsExpUSE
## t = -0.9, df = 56, p-value = 0.372
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3664  0.1433
## sample estimates:
##     cor 
## -0.1194
```

```r
cor.test(ins$lossvnonloss, ins$TotNumCategUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$lossvnonloss and ins$TotNumCategUSE
## t = -0.8802, df = 56, p-value = 0.3825
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3641  0.1459
## sample estimates:
##     cor 
## -0.1168
```

```r
cor.test(ins$lossvnonloss, ins$TotChildSubjRatUSE)  #ns
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ins$lossvnonloss and ins$TotChildSubjRatUSE
## t = -0.3916, df = 56, p-value = 0.6968
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  -0.3064  0.2089
## sample estimates:
##      cor 
## -0.05226
```


### Greater ELS is significantly related to increased activation in bilateral insula during receipt of gains relative to nongain (r = .31, p = .017 for number of stressful events, other factors show similar statistic). Interestingly, the same is not true for the receipt of losses relative to nonloss.


```r
summary(lm(ins$gainvnongain ~ ins$TotEventsExpUSE * ins$ss.total, na.action = na.omit))  #ns
```

```
## 
## Call:
## lm(formula = ins$gainvnongain ~ ins$TotEventsExpUSE * ins$ss.total, 
##     na.action = na.omit)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.2739 -0.1276 -0.0071  0.1160  0.5036 
## 
## Coefficients:
##                                   Estimate Std. Error t value Pr(>|t|)
## (Intercept)                      -0.073136   0.196270   -0.37     0.71
## ins$TotEventsExpUSE               0.028680   0.035165    0.82     0.42
## ins$ss.total                     -0.000813   0.002888   -0.28     0.78
## ins$TotEventsExpUSE:ins$ss.total -0.000155   0.000520   -0.30     0.77
## 
## Residual standard error: 0.162 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.145,	Adjusted R-squared:  0.0923 
## F-statistic: 2.76 on 3 and 49 DF,  p-value: 0.0519
```

```r
summary(lm(ins$gainvnongain ~ ins$TotNumCategUSE * ins$Sex))  #significant with all 3 ELS variables - but number of ELS categories is the most significant.
```

```
## 
## Call:
## lm(formula = ins$gainvnongain ~ ins$TotNumCategUSE * ins$Sex)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.2694 -0.1011 -0.0079  0.0773  0.4924 
## 
## Coefficients:
##                             Estimate Std. Error t value Pr(>|t|)   
## (Intercept)                 -0.11399    0.04098   -2.78   0.0074 **
## ins$TotNumCategUSE           0.02402    0.00751    3.20   0.0023 **
## ins$SexM                     0.07645    0.07903    0.97   0.3376   
## ins$TotNumCategUSE:ins$SexM -0.03550    0.01607   -2.21   0.0314 * 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.152 on 54 degrees of freedom
## Multiple R-squared:  0.208,	Adjusted R-squared:  0.163 
## F-statistic: 4.71 on 3 and 54 DF,  p-value: 0.0054
```

```r

m1 = lm(gainvnongain ~ TotNumCategUSE + Sex + TotNumCategUSE:Sex, data = ins)
gp = ggplot(data = ins, aes(x = TotNumCategUSE, y = gainvnongain, color = factor(Sex)))
gp + geom_point(size = 4) + stat_smooth(method = "lm")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


### Again, we see a parallel between the NAcc and the insula, where ELS has differential effects during the receipt of gains relative to nongains for males and females.


```r
summary(lm(ins$lossvnonloss ~ ins$TotChildSubjRatUSE * ins$Age.at.scan))  #ns
```

```
## 
## Call:
## lm(formula = ins$lossvnonloss ~ ins$TotChildSubjRatUSE * ins$Age.at.scan)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.2624 -0.1262 -0.0162  0.0736  0.6948 
## 
## Coefficients:
##                                        Estimate Std. Error t value
## (Intercept)                            -0.13116    0.48819   -0.27
## ins$TotChildSubjRatUSE                  0.00190    0.05321    0.04
## ins$Age.at.scan                         0.02590    0.04177    0.62
## ins$TotChildSubjRatUSE:ins$Age.at.scan -0.00028    0.00460   -0.06
##                                        Pr(>|t|)
## (Intercept)                                0.79
## ins$TotChildSubjRatUSE                     0.97
## ins$Age.at.scan                            0.54
## ins$TotChildSubjRatUSE:ins$Age.at.scan     0.95
## 
## Residual standard error: 0.201 on 54 degrees of freedom
## Multiple R-squared:  0.0161,	Adjusted R-squared:  -0.0385 
## F-statistic: 0.295 on 3 and 54 DF,  p-value: 0.829
```

```r
summary(lm(ins$lossvnonloss ~ ins$TotChildSubjRatUSE + ins$Age.at.scan))  #ns
```

```
## 
## Call:
## lm(formula = ins$lossvnonloss ~ ins$TotChildSubjRatUSE + ins$Age.at.scan)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.2620 -0.1268 -0.0164  0.0721  0.6936 
## 
## Coefficients:
##                        Estimate Std. Error t value Pr(>|t|)
## (Intercept)            -0.10938    0.32888   -0.33     0.74
## ins$TotChildSubjRatUSE -0.00133    0.00404   -0.33     0.74
## ins$Age.at.scan         0.02402    0.02785    0.86     0.39
## 
## Residual standard error: 0.199 on 55 degrees of freedom
## Multiple R-squared:  0.016,	Adjusted R-squared:  -0.0197 
## F-statistic: 0.448 on 2 and 55 DF,  p-value: 0.641
```

```r

summary(lm(ins$lossvnonloss ~ ins$ss.total))  #ns
```

```
## 
## Call:
## lm(formula = ins$lossvnonloss ~ ins$ss.total)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.2709 -0.1399 -0.0375  0.1020  0.7008 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)
## (Intercept)   0.08266    0.14181    0.58     0.56
## ins$ss.total  0.00107    0.00214    0.50     0.62
## 
## Residual standard error: 0.2 on 51 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.00491,	Adjusted R-squared:  -0.0146 
## F-statistic: 0.251 on 1 and 51 DF,  p-value: 0.618
```

```r
summary(lm(ins$lossvnonloss ~ ins$ss.total * ins$TotChildSubjRatUSE))  #ns
```

```
## 
## Call:
## lm(formula = ins$lossvnonloss ~ ins$ss.total * ins$TotChildSubjRatUSE)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -0.2540 -0.1520 -0.0437  0.1216  0.6808 
## 
## Coefficients:
##                                      Estimate Std. Error t value Pr(>|t|)
## (Intercept)                          0.028546   0.198509    0.14     0.89
## ins$ss.total                         0.002438   0.003055    0.80     0.43
## ins$TotChildSubjRatUSE               0.008551   0.022180    0.39     0.70
## ins$ss.total:ins$TotChildSubjRatUSE -0.000214   0.000346   -0.62     0.54
## 
## Residual standard error: 0.201 on 49 degrees of freedom
##   (5 observations deleted due to missingness)
## Multiple R-squared:  0.0327,	Adjusted R-squared:  -0.0265 
## F-statistic: 0.552 on 3 and 49 DF,  p-value: 0.649
```

