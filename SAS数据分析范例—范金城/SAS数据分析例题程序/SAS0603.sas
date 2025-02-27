%let d1=fjc.gnsczzv;
%let d2=fjc.gnsczzgc;
%let c1=x1-x8;
%let c2=x2-x8;
%let b1=x1; 
%let b2=x2;
%let a1=x3; 
%let a2=x4;
%let e1=x5; 
%let e2=x6;
%let f1=x7; 
%let f2=x8;
    
%macro fastclus(maxc,cframe);
%do i=1 %to 2;
data f&i;
set &&d&i;
run;
%let k=1;
  %let n=%scan(&maxc,&k);
  %do %while(&n ne);
%do least=1 %to 3;
title1 " &&d&i fastclus maxc=&n least=&least cframe=&cframe";
proc fastclus data=f&i summary maxc=&n maxiter=99 converge=0
              outseeds=outseeds&i out=prelim cluster=preclus list least=&least;
   var &&c&i;
   id year;
run;
proc print data=outseeds&i;
run;
proc gplot data=prelim;
plot &&b&i*year=preclus/cframe=&cframe;
plot &&a&i*year=preclus/cframe=&cframe;
plot &&a&i*&&b&i=preclus/cframe=&cframe;
plot &&a&i*&&f&i=preclus/cframe=&cframe;
plot &&b&i*&&e&i=preclus/cframe=&cframe;
symbol v=dot i=none;
run;
proc sort data=prelim;
   by preclus;
   run;
proc print data=prelim(keep=year preclus);
run;
proc fastclus data=outseeds&i summary maxc=4 out=out cluster=c list;
var &&c&i;
run;
title " &&d&i outseeds maxc=&n least=&least cframe=&cframe";
proc gplot data=out;
plot &&f&i*_freq_=c/cframe=&cframe;
plot &&e&i*_freq_=c/cframe=&cframe;
run;
%end;
%let k=%eval(&k+1);
  %let n=%scan(&maxc,&k);
  %end;
%end;
%mend;

%fastclus(5 6 8,pink);
%fastclus(4 7 9,yellow);

