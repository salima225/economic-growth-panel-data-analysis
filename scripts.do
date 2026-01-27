*Analyse univar
encode PAYS,gen(PAYS1)
keep if PAYS1==7|PAYS1==5|PAYS1==3|PAYS1==12
drop M2PIB
drop IMPOPIB
drop IDEPIB
drop PIBCRT
drop PIBRtete
drop GDPcurrentUS

*1
summarize TCPIBRtete
*2
bysort PAYS1 :summarize TCPIBRtete
*3
xtline TCPIBRtete, i(PAYS) t(ANNEES)
*4
xtline TCPIBRtete, overlay i(PAYS) t(ANNEES)
*5
dfuller TCPIBRtete if PAYS2==1
dfuller TCPIBRtete if PAYS2==2
dfuller TCPIBRtete if PAYS2==3
dfuller TCPIBRtete if PAYS2==4
*6
sktest TCPIBRtete if PAYS2==1
sktest TCPIBRtete if PAYS2==2
sktest TCPIBRtete if PAYS2==3
sktest TCPIBRtete if PAYS2==4
*Analyse bivarie
*7
pwcorr TCPIBRtete EXPPPIB,sig
pwcorr TCPIBRtete TCAnnPop ,sig
pwcorr TCPIBRtete TCAnnPop EXPPPIB ,sig
*8
twoway scatter TCPIBRtete TCAnnPop EXPPPIB
twoway scatter TCPIBRtete TCAnnPop 
twoway scatter TCPIBRtete EXPPPIB
*Analyse multivarie
*Analyse multivarie
*serie temporelle
*9
dfuller TCPIBRtete, drift lags(0)
dfuller TCAnnPop , drift lags(0)
dfuller EXPPPIB, drift lags(0)
*10
keep if PAYS2==1
reg TCPIBRtete TCAnnPop EXPPPIB if PAYS2==1
*11(word)
*12
keep if PAYS2==1
predict residus,res
sktest residus
hettest
durbina
ovtest
*Donnees de panel
*13
reg TCPIBRtete TCAnnPop EXPPPIB
xtreg TCPIBRtete TCAnnPop EXPPPIB,fe
estimate store Fixe
xtreg TCPIBRtete TCAnnPop EXPPPIB,re
hausman Fixe
*modele aleatoire
xtreg TCPIBRtete TCAnnPop EXPPPIB,re
*14
*15

