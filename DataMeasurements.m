%% The goal of this .m file is to convert all the data into .mat files saved
% and ready to be used on the main script, TensileLab.
%
%
% Done by: Geraldine Fuentes, Raymie Fotherby, Sam Hartman, and Abdulla AlAmeri.
%
%
%% Sample : Extruded (E), measurments in inches and pound-force.

clear
clc

% Sam and Abdulla :

WidthSA_E = [ 0.510 0.500 0.495 0.500 ]; %Measured width of sample 
WidthSA_E = mean(WidthSA_E); %Averaging width 

ThicknessSA_E = [ 0.185 0.186 0.185 0.187 ]; %Measured thickness of sample
ThicknessSA_E = mean(ThicknessSA_E); %Averaging thickness


SA_SampleE = xlsread('CollectedData/AbdullaSamData.xlsx','SampleE'); %Importing collected data
ForceE_SA = SA_SampleE(:,1); % Extracting force.
ElongationE_SA = SA_SampleE(:,2); % Extracting Elongation


% Raymie and Geraldine

WidthRG_E = [ 12.7 12.7 ] .* 10^-3 ; %Measured width of sample(IN mm) 
WidthRG_E = mean(WidthRG_E); %Averaging width 

ThicknessRG_E = [ 4.65 4.70 ] * 10^-3; %Measured thickness of sample (In mm)
ThicknessRG_E = mean(ThicknessRG_E); %Averaging thickness


RG_SampleE = xlsread('CollectedData/RGData.xlsx','SampleE'); %Importing collected data
ForceE_RG = RG_SampleE(:,1); % Extracting force.
ElongationE_RG = RG_SampleE(:,2); % Extracting Elongation


% Saving data as .mat file

save('Group3_Ductile.mat')



%% Sample : Brittle (C), measurments in inches and pound-force

clear
clc

% Sam and Abdulla

WidthSA_C = [ 0.500 0.502 0.485 0.505  ]; %Measured Width
WidthSA_C = mean(WidthSA_C); %Averaging width

ThicknessSA_C = [ 0.185 0.186 0.185 0.187]; %Measured Thicknes (we dropped the sample here)
ThicknessSA_C = mean(ThicknessSA_C); %Averaging thickness

% Sam and Abdulla

SA_SampleC = xlsread('CollectedData/AbdullaSamData.xlsx','SampleC'); %Importing collected data
ForceC_SA = SA_SampleC(:,1); % Extracting force.
ElongationC_SA = SA_SampleC(:,2); % Extracting Elongation

% Raymie and Geraldine

WidthRG_C = [ 12.7 12.7 ] .* 10^-3 ; %Measured width of sample(IN mm) 
WidthRG_C = mean(WidthRG_C); %Averaging width 

ThicknessRG_C = [ 4.65 4.70 ] .* 10^-3; %Measured thickness of sample (In mm)
ThicknessRG_C = mean(ThicknessRG_C); %Averaging thickness


% Raymie and Geraldine

RG_SampleC = xlsread('CollectedData/RGData.xlsx','SampleC'); %Importing collected data
ForceC_RG = SA_SampleC(:,1); % Extracting force.
ElongationC_RG = SA_SampleC(:,2); % Extracting Elongation


% Saving data as .mat file

save('Group3_Brittle.mat')

