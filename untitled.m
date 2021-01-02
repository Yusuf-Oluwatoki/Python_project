clear all
clc
close all
%%
tspan = [0:0.5:100];

y1_0 = 1.5903;  y2_0 = 1.304;  y3_0 = 1.601;  y4_0 = 2.6014;  y5_0 = 2.334;
y6_0 = 2.414; y7_0 = 2.8311132;y8_0 =2.5232; y9_0 = 3.45; y10_0 = 3.73;  
y11_0 = 2.603;  y12_0 = 2.504;  y13_0 = 2.301;  y14_0 = 2.1014;
y15_0=2.153; y16_0=2.153; y17_0=2.353; y18_0=2.0153;  y19_0=2.2153; 
y20_0=2.0153; y21_0=2.0353; y22_0=2.043; y23_0=2.0353;

vPs = 2.2;  vCs= 2.3;   vBs= 2.32;  vRs= 2.04; vRes= 2.14;
% k =0.408;  k1 =0.39;  k2 =0.47;  k3=0.42; k4=0.419;
% d_mP = 0.34; d_mC=0.324; d_mB = 0.46; d_mR = 0.372; d_mRe = 0.382; Kpco =0.3; kcbpc =0.39; dclbn= 0.30;
% dpcn=0.15; kdcbpc = 0.46;

%vPs= 1.7;


init=[y1_0 y2_0 y3_0 y4_0 y5_0 y6_0 y7_0 y8_0 y9_0 y10_0 ...
    y11_0 y12_0 y13_0 y14_0 y15_0 y16_0 y17_0 y18_0 y19_0 ...
    y20_0 y21_0 y22_0 y23_0];

params=[vPs,vCs,vBs,vRs,vRes];

[Tt,Y] = ode45(@new2,tspan,init,[],params);
%%


state.time=tspan;
state.ydata=Y;
state.y0 = init;

for i = 1:5
k00 = params+2.8.*abs(randn(1,5));
[fit,rss] = fminsearch(@new_ss1,k00,[],state);
mse = rss/(length(state.ydata)-4);

%fit is the new parameter values from the optimization.

[T,Yfit] = ode45(@new2,tspan,init,[],fit);
Yall(:,:,i) = Yfit;
fitall(:,i)= fit;
rssall(:,i) = rss;
end
%%
for j=1:5
    
figure
plot(Tt,Y(:,j),'LineWidth',2)
hold on
for i=1:5
plot(T,Yall(:,j,i),'LineWidth',1.5)
% plot(T,Yall(:,j,i),'--b')
end
xlabel('Time(h)');
ylabel('Concentration (nM)');
legend('Parameters','Optimized 1' ,'Optimized 2','Optimized 3','Optimized  4','Optimized  5')
end
%%
% figure
% plot(fitall(:,1), 'r'); hold on
% plot(fitall(:,2), 'b'); hold on
% plot(fitall(:,3), 'k');


function dydt = new2(t,y,values)
dydt = zeros(23,1); 

%%
 
vPs =values(1);
vCs=values(2);
vBs=values(3);
vRs=values(4);
vRes=values(5);
%%
%%
n=4; m=6; p=8; q=7; O=8;l= 8;  r=8; s=7; t=8; u=6;

%vPs = 2.2;  

kiP=0.242;  d_mP = 0.34;

d_mC=0.324;  kiC = 0.262;  
% vCs= 2.3;

d_mB = 0.46;  
% vBs= 2.32;  
kiB = 0.13;   

d_mR = 0.372;   
% vRs= 2.04;  
kiR = 0.27;   

d_mRe = 0.382;   
% vRes= 2.14;  
kiRe = 0.25;   

k =0.408;
Kpco =0.3; Kpc1=0.362;Kpc=0.304; Kppc= 0.39; dpc=0.23;

k1 =0.39;  

Kcc = 0.365; Kcpc = 0.306; dcc=0.18; 

k2 =0.47; 

Kbcc = 0.342; Kbc=0.298; Kbpc=0.385; dbc=0.07;

k3=0.42; 

Krcc=0.394; Krc=0.361;  Krpc=0.166;  drc=0.05; 

k4=0.419;  

Krecc=0.374;  Krec=0.3611; Krepc=0.3363; drec=0.06;

Kpcc=0.375; Kpcp = 0.24412;  Kpcpc=0.3623; dpcc=0.017;

dppc=0.023;  dcpc = 0.019;  dbpc=0.013;  drpc = 0.02; drepc= 0.23;  dpcpc = 0.025;

Kclbn=0.37;  dbn=0.09;

Krn=0.3482;   drn=0.0704;

Kren= 0.349;  dren=0.0608;

kcbpc =0.39; dclbn= 0.30;

dpcn=0.15;

kdcbpc = 0.46; 


%%
Per_mRNA = y(1);
Cry_mRNA = y(2);
Bmal1_mRNA = y(3);
Ror_mRNA = y(4);
Rev_erb_mRNA = y(5);
CYTOSOLIC_PER_PROTEIN = y(6);
CYTOSOLIC_CRY_PROTEIN = y(7);
CYTOSOLIC_BMAL1_PROTEIN = y(8);
CYTOSOLIC_ROR_PROTEIN = y(9);
CYTOSOLIC_REV_ERB_PROTEIN = y(10);
CYTOSOLIC_PER_CRY_PROTEIN = y(11);
PHOS_CYTOSOLIC_PER_PROTEIN = y(12);
PHOS_CYTOSOLIC_CRY_PROTEIN = y(13);
PHOS_CYTOSOLIC_BMAL1_PROTEIN = y(14);
PHOS_CYTOSOLIC_ROR_PROTEIN = y(15);
PHOS_CYTOSOLIC_REV_ERB_PROTEIN = y(16);
PHOS_CYTOSOLIC_PER_CRY_PROTEIN = y(17);
NUCLEAR_BMAL1_PROTEIN = y(18);
NUCLEAR_ROR_PROTEIN = y(19);
NUCLEAR_REV_ERB_PROTEIN = y(20);
NUCLEAR_CLOCK_BMAL1_PROTEIN = y(21);
NUCLEAR_PER_CRY_PROTEIN = y(22);
NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN = y(23);
 %% 
  
 
% this creates an empty column 
%vector that you can fill with your two derivatives:

% EQUATIONS FOR THE TRANSCRIPTIONS FOR THE VARIOUS mRNA'S.(mRNAs of Per,
% Cry, Bmal1, Rev-erb and Ror)

%y(1)= Per mRNA, y(2)= Cry mRNA, y(3)= Bmal1 mRNA, y(4)= Rev-erb mRNA,
%y(5)= Ror mRNA y(21) = CLOCK-BMAL1 protein,  y(22) = PER-CRY protein in the nucleus.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The equation for the transcription of the Per gene.
dydt(1) = ((vPs.*(NUCLEAR_CLOCK_BMAL1_PROTEIN).^m)./(kiP.^m + ((NUCLEAR_CLOCK_BMAL1_PROTEIN).*(NUCLEAR_PER_CRY_PROTEIN)).^n + (NUCLEAR_CLOCK_BMAL1_PROTEIN).^m))  - d_mP.*Per_mRNA;

% The equation for the transcription of the Cry gene.
dydt(2) = ((vCs.*(NUCLEAR_CLOCK_BMAL1_PROTEIN).^p)./(kiC.^p + ((NUCLEAR_CLOCK_BMAL1_PROTEIN).*(NUCLEAR_PER_CRY_PROTEIN)).^q + (NUCLEAR_CLOCK_BMAL1_PROTEIN).^p))  - d_mC.*Cry_mRNA;

% The equation for the transcription of the Bmal1 gene.
dydt(3) = ((vBs.*((NUCLEAR_ROR_PROTEIN).^O))./(kiB.^O + ((NUCLEAR_ROR_PROTEIN).*(NUCLEAR_REV_ERB_PROTEIN)).^l+ (NUCLEAR_ROR_PROTEIN).^O))  - d_mB.*Bmal1_mRNA;

% The equation for the transcription of the Ror gene.
dydt(4) = ((vRs.*(NUCLEAR_CLOCK_BMAL1_PROTEIN).^r)./(kiR.^r + ((NUCLEAR_CLOCK_BMAL1_PROTEIN).*(NUCLEAR_PER_CRY_PROTEIN)).^s + (NUCLEAR_CLOCK_BMAL1_PROTEIN).^r))  - d_mR.*Ror_mRNA;

% The equation for the transcription of the Rev-erb gene.
dydt(5) = ((vRes.*(NUCLEAR_CLOCK_BMAL1_PROTEIN).^t)./(kiRe.^t + ((NUCLEAR_CLOCK_BMAL1_PROTEIN).*(NUCLEAR_PER_CRY_PROTEIN)).^u + (NUCLEAR_CLOCK_BMAL1_PROTEIN).^t))  - d_mRe.*Rev_erb_mRNA ;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EQUATIONS FOR  PER, CRY, BMAL1, REV-ERB, ROR AND PER-CRY PROTEIN IN THE
% CYTOSOL
% y(4) = PER PROTEIN, y(5) = CRY PROTEIN, y(6) = BMAL1 PROTEIN, and y(7) = PER-CRY PROTEIN IN THE
% CYTOSOL.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The Equations for Unphosphorylated PER Protien in the Cytosol
dydt(6)= k.*Per_mRNA + Kpc1.*(CYTOSOLIC_PER_CRY_PROTEIN) - Kpco.*(CYTOSOLIC_PER_PROTEIN).*(CYTOSOLIC_CRY_PROTEIN) -Kpc.*((CYTOSOLIC_PER_PROTEIN)) + Kppc.*(PHOS_CYTOSOLIC_PER_PROTEIN) -  dpc.*(CYTOSOLIC_PER_PROTEIN); 

%The Equations for Unphosphorylated CRY Protien in the Cytosol
dydt(7)= k1.*Cry_mRNA + Kpc1.*(CYTOSOLIC_PER_CRY_PROTEIN) - Kpco.*(CYTOSOLIC_PER_PROTEIN).*(CYTOSOLIC_CRY_PROTEIN) - Kcc.*((CYTOSOLIC_CRY_PROTEIN))  + Kcpc.*(PHOS_CYTOSOLIC_CRY_PROTEIN)- dcc.*(CYTOSOLIC_CRY_PROTEIN);  

%The Equations for Unphosphorylated BMAL1 Protien in the Cytosol
dydt(8)= k2.*Bmal1_mRNA - Kbcc.*(CYTOSOLIC_BMAL1_PROTEIN)- Kbc.*((CYTOSOLIC_BMAL1_PROTEIN)) + Kbpc.*(PHOS_CYTOSOLIC_BMAL1_PROTEIN) - dbc.*(CYTOSOLIC_BMAL1_PROTEIN); 

%The Equations for Unphosphorylated ROR Protien in the Cytosol
dydt(9)= k3.*Ror_mRNA - Krcc.*(CYTOSOLIC_ROR_PROTEIN)- Krc.*((CYTOSOLIC_ROR_PROTEIN)) + Krpc.*(PHOS_CYTOSOLIC_ROR_PROTEIN) - drc.*(CYTOSOLIC_ROR_PROTEIN); 

%The Equations for Unphosphorylated REV-ERB Protien in the Cytosol
dydt(10)= k4.*Rev_erb_mRNA  - Krecc.*(CYTOSOLIC_REV_ERB_PROTEIN)- Krec.*((CYTOSOLIC_REV_ERB_PROTEIN)) + Krepc.*(PHOS_CYTOSOLIC_REV_ERB_PROTEIN) - drec.*(CYTOSOLIC_REV_ERB_PROTEIN); 

%The Equations for Unphosphorylated PER-CRY Protien in the Cytosol
dydt(11)= Kpco.*((CYTOSOLIC_PER_PROTEIN).*(CYTOSOLIC_CRY_PROTEIN))  - Kpcc.*(CYTOSOLIC_PER_CRY_PROTEIN) - Kpc1.*(CYTOSOLIC_PER_CRY_PROTEIN)- Kpcp.*((CYTOSOLIC_PER_CRY_PROTEIN))+ Kpcpc.*(PHOS_CYTOSOLIC_PER_CRY_PROTEIN)-dpcc.*(CYTOSOLIC_PER_CRY_PROTEIN);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The Equations for phosphorylated PER Protien in the Cytosol
dydt(12)= Kpc.*((CYTOSOLIC_PER_PROTEIN))  - Kppc.*(PHOS_CYTOSOLIC_PER_PROTEIN) - dppc.*(PHOS_CYTOSOLIC_PER_PROTEIN);

%The Equations for phosphorylated CRY Protien in the Cytosol
dydt(13)= Kcc.*(CYTOSOLIC_CRY_PROTEIN)  - Kcpc.*(PHOS_CYTOSOLIC_CRY_PROTEIN) - dcpc.*(PHOS_CYTOSOLIC_CRY_PROTEIN);

%The Equations for phosphorylated BMAL1 Protien in the Cytosol
dydt(14)= Kbc.*((CYTOSOLIC_BMAL1_PROTEIN))  - Kbpc.*(PHOS_CYTOSOLIC_BMAL1_PROTEIN) - dbpc.*(PHOS_CYTOSOLIC_BMAL1_PROTEIN);

%The Equations for phosphorylated ROR Protien in the Cytosol
dydt(15)= Krc.*((CYTOSOLIC_ROR_PROTEIN))  - Krpc.*(PHOS_CYTOSOLIC_ROR_PROTEIN) - drpc.*(PHOS_CYTOSOLIC_ROR_PROTEIN);

%The Equations for phosphorylated REV-ERB Protien in the Cytosol
dydt(16)= Krec.*((CYTOSOLIC_REV_ERB_PROTEIN)) - Krepc.*(PHOS_CYTOSOLIC_REV_ERB_PROTEIN) - drepc.*(PHOS_CYTOSOLIC_REV_ERB_PROTEIN);

%The Equations for phosphorylated PER-CRY Protien in the Cytosol
dydt(17)= Kpcp.*((CYTOSOLIC_PER_CRY_PROTEIN))  - Kpcpc.*(PHOS_CYTOSOLIC_PER_CRY_PROTEIN) - dpcpc.*(PHOS_CYTOSOLIC_PER_CRY_PROTEIN);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EQUATIONS FOR  PER, CRY, BMAL1, REV-ERB, ROR AND PER-CRY PROTEIN, CLOCK PROTEIN and 
%CLOCK-BMAL1 PROTEIN IN THE NUCLEUS
% y(12)= BMAL1 PROTEIN, y(13) = CLOCK-BMAL1 PROTEIN and y(14) = PER-CRY PROTEIN IN THE
% NUCLEUS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%The Equations for  BMAL1 Protien in the Nucleus
dydt(18)= Kbcc.*(CYTOSOLIC_BMAL1_PROTEIN) - Kclbn.*(NUCLEAR_BMAL1_PROTEIN)  -  dbn.*(NUCLEAR_BMAL1_PROTEIN);

%The Equations for  ROR Protien in the Nucleus
dydt(19)= Krcc.*(CYTOSOLIC_ROR_PROTEIN) - Krn.*(NUCLEAR_ROR_PROTEIN)  -  drn.*(NUCLEAR_ROR_PROTEIN);

%The Equations for  REV-ERB Protien in the Nucleus
dydt(20)= Krecc.*(CYTOSOLIC_REV_ERB_PROTEIN) - Kren.*(NUCLEAR_REV_ERB_PROTEIN)  -  dren.*(NUCLEAR_REV_ERB_PROTEIN);

%The Equations for  CLOCK-BMAL1  Protien in the Nucleus
dydt(21)= Kclbn.*(NUCLEAR_BMAL1_PROTEIN)  - kcbpc.*(NUCLEAR_CLOCK_BMAL1_PROTEIN).*(NUCLEAR_PER_CRY_PROTEIN) + kdcbpc.*(NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN) -  dclbn.*(NUCLEAR_CLOCK_BMAL1_PROTEIN)+dpcn.*(NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN);

%The Equations for  PER-CRY  Protien in the Nucleus
dydt(22)= Kpcc.*(CYTOSOLIC_PER_CRY_PROTEIN)  - kcbpc.*(NUCLEAR_CLOCK_BMAL1_PROTEIN).*(NUCLEAR_PER_CRY_PROTEIN) + kdcbpc.*(NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN) - dpcn.*(NUCLEAR_PER_CRY_PROTEIN)+dclbn.*(NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN);

%The Equations for  PER-CRY/CLOCK-BMAL1  Protien in the Nucleus
dydt(23)= kcbpc.*(NUCLEAR_CLOCK_BMAL1_PROTEIN).*(NUCLEAR_PER_CRY_PROTEIN) - kdcbpc.*(NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN) -  dclbn.*(NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN)-dpcn.*(NUCLEAR_CLOCK_BMAL1_PER_CRY_PROTEIN);


end


function ss = new_ss1(p,data)
% sum-of-squares for the system.
% Function takes in the parameters 
% as a vector p, data as the time and system values.
%
% 

time = data.time; %time from the previous system
Aobs = data.ydata; % system values
y0=data.y0;


[~,y] = ode45(@new2,time,y0,[],p); %function to solve the ode 
                                        %with new parameters p
Amodel = y;            %keep new system first values

ss = sum((Aobs - Amodel).^2); %sum of squares error of the new system and previous system
ss = ss(1);


end