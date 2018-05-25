

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
% alpha = 10;         %inclinazione poggiaschiena sedile
% sigma_0 = 10^4;     %parametro per l'attrido [de Wit]
% vs = 0.005;         %velocita` di Stribeck 
% Fs = 40;            %coefficente di attrito statico
% Fc = 30;            %coefficente di attrito dinamico (coulomb)
% g = 9.81;       

%Pressure model params current

A = 0.016;          %area di contatto       
MM = 50;            %massa busto e braccia
m = 67;             %massa che interviene nella dinamica
k1 = 12000*100;     %parametri forza elastica k1*(*dy)^2+k2  
k2 = 1000;
c1 = 200*100;       %parametri smorzamento  c1*(*dy)^2+c2         
c2 = 2000;
alpha = 10;         %inclinazione poggiaschiena sedile
sigma_0 = 10^4;     %parametro per l'attrido [de Wit]
vs = 0.005;         %velocita` di Stribeck 
Fs = 40;            %coefficente di attrito statico
Fc = 30;            %coefficente di attrito dinamico (coulomb)
g = 9.81;       


%% ****** FILTERS PARAMs *****

% HIGH PASS FILTER

tau_hp = 21; %[sec]


