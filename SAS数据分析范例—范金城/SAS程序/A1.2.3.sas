PROC EXPAND DATA=FJC.GNSCZZGCS OUT=GNSCZZGC0 FROM=YEAR TO=QTR;
CONVERT X1 X2 X3 X4 X5 X6 X7 X8/OBSERVED=AVERAGE;
ID DATE;
PROC INSIGHT DATA=GNSCZZGC0;
RUN;
