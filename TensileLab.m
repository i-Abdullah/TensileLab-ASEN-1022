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
scatter(Strain_SA_E,Stress_SA_E,2,'k');
hold on
scatter(Strain_RG_E,Stress_RG_E,2,'r');

grid
xlabel('Strain (uniteless)');
ylabel('Stress (MPa)');
title ('Stress Vs Strain - Sample E');
legend('Sam and Abdulla','Raymie and Gera');

subplot(1,2,2)

scatter(Strain_SA_C,Stress_SA_C,4,'k');
hold on
scatter(Strain_RG_C,Stress_RG_C,2,'r');
legend('Sam and Abdulla','Raymie and Gera');
grid
xlabel('Strain (uniteless)');
ylabel('Stress (MPa)');
title ('Stress Vs Strain - Sample C');

hold off


%% Analyzing: Y.S,Youngs Mouduls, T.S, Fracture point.


%Tensile Strength is the max stress:

TS_SA_E = max(Stress_SA_E);
TS_SA_C = max(Stress_SA_C);
TS_RG_E = max(Stress_RG_E);
TS_RG_C = max(Stress_RG_C);


%We will determine the best fit for the linear region of the data using the
%curve fitting tool in MATLAB, we will exclude the non-linear regions by
%the ruler tool in the curve fitting app.

%We will store each curve fitting session in the main file, we will
%manually extract the polynomial coefficients.

%each young's equation represent the best fit line:


% BEST LINE EQUATIONS;

Youngs_SA_E = @(x) 8.633e+07 *(x - 0.002E-5) +  41.31 ;
Youngs_SA_C = @(x) 3.411e+08 *(x - 0.002E-5) + -12.96 ;
Youngs_RG_E = @(x) 1.089e+08 *(x - 0.002E-5) + -1.96;
Youngs_RG_C = @(x) 4.075e+08 *(x - 0.002E-5) + -14.91;


% Determine the Y.S (where the offeseted Youngs moudule by 0.2% intersect
% the data point we have): we will use a for loop to determine the closest
% values of our data to our best fit, and interpolate.

%create an Array called Diff the determines the difference between 

fit = feval(Youngs_SA_E,Strain_SA_E);
for i=1:length(Strain_SA_E)
    
    Diff_SA_E(i) = abs( fit(i) - Stress_SA_E(i));
    
end

%sort the diffrencees from lower to higher
%the first value is the first one, we will ignore it.

Diff_SA_E_Close = sort(Diff_SA_E);

interpolate1 = find(Diff_SA_E==Diff_SA_E_Close(2));
interpolate2 = find(Diff_SA_E==Diff_SA_E_Close(3));


%% PLOTS :



% FIRST PLOT

subplot(2,2,1)
scatter(Strain_SA_E,Stress_SA_E,2,'k');
hold on
linefit1 = ezplot(Youngs_SA_E,[ min(Strain_SA_E) max(Strain_SA_E) min(Stress_SA_E) max(Stress_SA_E)]);

set(linefit1,'LineWidth',2);

grid minor
xlabel('Strain (uniteless)');
ylabel('Stress (MPa)');
title ('Stress Vs Strain, Sample E, SA ');
legend('Sam and Abdulla','Youngs mouduls');
xlim([0 9e-5]);
ylim([0 400]);

%_______________________________

% SECOND PLOT

subplot(2,2,2)

scatter(Strain_RG_E,Stress_RG_E,2,'k');

hold on

linefit2 = ezplot(Youngs_RG_E,[ min(Strain_RG_E) max(Strain_RG_E) min(Stress_RG_E) max(Stress_RG_E)]);
set(linefit2,'LineWidth',2);

grid minor
xlabel('Strain (uniteless)');
ylabel('Stress (MPa)');
title ('Stress Vs Strain, Sample E, RG ');
legend('Raymie and Gera','Youngs mouduls');
xlim([0 6e-5]);
ylim([0 400]);


subplot(2,2,3)

scatter(Strain_SA_C,Stress_SA_C,4,'k');
hold on
linefit3 = ezplot(Youngs_SA_C,[ min(Strain_SA_C) max(Strain_SA_C) min(Stress_SA_C) max(Stress_SA_C)]);
set(linefit3,'LineWidth',2);

grid minor
xlabel('Strain (uniteless)');
ylabel('Stress (MPa)')
title ('Stress Vs Strain, Sample C, SA ');
legend('Sam and Abdulla','Youngs mouduls');
xlim([0 0.3e-5]);
ylim([0 170]);


subplot(2,2,4)

scatter(Strain_RG_C,Stress_RG_C,2,'k');
hold on
linefit4 = ezplot(Youngs_RG_C,[ min(Strain_RG_C) max(Strain_RG_C) min(Stress_RG_C) max(Stress_RG_C)]);
set(linefit4,'LineWidth',2);

legend('Raymie and Gera','Youngs mouduls');
grid minor
xlabel('Strain (uniteless)');
ylabel('Stress (MPa)');
title ('Stress Vs Strain, Sample C, RG');
xlim([0 0.3e-5]);
ylim([0 210]);

hold off



%% PRINTING OUT THE DATA:
