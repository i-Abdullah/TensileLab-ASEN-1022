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


ElongationC_SA = ElongationC_SA .* (0.0254); %  Convert from inch to m.
ElongationE_SA = ElongationE_SA .* (0.0254); %  Convert from inch to m.


ThicknessSA_C = ThicknessSA_C * (0.0254); % Convert from inch to m.
ThicknessSA_E = ThicknessSA_C * (0.0254); % Convert from inch to m.


WidthSA_C = WidthSA_C * (0.0254); % Convert from inch to m.
WidthSA_E = WidthSA_E * (0.0254); % Convert from inch to m.


Area_SA_C = ThicknessSA_C * WidthSA_C ; % Calculating the estimated cross sectional area
Area_SA_E = ThicknessSA_E * WidthSA_E ; % Calculating the estimated cross sectional area

%________________________
% Stress and Strain


Stress_SA_C = (ForceC_SA ./ Area_SA_C) .* (10^(-6)) ; % Calculating stress ( Force / Area ) and convert to MPa.
Stress_SA_E = (ForceE_SA ./ Area_SA_C) .* (10^(-6)) ; % Calculating stress ( Force / Area ) and convert to MPa.
Stress_RG_E = (ForceE_RG ./ Area_SA_C) .* (10^(-6)) ; % Calculating stress ( Force / Area ) and convert to MPa.


Strain_SA_C = ElongationC_SA .* 0.0635 ; % Calculating Strain ( Elongation / length )
Strain_SA_E = ElongationE_SA .* 0.0635 ; % Calculating Strain ( Elongation / length )
Strain_RG_E = ElongationE_RG .* 0.0635 ; % Calculating Strain ( Elongation / length )


%% Elminating the data that caues noise

%Elminate negative stress and related strain.

indi = find(Stress_SA_E<0);
Strain_SA_E(indi) = [];
Stress_SA_E(indi) = [];

indi = find(Stress_SA_C<0);
Strain_SA_C(indi) = [];
Stress_SA_C(indi) = [];

Strain_SA_C(1) = 0;
Strain_SA_E(1) = 0;
Stress_SA_C(1) = 0;
Strain_SA_E(1) = 0;


%% don't run yet!!

%{
Strain_SA_C(1) = 0;
Strain_SA_E(1) = 0;
Stress_SA_C(1) = 0;
Strain_SA_E(1) = 0;

indi = find(Strain_SA_E<0);
Strain_SA_E(indi) = [];
Stress_SA_E(indi) = [];

indi = find(Strain_SA_C<0);
Strain_SA_C(indi) = [];
Stress_SA_C(indi) = [];

}

%}


%% Estimating Young's modulus to use it to elminate  the data the causes noise

%{
    
%We can see from the data that between 200 MPa and 250 we have linarity,
%will average the data there for stress and strain to get estimate of
%youngs mouduls and then elminate the data that has a tangent line falls
%outside a small range of our young's modulus, this is roughly between raws
%160 to 197.

Youngs_SA_E = mean( (Stress_SA_E(160:197)) ./ (Strain_SA_E(160:197)) ); % MPa

%Linarity roughly around  eneds aroun 285 MPa stress, which is arround raw
%225
for i = 1:225 
    if abs(Youngs_SA_E() - (Stress_SA_E(i)/Strain_SA_E(i))) > 0.01
        
        Stress_SA_E(i) = [];
        Strain_SA_E(i) = [];
        
    end
    
    
end

%}


%% Elminating noise/ Plotting.

close all

scatter(Strain_RG_E,Stress_RG_E,4,'k')
grid
xlabel('Stress (Sample E), Sam and Abdulla')
ylabel('Strain (MPa)')
title ('Stress Vs Strain')

