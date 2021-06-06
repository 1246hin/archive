/*6-3*/
data dat3;
input Gender Trt1_Hr_10 Trt1_Hr_20 Trt1_Hr_30 Trt1_Hr_40
             Trt2_Hr_10 Trt2_Hr_20 Trt2_Hr_30 Trt2_Hr_40 @@;
cards;
1 21.3 21.1 22.6 24.2 21.1 22.1 31.3 25.2
1 22.1 22.6 25.2 26.8 22.6 26.2 30.5 26.2
1 21.6 25.2 25.7 28.2 34.1 31.9 27.9 25.9
1 24.7 25.7 26.2 27.9 28.2 35.6 26.5 30.2
1 22.6 24.1 23.8 24.5 29.2 29.6 30.5 33.1
2 27.3 20.1 20.1 24.1 28.9 29.5 26.3 23.7
2 22.6 26.5 30.4 26.8 29.2 28.5 25.9 26.2
2 24.2 23.6 24.2 27.2 30.2 30.1 33.2 25.2
2 26.7 23.7 25.2 27.5 27.6 26.5 31.0 22.6
2 22.3 28.2 28.1 24.7 25.6 29.3 29.9 32.9
;
proc glm;
class Gender;
model Trt1_Hr_10--Trt2_Hr_40=Gender/nouni SS3;
repeated Trt 2(1 2), Hr 4(10 20 30 40)/printe;
run;

/*6-6*/
data dat6;
input m0 m1 m2 m3 m4 trt $ @@;
cards;
190 212 213 195 248 N
187 177 200 190 206 P
98 137 185 215 225 N
205 230 172 196 232 P
155 145 196 189 176 N
165 142 195 185 170 P
245 228 280 274 260 N
256 232 252 326 292 P
182 205 218 194 193 N
197 182 160 210 185 P
140 138 187 195 205 N
134 115 150 165 170 P
196 185 185 227 180 N
196 166 166 188 205 P
162 176 192 230 215 N
167 144 176 155 185 P
195 232 199 185 200 N
98 102 89 128 130 P
167 187 228 192 210 N
167 175 122 162 125 P
123 165 145 185 215 N
123 136 147 130 135 P
105 144 119 168 165 N
95 102 154 105 112 P
161 177 162 185 192 N
181 177 140 212 230 P
255 242 330 284 319 N
237 232 245 193 245 P
144 195 180 184 213 N
144 172 163 158 188 P
180 218 224 165 200 N
182 202 254 185 173 P
126 145 173 175 140 N
165 140 153 180 155 P
175 155 154 164 154 N
196 195 204 188 178 P
227 218 245 235 257 N
175 197 195 182 193 P
;
proc glm data=dat6;
class trt;
model m0 m1 m2 m3 m4=trt/nouni SS3;
repeated m 5(0 1 2 3 4) contrast(5)/summary printe;
run;

/*7-2*/
data dat2;
input time censor freq @@;
cards;
0.5 1 82 0.5 0 0
1.5 1 30 1.5 0 8
2.5 1 27 2.5 0 8
3.5 1 22 3.5 0 7
4.5 1 26 4.5 0 7
5.5 1 25 5.5 0 28
6.5 1 20 6.5 0 31
7.5 1 11 7.5 0 32
8.5 1 14 8.5 0 24
9.5 1 13 9.5 0 27
10.5 1 5 10.5 0 22
11.5 1 5 11.5 0 23
12.5 1 5 12.5 0 18
13.5 1 2 13.5 0 9
14.5 1 3 14.5 0 7
15.5 1 3 15.5 0 11
;
proc lifetest method=life
      intervals=1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
      plots=(S, H)
      graphics;
      time time*censor(0);
      freq freq;
run; 

/*7-3*/
data dat3;
input time censor @@;
cards;
2 1 4 1 5 1 10 1 10 0 12 1 12 0 14 1 14 1 15 1
16 1 18 1 19 1 23 1 25 1 26 0 27 1 30 0 31 1 34 1
35 1 37 0 38 1 39 1 42 0 43 0 46 1 47 0 49 1 50 1
53 0 54 0
;
proc lifetest method=km plots=(S) graphics;
     time time*censor(0);
run;

/*7-4*/
data dat4;
input time censor group @@;
cards;
1 1 1 2 1 1 5 1 1 5 1 1 5 1 1 7 1 1 9 1 1 11 1 1 11 1 1
13 1 1 13 1 1 16 1 1 20 1 1 21 1 1 22 0 1 22 1 1 31 0 1
33 0 1 37 0 1 43 1 1 1 1 2 3 1 2 4 1 2 4 1 2 5 1 2 7 1 2 
7 1 2 9 1 2 9 1 2 14 0 2 17 1 2 19 0 2 27 0 2 30 0 2 41 0 2
;
proc lifetest plots=(S) graphics;
     time time*censor(0);
     strata group;
run;

/*7-6*/
data dat6;
input time censor age c @@;
cards;
18 1 0 0 8 1 1 0
9 1 0 1 2 1 1 1
28 0 0 0 26 0 1 0
31 1 0 1 10 1 1 1
39 0 0 1 4 1 1 0
19 0 0 1 3 1 1 0
45 0 0 1 4 1 1 0
6 1 0 1 18 1 1 1
8 1 0 1 8 1 1 1
15 1 0 1 3 1 1 1 
23 1 0 0 14 1 1 1 
28 0 0 0 3 1 1 0
7 1 0 1 13 1 1 1
12 1 1 0 13 1 1 1 
9 1 1 0 35 0 1 0
;
proc phreg data=dat6;
class age c;
model time*censor(0)=age c;
run;

/*8-3*/
data dat3_1;
n_e=8; m_e=75.38; sd_e=4.09;
n_c=8; m_c=69.12; sd_c=4.09;
S=sd_e;
delta1=(m_e-m_c)/S;
delta2=4*(n_e+n_c-3)/(4*(n_e+n_c)-9)*delta1;
sig2_d=(n_e+n_c)/(n_e*n_c)+delta2**2/(2*(n_e+n_c));
alpha=0.05;
delta_l=delta2-probit(1-alpha/2)*sqrt(sig2_d);
delta_u=delta2+probit(1-alpha/2)*sqrt(sig2_d);  
run;
proc print noobs;
var alpha delta1 delta2 sig2_d delta_l delta_u;
run;

data dat3_2;
n_e=8; m_e=75.38; sd_e=4.09;
n_c=8; m_c=69.12; sd_c=4.09;
S=sd_e;
delta1=(m_e-m_c)/S;
delta2=4*(n_e+n_c-3)/(4*(n_e+n_c)-9)*delta1;
alpha=0.05;
a=sqrt(4+2*n_e/n_c+2*n_c/n_e);
hd=sqrt(2)*log(delta2/a+sqrt(delta2**2/a**2+1));
eta_l=hd-probit(1-alpha/2)/sqrt(n_e+n_c);
eta_u=hd+probit(1-alpha/2)/sqrt(n_e+n_c);
delta_l=sqrt(8)*sinh(eta_l/sqrt(2));
delta_u=sqrt(8)*sinh(eta_u/sqrt(2));
run;
proc print noobs;
var a hd eta_l eta_u delta_l delta_u;
run;


/*8-4*/
data dat4_1;
input n_e n_c d @@;
  sig2_d=(n_e+n_c)/(n_e*n_c)+d**2/(2*(n_e+n_c));
  dplus_l=1/sig2_d; dplus_u=d*dplus_l;
cards;
70 71 -0.33
60 59 0.07
77 114 -0.30
118 136 0.35
32 62 0.70
10 10 0.85
45 45 0.40
30 30 0.48
40 40 0.37
61 64 -0.06
;
  run;
  proc print; var n_e n_c d sig2_d; run;
  proc means noprint; output out=m_1 sum=sum1 sum2;
  var dplus_l dplus_u; run;
  data dat4_2; set m_1;
    alpha=0.05;
    dplus=sum2/sum1;
    sig2_dp=1/sum1;
    delta_l=dplus-probit(1-alpha/2)*sqrt(sig2_dp);
    delta_u=dplus+probit(1-alpha/2)*sqrt(sig2_dp);
  run;
  proc print noobs;
    var _freq_ alpha dplus sig2_dp delta_l delta_u;
  run;

/*8-7*/
data dat7_1;
input n_e r @@;
z=(1/2)*log((1+r)/(1-r));
zplus_1=(2*n_e-3)*z;
cards;
20 0.41
30 0.53
27 0.51
42 0.43
49 0.37
12 0.39
17 0.45
35 0.40
38 0.36
40 0.52
;
run;
proc print; var n_e r z; run;
proc means noprint; output out=m_1 sum=sum1 sum2;
var zplus_1 n_e; run;
data dat7_2; set m_1;
alpha=0.05;
zplus=sum1/(2*sum2-3*10);
rplus=(exp(2*zplus)-1)/(exp(2*zplus)+1);
delta=(2*rplus)/sqrt(1-rplus*rplus);
ksi_l=zplus-probit(1-alpha/2)/sqrt(2*sum2-3*10); ksi_u=zplus+probit(1-alpha/2)/sqrt(2*sum2-3*10); 
rho_l=(exp(2*ksi_l)-1)/(exp(2*ksi_l)+1); rho_u=(exp(2*ksi_u)-1)/(exp(2*ksi_u)+1); 
delta_l=(2*rho_l)/sqrt(1-rho_l*rho_l); delta_u=(2*rho_u)/sqrt(1-rho_u*rho_u);
run;
proc print noobs;
var _freq_ alpha zplus rplus delta_l delta_u;
run;
