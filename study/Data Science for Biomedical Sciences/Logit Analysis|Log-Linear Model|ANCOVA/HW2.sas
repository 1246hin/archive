/*4-1*/
data dat1;
input residence $ arrest $ imprison $ count @@;
cards;
no yes yes 42
no no yes 17
yes yes yes 33
yes no yes 53
no yes no 109
no no no 75
yes yes no 175
yes no no 359
;
proc logistic descending;
freq count;
class residence arrest;
model imprison=residence arrest/scale=none aggregate;
run;

/*4-5*/
data dat2;
input mental social incident @@;
cards;
4 1 1
4 1 9
4 1 4
4 1 3
4 0 2
4 1 0
4 0 1
4 1 3
4 1 3
4 1 7
4 0 1
4 0 2
3 1 5
3 0 6
3 1 3
3 0 1
3 1 8
3 1 2 
3 0 5
3 1 5
3 1 9
3 0 3
3 1 3
3 1 1
2 0 0
2 1 4
2 0 3
2 0 9
2 1 6
2 0 4
2 0 3
1 1 8
1 1 2
1 1 7
1 0 5
1 0 4
1 0 4
1 1 8
1 0 8
1 0 9
;
proc logistic order=data;
class social;
model mental=social incident/scale=none aggregate;
output out=prob pred=p;
run;

proc print data=prob(obs=10);
run;

/*4-7*/
data dat3;
input seatbelt $  bounce $ survival $ count @@;
cards;
yes yes yes 659
yes yes no 270
yes no yes 532
yes no no 347
no yes yes 432
no yes no 532
no no yes 269
no no no 552
;
proc catmod order=data;
weight count;
model seatbelt*bounce*survival=_response_/noiter pred=freq;
loglin seatbelt*bounce*survival;
loglin seatbelt|bounce seatbelt|survival bounce|survival;
loglin seatbelt bounce|survival;
loglin bounce seatbelt|survival;
loglin survival seatbelt|bounce;
run;
proc logistic descending;
freq count;
class seatbelt bounce;
model survival=seatbelt bounce/scale=none aggregate;
run;


/*4-9*/
data dat4;
input time $ gender $ school $ count @@;
cards;
0 male academic 34
0 male business 64
0 female academic 49
0 female business 135
0~0.5 male academic 29
0~0.5 male business 61
0~0.5 female academic 31
0~0.5 female business 118
0.5~1 male academic 40
0.5~1 male business 81
0.5~1 female academic 37
0.5~1 female business 142
1~2 male academic 37
1~2 male business 65
1~2 female academic 32
1~2 female business 64
2~4 male academic 24
2~4 male business 40
2~4 female academic 11
2~4 female business 37
4~6 male academic 6
4~6 male business 15
4~6 female academic 0
4~6 female business 3
6< male academic 3
6< male business 7
6< female academic 4
6< female business 2
;
proc catmod order=data;
weight count;
model time*gender*school=_response_/noiter pred=freq;

/*loglin time|gender time|school gender|school;
loglin time|gender gender|school time;*/
loglin time|gender time|school gender
run;

data dat4_1;
input time $ gender $ school $ count @@;
cards;
0.5> male academic 34
0.5> male business 64
0.5> female academic 49
0.5> female business 135
0.5> male academic 29
0.5> male business 61
0.5> female academic 31
0.5> female business 118
0.5~2 male academic 40
0.5~2 male business 81
0.5~2 female academic 37
0.5~2 female business 142
0.5~2 male academic 37
0.5~2 male business 65
0.5~2 female academic 32
0.5~2 female business 64
2< male academic 24
2< male business 40
2< female academic 11
2< female business 37
2< male academic 6
2< male business 15
2< female academic 0
2< female business 3
2< male academic 3
2< male business 7
2< female academic 4
2< female business 2
;
proc catmod order=data;
weight count;
model time*gender*school=_response_/noiter pred=freq;
loglin time|gender gender|school time;
run;

/*5-2*/
data dat5_2;
input trt x y @@;
cards;
1 29 39
1 4 34
1 18 36
2 17 35
2 35 38
2 3 32
3 1 38
3 15 43
3 32 44
;
proc glm;
class trt;
model y=trt x trt*x /solution;
lsmeans trt/tdiff;
run;
proc glm;
class trt;
model y=trt x /solution;
lsmeans trt/tdiff;
run;

/*5-7*/
data dat5_7;
input trt x1 x2 y @@;
cards;
1 99 12 58 1 95 11 55 1 99 13 59 1 99 13 55 1 102 12 60
1 101 12 57 1 102 12 57 1 103 13 61 1 102 13 58 1 103 14 59
1 102 14 62 1 104 13 59 1 106 15 60 1 106 13 62 1 107 13 60
1 108 12 62 1 109 13 64 1 111 13 63 1 110 13 59 1 113 13 63
2 95 12 58 2 97 12 55 2 100 13 60 2 100 13 55 2 102 13 60
2 105 12 58 2 102 13 57 2 102 14 62 2 105 12 58 2 105 13 61 
2 106 14 63 2 109 13 59 2 107 14 61 2 108 14 64 2 111 14 61 
2 108 13 63 2 111 13 65 2 113 14 64 2 114 13 62 2 114 14 60
3 94 12 59 3 95 12 56 3 99 13 62 3 99 11 57 3 99 14 61  
3 102 12 60 3 99 13 58 3 101 13 63 3 104 13 60 3 101 14 63
3 104 15 65 3 107 13 61 3 107 13 62 3 106 14 64 3 109 14 61 
3 107 14 65 3 109 14 63 3 111 14 66 3 111 14 62 3 112 13 64
;
run;
proc glm;
class trt;
model y=trt x1 x2 trt*x1 trt*x2 /solution;
lsmeans trt/stderr;
run;
proc glm;
class trt;
model y=trt x1 x2 /solution;
lsmeans trt/stderr;
run;
