
%Pressure model params current

A= 0.016;
MM = 50;            %massa busto e braccia
m = 67;             %massa che interviene nella dinamica
c2= 3060; %2000;
k2= 5740; %4500;
g = 9.81;       

%% ****** FILTERS PARAMs *****

% HIGH PASS FILTER

tau_hp = 21; %[sec]
G_hp_ref = 1; %hp gain to create the reference
G_hp_mpc =1;

% LOW PASS FILTER

tau_lp = 0.1; %[sec]
G_lp_mpc =1;

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

m1= 10^7;
m2=0.17*10^8;

%  j1=1;
%  j2=1;%100;
%  O_d=0 ;%-0.007;
