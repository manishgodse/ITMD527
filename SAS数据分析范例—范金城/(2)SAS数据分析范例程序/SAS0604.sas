SYMBOL V=DOT POINTLABEL;

%LET D1=FJC.DQJYJF(OBS=16);
%LET D2=FJC.DQJYJF(FIRSTOBS=17);
%LET C1=X1-X7;
%LET C2=X1-X7;
%LET B1=D;
%LET B2=D;
%LET F1=X2; %LET G1=X1;
%LET F2=X2; %LET G2=X1;

%MACRO DRIVER(START,END);
%DO I=1 %TO 2;
  %DO CLUS=&START %TO &END;
   TITLE "DATA=&&D&I MAXC=&CLUS";
   PROC FASTCLUS DATA=&&D&I MAXC=&CLUS OUT=CLUSTERS LIST  DISTANCE;
      VAR X1-X7;
	  ID &&B&I;
   RUN;
   TITLE "DATA=&&D&I PLOT &CLUS CLUSTERS";
   PROC GPLOT DATA=CLUSTERS;
   PLOT D*X1=CLUSTER/CFRAME=PINK;
   RUN;
   PROC G3D DATA=CLUSTERS;
   SCATTER &&F&I*&&G&I=CLUSTER;
   RUN;
  %END;
  %END;
%MEND;


%DRIVER(2,10);





