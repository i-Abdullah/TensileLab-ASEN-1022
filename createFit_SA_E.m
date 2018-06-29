function [fitresult, gof] = createFit_SA_E(Strain_SA_E, Stress_SA_E)
%CREATEFIT(STRAIN_SA_E,STRESS_SA_E)
%  Create a fit.
%
%  Data for 'SA_E' fit:
%      X Input : Strain_SA_E
%      Y Output: Stress_SA_E
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 29-Jun-2018 14:40:08


%% Fit: 'SA_E'.
[xData, yData] = prepareCurveData( Strain_SA_E, Stress_SA_E );

% Set up fittype and options.
ft = fittype( 'poly1' );
excludedPoints = (xData < 0) | (xData > 3e-06);
opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Exclude = excludedPoints;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'SA_E' );
h = plot( fitresult, xData, yData, excludedPoints );
legend( h, 'Stress_SA_E vs. Strain_SA_E', 'Excluded Stress_SA_E vs. Strain_SA_E', 'SA_E', 'Location', 'NorthEast' );
% Label axes
xlabel Strain_SA_E
ylabel Stress_SA_E
grid on


