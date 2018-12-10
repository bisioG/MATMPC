

% %Pressure model params Yutao
% 
% A = 0.016;          %area di contatto       
% MM = 50;            %massa busto e braccia
% m = 67;             %massa che interviene nella dinamica
% k1 = 12000;         %parametri forza elastica k1*(10*dy)^2+k2  NOTARE FATTORE 100
% k2 = 1000;
% c1 = 200;           %parametri smorzamento  c1*(10*dy)^2+c2   NOTARE FATTORE 100        
% c2 = 2000;
% alpha = 10;         %inclinazione poggiaschiena sedile
% sigma_0 = 10^4;     %parametro per l'attrido [de Wit]
% vs = 0.005;         %velocita` di Stribeck 
% Fs = 45;            %coefficente di attrito statico
% Fc = 30;            %coefficente di attrito dinamico (coulomb)
% g = 9.81;       

%Pressure model params AMC18

% A = 0.016;          %area di contatto       
% MM = 50;            %massa busto e braccia
% m = 67;             %massa che interviene nella dinamica
% k1 = 1000;          %parametri forza elastica k1*dy^2+k2
% k2 = 1000;
% c1 = 200;           %parametri smorzamento  c1*dy^2+c2           
% c2 = 1000;
% p=2;
% alpha = 10;         %inclinazione poggiaschiena sedile
% sigma_0 = 10^2;     %parametro per l'attrido [de Wit]
% vs = 0.005;         %velocita` di Stribeck 
% Fs = 0.4;            %coefficente di attrito statico
% Fc = 0.3;            %coefficente di attrito dinamico (coulomb)
% g = 9.81;       

% %Pressure model params current
% 
A = 0.016;          %area di contatto       
MM = 50;            %massa busto e braccia
m = 67;             %massa che interviene nella dinamica

k1 = 10*10^6; %12*10^5;     %parametri forza elastica k1*(*dy)^p+k2  
k2 = 100;%1000
c1 = 4*10^6; %20*10^4;       %parametri smorzamento  c1*(*dy)^p+c2      
c2 = 800; %1000;
p=2;                %grado del polinomio smorzamento e rigidezza

alpha = 10;         %inclinazione poggiaschiena sedile
sigma_0 = 10^4;     %parametro per l'attrido [de Wit]
vs = 0.005;         %velocita` di Stribeck 
Fs = 0.1 %0.1;%0.4;            %coefficente di attrito statico
Fc = 0.2 %0.1;%0.3;            %coefficente di attrito dinamico (coulomb)
g = 9.81;



%% ****** FILTERS PARAMs *****

% HIGH PASS FILTER

tau_hp = 21; %[sec]

G_hp_ref = 1;       %hp gain to create the reference
G_hp_mpc = 1; %7;     %guadagno modello mpc percezione

G_hp_mpc_a = 1; % 1/5.5; %guadagno modello mpc percezione active seat ( _v2)
G_hp_mpc_p = 1;% 7; %guadagno modello mpc percezione piattaforma ( _v2)

% LOW PASS FILTER

tau_lp = 0.1;
G_lp_mpc=1;


%%******* CONTACT PARAMs *******

% caratteristiche elastiche tronco(1) e cuscinetto(2)

r0=0.04;%0.04;
% E1 = 9.5*10^6;     %modulo di young [GPa] 
% E2 = 9*10^5;
% ni1 = 0.20;         %coefficente di poisson
% ni2 = 0.48;
% 
% EE =(((1-ni1^2)/E1)+((1-ni2^2)/E2));      %E*=parametro che tiene in considerazione le caratteristiche elastiche dei corpi
% E=1/EE;
% E=1*10^5;
% 
% % linearizzazione funzione R(u) u= pressione cuscinetto [Pa]
% q_lin =8.1*10^5; %10.8*10^5;
% c_ang = 202.5*10^5 ;%270*10^5;


%parametri moltiplicativi

m1= 8*10^6; %coefficiente E*
m2= 0.15*10^8; %0.11*10^8 %0.15*10^8; %coefficiente pc

%  j1=1;
%  j2=1;%100;
%  O_d=0 ;%-0.007;
