%% TensileLab: ASEN 1022-100: Materials Sci Aerospace

% This script will analyze, and measure the failure loads and locations of
% test specimens made from two types of Aluminum alloys. Part of a class
% lab expierment.
%
%
% Done by: Geraldine Fuentes, Raymie Fotherby, Sam Hartman, and Abdulla AlAmeri.
%
%

%% Esimating Crosssectional-Area/ Initial measurements.

% H stands for Hight, L stands for length, W for width, we measure different
% times the width and length and averaged the measured values.

clear
clc
close all


% H,W will be in units of : 

L(1) = 1;
L(2) = 2;
L(3) = 3;
W(1) = 4;
W(2) = 5;
W(3) = 6;
H(1) = 7;
H(2) = 8;
H(3) = 9;

% Taking the Average

AvgL = mean(L);
AvgW = mean(W);
AvgH = mean(H);

%% Prepare the data

close all


load('ExampleData.mat','-ascii') % Importing data.

Force = ExampleData(:,2); % getting the force
Force = Force .* ( 4.4482216 ); % Convert from Pound-force to Newton

Elongation = ExampleData(:,3); % getting the elongation
Elongation = Elongation * (0.0254); %  Convert from inch to m.

C_Area = AvgL * AvgW ; % Calculating the estimated cross sectional area

Stress = Force ./ C_Area ; % Calculating stress ( Force / Area )
Stress = Stress .* 10^6 ; % Normalize the data, convert to Mega Pasacal


Strain = Elongation ./ AvgL ; % Calculating Strain ( Elongation / length )


%% Elminating noise/ Plotting.

close all

Stress = Stress(118:length(Stress),:) % Elminating noise from stress
Strain = Strain(118:length(Strain),:) % Eliminating noise from strain


scatter(Strain,Stress,4,'k','+')
grid
xlabel('Stress')
ylabel('Strain (MPa)')
title ('Stress Vs Strain')


