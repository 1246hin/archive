/*2번*/
DATA df1;
INPUT group x @@;
CARDS;
1 9.0 1 9.4 1 4.7 1 4.8 1 8.9 1 4.9 1 8.4 1 5.9 1 6.3 1 5.7
1 5.0 1 3.5 1 7.8 1 10.4 1 8.0 1 8.0 1 8.6 1 7.0 1 6.8 1 7.1
1 5.7 1 7.6 1 6.2 1 7.1 1 7.4 1 8.7 1 4.9 1 7.4 1 6.4 1 7.1
1 6.3 1 8.8 1 8.8 1 5.2 1 7.1 1 5.3 1 4.7 1 8.4 1 6.4 1 8.3
2 12.6 2 14.6 2 16.2 2 23.9 2 23.3 2 17.1 2 20.0 2 21.0 2 19.1 2 19.4
2 16.7 2 15.9 2 15.8 2 16.0 2 17.9 2 13.4 2 19.1 2 16.6 2 18.9 2 18.7
2 20.0 2 17.8 2 13.9 2 22.1 2 13.9 2 18.3 2 22.8 2 13.0 2 17.9 2 15.2
2 17.7 2 15.1 2 16.9 2 16.4 2 22.8 2 19.4 2 19.6 2 18.4 2 18.2 2 20.7
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output2_2.pdf";
PROC TTEST;
     CLASS group;
     VAR x;
RUN;
ods pdf close;


/*5번*/
DATA df2;
INPUT group x @@;
CARDS;
1 22.2 1 97.8 1 29.1 1 37.0 1 35.8 1 44.2 1 82.0 1 56.0 1 9.3 
1 19.9 1 39.5 1 12.8 2 15.1 2 23.2 2 10.5 2 13.9 2 9.7 2 19.0 
2 19.8 2 9.1 2 30.1 2 15.5 2 10.3 2 11.0 3 10.2 3 11.3 3 11.4 
3 5.3 3 14.5 3 11.0 3 13.6 3 33.4 3 25.0 3 27.0 3 36.3 3 17.7
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output2_5.pdf";
PROC UNIVARIATE DATA=df2 NORMAL PLOT;
BY group;
VAR x;
qqplot /normal (mu=est sigma=est);
RUN;
PROC glm data=df2;
class group;
model x=group;
means group / hovtest=levene(type=abs) welch;

run;
ods pdf close;
/*7번*/
data df3;
  do exercise="A", "B", "C", "D", "E";
    do diet=1, 2, 3, 4;
      input x @@;
      output;
    end;
  end;
  datalines;
    7.0 5.3 4.9 8.8
    9.9 5.7 7.6 8.9
    8.5 4.7 5.5 8.1
    5.1 3.5 2.8 3.3
    10.3 7.7 8.4 9.1
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output2_7.pdf";
proc anova data=df3;
  class exercise diet;
  model x=exercise diet;
  means exercise/ SCHEFFE;
  means diet/ SCHEFFE;
run;
ods pdf close;

/*9번*/
data df4;
  do age="15-19", "20-24", "25-29";
  do usage=1, 2, 3;
  do rep=1, 2, 3;
  input x @@;
  output;
  end;
  end;
  end;
cards;
25 28 22 18 23 19 17 24 19
28 32 30 16 24 20 18 22 20
25 35 30 14 16 15 10 8 12
run;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output2_9.pdf";
proc anova data=df4;
     class age usage;
     model x=age usage age*usage;
run;
ods pdf close;

/*1번*/
data tab1;
input danger $ depression $ count;
cards;
1 1 5
1 2 21
2 1 8 
2 2 82
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output3_1.pdf";

proc freq;
tables danger*depression/measures;
weight count;
run; 
ods pdf close;

/*3번*/
data tab2;
input group relapse $ count;
cards;
0 yes 49
0 no 12
1 yes 24
1 no 9
2 yes 2
2 no 29
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output3_3.pdf";
proc freq data=tab2;
weight count;
tables group*relapse/chisq;
run;
ods pdf close;

/*6번*/
data tab3;
input group glasses $ count;
cards;
0 yes 1
0 no 5
1 yes 8
1 no 2
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output3_6.pdf";

proc freq data=tab3;
weight count;
tables group*glasses/exact;
run;
ods pdf close;

/*7번*/
data tab4;
input first $ second $ count @@;
cards;
pos pos 794
pos neg 150
neg pos 86
neg neg 570
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output3_7.pdf";
ods select McNemarsTest;
proc freq order=data;
weight count;
tables first*second/agree;
run;
ods pdf close;

/*8번*/
data tab5;
input severity $ sex $ survival $ count @@;
cards;
0 male dead 2 0 male alive 21
0 female dead 0 0 female alive 10
1 male dead 2 1 male alive 40
1 female dead 0 1 female alive 18
2 male dead 6 2 male alive 33
2 female dead 0 2 female alive 10
3 male dead 17 3 male alive 16
3 female dead 0 3 female alive 4
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output3_8.pdf";
proc freq;
weight count;
tables severity*sex*survival/CMH NOROW NOCOL;
run;
ods pdf close;

/*9번*/
data tab6;
input test $ disease $ count;
cards;
0 0 372
0 1 179
1 0 80
1 1 302
;
ods pdf file="C:\Users\limj\Desktop\KU\과제\output3_9.pdf";
proc sort data=tab6;
by descending test descending disease;
run;
proc freq data=tab6 order=data;
weight count;
tables test*disease / senspec;
run;
ods pdf close;
