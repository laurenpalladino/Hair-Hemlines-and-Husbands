library(readr)
library(dplyr)
library(survey)
library(ggplot2)
library(stargazer)
lauren600 <- read_csv("Documents/POL 600/Undergrad data.csv")
head(lauren600) 
names(lauren600)

lauren600$attack <- as.factor(NA)
levels(lauren600$attack) <- c("control attack", "white attack", "black attack")
lauren600$attack[lauren600$condition=="CAWN"] <- "control attack"
lauren600$attack[lauren600$condition=="CABN"] <- "control attack"
lauren600$attack[lauren600$condition=="WAWN"] <- "white attack"
lauren600$attack[lauren600$condition=="WABN"] <- "white attack"
lauren600$attack[lauren600$condition=="BAWN"] <- "black attack"
lauren600$attack[lauren600$condition=="BABN"] <- "black attack"
table(lauren600$attack)

lauren600$candidate_race <- as.factor(NA)
levels(lauren600$candidate_race) <- c("White cue", "Black cue")
lauren600$candidate_race[lauren600$candidate_name=="Susan Johnson"] <- "White cue"
lauren600$candidate_race[lauren600$candidate_name=="Althea Johnson"] <- "Black cue"
table(lauren600$candidate_race)

table(lauren600$attack, lauren600$candidate_race)

#competent
lauren600$dv1 <- dplyr::recode(lauren600$Q2.8, "1"=1, "2"=0.75, "3"=0.5, "4"=0.25, "5"=0)
table(lauren600$dv1)

m1 <- lm(dv1 ~ -1 +attack, data=lauren600)
summary(m1) 

m2 <- lm(dv1 ~ -1 +candidate_race, data=lauren600)
summary(m2) 

m3 <- lm(dv1 ~ attack*candidate_race, data=lauren600)
summary(m3) 

lauren600_survey <- svydesign(ids = ~1, data=lauren600)
m3_survey <- svyby(~dv1, ~attack + ~candidate_race, lauren600_survey, svymean, na.rm=TRUE, vartype=c("se","ci"))

displayprefs <- theme(panel.grid.minor=element_blank(), panel.grid.major.x=element_blank(), 
                      axis.title.x=element_blank(), 
                      plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"), legend.position="none")

ggplot(m3_survey, aes(x=candidate_race, y=dv1)) +
  geom_point() +
  geom_pointrange(aes(ymin=ci_l, ymax=ci_u), size=0.75) +
  facet_grid(.~attack) +
  scale_y_continuous(name="Perceived competence", limits=c(0,1)) + 
  scale_x_discrete(name="Candidate racial cue", labels=c("White cue", "Black cue")) + 
  theme_bw() + displayprefs


#honesty
lauren600$dv2 <- dplyr::recode(lauren600$Q2.9, "1"=1, "2"=0.75, "3"=0.5, "4"=0.25, "5"=0)
table(lauren600$dv2)

m4 <- lm(dv2 ~ -1 +attack, data=lauren600)
summary(m4) 

m5 <- lm(dv2 ~  -1 + candidate_race, data=lauren600)
summary(m5) 

m6 <- lm(dv2 ~ attack*candidate_race, data=lauren600)
summary(m6) 

lauren600_survey <- svydesign(ids = ~1, data=lauren600)
honest_survey <- svyby(~dv2, ~attack + ~candidate_race, lauren600_survey, svymean, na.rm=TRUE, vartype=c("se","ci"))

displayprefs <- theme(panel.grid.minor=element_blank(), panel.grid.major.x=element_blank(), 
                      axis.title.x=element_blank(), 
                      plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"), legend.position="none")

ggplot(honest_survey, aes(x=candidate_race, y=dv2)) +
  geom_point() +
  geom_pointrange(aes(ymin=ci_l, ymax=ci_u), size=0.75) +
  facet_grid(.~attack) +
  scale_y_continuous(name="Perceived honesty", limits=c(0,1)) + 
  scale_x_discrete(name="Candidate racial cue", labels=c("White cue", "Black cue")) + 
  theme_bw() + displayprefs

#concern
lauren600$dv3 <- dplyr::recode(lauren600$Q2.10, "1"=1, "2"=0.75, "3"=0.5, "4"=0.25, "5"=0)
table(lauren600$dv3)

m7 <- lm(dv3 ~ -1 + attack, data=lauren600)
summary(m7) 

m8 <- lm(dv3 ~ -1 + candidate_race, data=lauren600)
summary(m8) 

m9 <- lm(dv3 ~ attack*candidate_race, data=lauren600)
summary(m9) 

lauren600_survey <- svydesign(ids = ~1, data=lauren600)
concern_survey <- svyby(~dv3, ~attack + ~candidate_race, lauren600_survey, svymean, na.rm=TRUE, vartype=c("se","ci"))

displayprefs <- theme(panel.grid.minor=element_blank(), panel.grid.major.x=element_blank(), 
                      axis.title.x=element_blank(), 
                      plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"), legend.position="none")

ggplot(concern_survey, aes(x=candidate_race, y=dv3)) +
  geom_point() +
  geom_pointrange(aes(ymin=ci_l, ymax=ci_u), size=0.75) +
  facet_grid(.~attack) +
  scale_y_continuous(name="Perceived concern", limits=c(0,1)) + 
  scale_x_discrete(name="Candidate racial cue", labels=c("White cue", "Black cue")) + 
  theme_bw() + displayprefs

#reliable
lauren600$dv4 <- dplyr::recode(lauren600$Q2.11, "1"=1, "2"=0.75, "3"=0.5, "4"=0.25, "5"=0)
table(lauren600$dv4)

m10 <- lm(dv4 ~ -1 + attack, data=lauren600)
summary(m10) 

m11 <- lm(dv4 ~  -1 + candidate_race, data=lauren600)
summary(m11) 

m12 <- lm(dv4 ~ attack*candidate_race, data=lauren600)
summary(m12) 

lauren600_survey <- svydesign(ids = ~1, data=lauren600)
reliable_survey <- svyby(~dv4, ~attack + ~candidate_race, lauren600_survey, svymean, na.rm=TRUE, vartype=c("se","ci"))

displayprefs <- theme(panel.grid.minor=element_blank(), panel.grid.major.x=element_blank(), 
                      axis.title.x=element_blank(), 
                      plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"), legend.position="none")

ggplot(reliable_survey, aes(x=candidate_race, y=dv4)) +
  geom_point() +
  geom_pointrange(aes(ymin=ci_l, ymax=ci_u), size=0.75) +
  facet_grid(.~attack) +
  scale_y_continuous(name="Perceived concern", limits=c(0,1)) + 
  scale_x_discrete(name="Candidate racial cue", labels=c("White cue", "Black cue")) + 
  theme_bw() + displayprefs

#same values
lauren600$dv5 <- dplyr::recode(lauren600$Q2.12, "1"=1, "2"=0.75, "3"=0.5, "4"=0.25, "5"=0)
table(lauren600$dv5)

m13 <- lm(dv5 ~ -1 + attack, data=lauren600)
summary(m13) 

m14 <- lm(dv5 ~ -1 + candidate_race, data=lauren600)
summary(m14) 

m15 <- lm(dv5 ~ attack*candidate_race, data=lauren600)
summary(m15) 

lauren600_survey <- svydesign(ids = ~1, data=lauren600)
values_survey <- svyby(~dv5, ~attack + ~candidate_race, lauren600_survey, svymean, na.rm=TRUE, vartype=c("se","ci"))

displayprefs <- theme(panel.grid.minor=element_blank(), panel.grid.major.x=element_blank(), 
                      axis.title.x=element_blank(), 
                      plot.margin=unit(c(0.5,0.5,0.5,0.5), "cm"), legend.position="none")

ggplot(values_survey, aes(x=candidate_race, y=dv5)) +
  geom_point() +
  geom_pointrange(aes(ymin=ci_l, ymax=ci_u), size=0.75) +
  facet_grid(.~attack) +
  scale_y_continuous(name="Share the same values", limits=c(0,1)) + 
  scale_x_discrete(name="Candidate racial cue", labels=c("White cue", "Black cue")) + 
  theme_bw() + displayprefs

hs<-(lauren600$`Hostile Sexism 1`+ lauren600$`Hostile Sexism 2` + lauren600$`Hostile Sexism 3`)
table(hs)

rr2<- dplyr::recode(lauren600$`RR 2`, "1"=5, "2"=4, "3"=3, "4"=2, "5"=1 )
rr3<- dplyr::recode(lauren600$`RR 3`, "1"=5, "2"=4, "3"=3, "4"=2, "5"=1 )

rr<-(lauren600$`RR 1` + rr2 + rr3 + lauren600$`RR 4`)
table(rr)

intmodel <- lm(dv5 ~ rr*hs, data=lauren600)
summary(intmodel)

#composite measure of trust
trust600 <- (lauren600$dv1 + lauren600$dv2 + lauren600$dv3 + lauren600$dv4 + lauren600$dv5)
table(trust600)

trustlm600 <- lm(trust600~candidate_race*attack + hs+ rr, data=lauren600)
summary(trustlm600)
stargazer(m3, m6, m9, m12, m15)

undergradinteract <- effect('candidate_race*attack', trustlm600, se=TRUE)
undergraddf<-as.data.frame(undergradinteract)
undergraddf$attack <- factor(undergraddf$attack,  
                               level=c("control attack", "white attack", "black attack"),    
                               labels=c("control attack", "white attack", "black attack"))   
undergraddf$candidate_race <- factor(undergraddf$candidate_race,
                             level=c("White cue", "Black cue"),   
                             labels=c("White cue", "Black cue"))
undergradplot<-ggplot(data=undergraddf, aes(x=attack, y=fit, group=candidate_race))+
  geom_line(size=2, aes(color=candidate_race))+
  geom_ribbon(aes(ymin=fit-se, ymax=fit+se,fill=candidate_race),alpha=.2)+
  ylab("Trust")+
  xlab("Attack Type")+
  theme_bw()+
  theme(text = element_text(size=12),
        legend.text = element_text(size=12),
        legend.direction = "horizontal",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position="top")
undergradplot

