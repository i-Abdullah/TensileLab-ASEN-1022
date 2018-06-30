%% TensileLab: ASEN 1022-100: Materials Sci Aerospace

% This script will analyze, and measure the failure loads and locations of
% test specimens made from two types of Aluminum alloys. Part of a class
% lab expierment.
%
%
% Done by: Geraldine Fuentes, Raymie Fotherby, Sam Hartman, and Abdulla AlAmeri.
%
%

%% Prepare the data

clear
clc
close all


load('Group4_Brittle.mat') % Importing data.
load('Group4_Ductile.mat') %Importing data


%________________________
% FORCE, ELONGATION, AND AREA

ForceC_SA = ForceC_SA .* ( 4.4482216 ); % Convert from Pound-force to Newton
ForceE_SA = ForceE_SA .* ( 4.4482216 ); % Convert from Pound-force to Newton
ForceC_RG = ForceC_RG .* ( 4.4482216 ); % Convert from Pound-force to Newton
ForceE_RG = ForceE_RG .* ( 4.4482216 ); % Convert from Pound-force to Newton


ElongationC_SA = ElongationC_SA .* (0.0254); %  Convert from inch to m.
ElongationE_SA = ElongationE_SA .* (0.0254); %  Convert from inch to m.
ElongationC_RG = ElongationC_RG .* (0.0254); %  Convert from inch to m.
ElongationE_RG = ElongationE_RG .* (0.0254); %  Convert from inch to m.


ThicknessSA_C = ThicknessSA_C * (0.0254); % Convert from inch to m.
ThicknessSA_E = ThicknessSA_E * (0.0254); % Convert from inch to m.
%Raymie and Gera data already in meters.


WidthSA_C = WidthSA_C * (0.0254); % Convert from inch to m.
WidthSA_E = WidthSA_E * (0.0254); % Convert from inch to m.
%Raymie and Gera data already in meters.


Area_SA_C = ThicknessSA_C * WidthSA_C ; % Calculating the estimated cross sectional area
Area_SA_E = ThicknessSA_E * WidthSA_E ; % Calculating the estimated cross sectional area
Area_RG_C = ThicknessRG_C * WidthRG_C ; % Calculating the estimated cross sectional area
Area_RG_E = ThicknessRG_E * WidthRG_E ; % Calculating the estimated cross sectional area

%________________________
% Stress and Strain


Stress_SA_C = (ForceC_SA ./ Area_SA_C) .* (10^(-6)) ; % Calculating stress ( Force / Area ) and convert to MPa.
Stress_SA_E = (ForceE_SA ./ Area_SA_E) .* (10^(-6)) ; % Calculating stress ( Force / Area ) and convert to MPa.
Stress_RG_E = (ForceE_RG ./ Area_RG_E) .* (10^(-6)) ; % Calculating stress ( Force / Area ) and convert to MPa.
Stress_RG_C = (ForceC_RG ./ Area_RG_C) .* (10^(-6)) ; % Calculating stress ( Force / Area ) and convert to MPa.


Strain_SA_C = ElongationC_SA .* 0.0254 ; % Calculating Strain ( Elongation / length )
Strain_SA_E = ElongationE_SA .* 0.0254 ; % Calculating Strain ( Elongation / length )
Strain_RG_E = ElongationE_RG .* 0.0254 ; % Calculating Strain ( Elongation / length )
Strain_RG_C = ElongationC_RG .* 0.0254 ; % Calculating Strain ( Elongation / length )


%% OFFSETTING THE DATA

% Our Extensometer was not zeroed, so we will offset the data of the strain

% offset based on the first value

Strain_SA_C = Strain_SA_C - Strain_SA_C(1) ;
Strain_SA_E = Strain_SA_E - Strain_SA_E(1) ; 
Strain_RG_E = Strain_RG_E - Strain_RG_E(1) ; 
Strain_RG_C = Strain_RG_C - Strain_RG_C(1) ;

%% Elminating the data that caues noise

%Elminate negative stress and related strain.

indi = find(Stress_SA_E<0);
Strain_SA_E(indi) = [];
Stress_SA_E(indi) = [];

indi = find(Stress_SA_C<0);
Strain_SA_C(indi) = [];
Stress_SA_C(indi) = [];

indi = find(Stress_RG_E<0);
Strain_RG_E(indi) = [];
Stress_RG_E(indi) = [];

indi = find(Stress_RG_C<0);
Strain_RG_C(indi) = [];
Stress_RG_C(indi) = [];


% elminate negative strains 

indi = find(Strain_SA_E<0);
Strain_SA_E(indi) = [];
Stress_SA_E(indi) = [];

indi = find(Strain_SA_C<0);
Strain_SA_C(indi) = [];
Stress_SA_C(indi) = [];

indi = find(Strain_RG_E<0);
Strain_RG_E(indi) = [];
Stress_RG_E(indi) = [];

indi = find(Strain_RG_C<0);
Strain_RG_C(indi) = [];
Stress_RG_C(indi) = [];


%% Plotting/ before estimating Young's modulus 

close all



subplot(1,2,1)
scatter(Strain_SA_E,Stress_SA_E,2,'k')
hold on
scatter(Strain_RG_E,Stress_RG_E,2,'r')

grid
xlabel('Strain (uniteless)')
ylabel('Stress (MPa)')
title ('Stress Vs Strain - Sample E')
legend('Sam and Abdulla','Raymie and Gera')

subplot(1,2,2)

scatter(Strain_SA_C,Stress_SA_C,4,'k')
hold on
scatter(Strain_RG_C,Stress_RG_C,2,'r')
legend('Sam and Abdulla','Raymie and Gera')
grid
xlabel('Strain (uniteless)')
ylabel('Stress (MPa)')
title ('Stress Vs Strain - Sample C')

hold off


%% Detrmine the linear region of the data


%We will determine the best fit for the linear region of the data using the
%curve fitting tool in MATLAB, we will exclude the non-linear regions by
%the ruler tool.

%We will store each curve fitting session in the main file, with the
%function that the Curve fitting app can generate so we can call them
%within this code just to reduce computation time .

%The functions will be named createFit

%The first output of the function will create for us our polynomial
%coefficients, we will just use the gradient for the first degree
%ploynomial to represent Young's modulus


syms x

Youngs_SA_E = Young_SA_E*x ;

hold all 


scatter(Strain_SA_E,Stress_SA_E,2, 'k' )

hold on

linefit1 = ezplot(Youngs_SA_E,[ min(Strain_SA_E) - 0.001 max(Strain_SA_E) - 0.001 min(Stress_SA_E) - 0.0001 max(Stress_SA_E) - 0.0001 ])


hold off 



%set(linefit1,'LineWidth',2)

grid
grid minor
xlabel('Strain (uniteless)')
ylabel('Stress (MPa)')
title ('Stress Vs Strain - Sample E')
%legend('Sam and Abdulla','Raymie and Gera')


%% Analyze: Young's mouduls, ultimate tensile strength, and breaking point.

%Caclulculate the youngs moudules based on the linear data by estimating
%the linar best fit


% Sam and Abdulla Sample E Linear data are roughlt between 0 to 275 Mpa, which
% corressponds to the indices from 0 to 220

SA_E_Liner = [ Strain_SA_E(1:220) , Stress_SA_E(1:220) ];

X_SA_E = SA_E_Liner(:,1);
Y_SA_E = SA_E_Liner(:,2);

p = polyfit(SA_E_Liner(:,1),SA_E_Liner(:,2),1);

% Sam and Abdulla Sample E Linear data are roughlt between 0 to 275 Mpa, which
% corressponds to the indices from 0 to 220







