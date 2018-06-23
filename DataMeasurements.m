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

WidthSA_E = [ 0.509 0.515 0.503 ]; %Measured width of sample 
WidthSA_E = mean(WidthSA_E); %Averaging width 

ThicknessSA_E = [ 0.195 0.199 0.186 0.187 ]; %Measured thickness of sample
ThicknessSA_E = mean(ThicknessSA_E); %Averaging thickness

SA_SampleE = xlsread('CollectedData/AbdullaSamData.xlsx','SampleE'); %Importing collected data
ForceE_SA = SA_SampleE(:,1); % Extracting force.
ElongationE_SA = SA_SampleE(:,2); % Extracting Elongation


% Raymie and Geraldine


% Saving data as .mat file

save('Group4_Ductile.mat')



%% Sample : Brittle (C), measurments in inches and pound-force

clear
clc

% Sam and Abdulla

WidthSA_C = [ 0.500 0.502 0.485 0.505  ]; %Measured Width
WidthSA_C = mean(WidthSA_C); %Averaging width

ThicknessSA_C = [ 0.185 0.186 0.185 0.187]; %Measured Thicknes (we dropped the sample here)
ThicknessSA_C = mean(ThicknessSA_C); %Averaging thickness

SA_SampleC = xlsread('CollectedData/AbdullaSamData.xlsx','SampleC'); %Importing collected data
ForceC_SA = SA_SampleC(:,1); % Extracting force.
ElongationC_SA = SA_SampleC(:,2); % Extracting Elongation

% Raymie and Geraldine


% Saving data as .mat file

save('Group4_Brittle.mat')

