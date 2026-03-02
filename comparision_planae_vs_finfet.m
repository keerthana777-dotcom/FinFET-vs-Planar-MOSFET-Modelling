clc;
clear;
close all;

% COMMON PARAMETERS

mu = 0.05;                  % Mobility (m^2/Vs)
eps_ox = 3.45e-11;          
tox = 1e-9;                 
Cox = eps_ox/tox;

Vgs = 0:0.01:1.2;
Vds_low = 0.05;
Vds_high = 1;

Vt0 = 0.5;
L = 45e-9;


% PLANAR MOSFET PARAMETERS

W_planar = 1e-6;
alpha_planar = 5e-9;        % Roll-off constant
eta_planar = 0.1;           % DIBL coefficient

% Thresho;d roll-off
Vt_planar = Vt0 - (alpha_planar/L);

% Effective threshold
Vt_low_planar  = Vt_planar - eta_planar*Vds_low;
Vt_high_planar = Vt_planar - eta_planar*Vds_high;

% Id
Id_planar = zeros(size(Vgs));

for i = 1:length(Vgs)
    if Vgs(i) > Vt_high_planar
        Vov = Vgs(i) - Vt_high_planar;
        Id_planar(i) = 0.5*mu*Cox*(W_planar/L)*(Vov^2);
    end
end


%FINFET PARAMETERS

Hfin = 30e-9;
Wfin = 10e-9;
Weff = 2*Hfin + Wfin;

alpha_finfet = 1e-9;        % Smaller roll-off
eta_finfet = 0.03;          % Smaller DIBL

% Threshold roll-off
Vt_finfet = Vt0 - (alpha_finfet/L);

% Effective threshold
Vt_low_finfet  = Vt_finfet - eta_finfet*Vds_low;
Vt_high_finfet = Vt_finfet - eta_finfet*Vds_high;

% Id
Id_finfet = zeros(size(Vgs));

for i = 1:length(Vgs)
    if Vgs(i) > Vt_high_finfet
        Vov = Vgs(i) - Vt_high_finfet;
        Id_finfet(i) = 0.5*mu*Cox*(Weff/L)*(Vov^2);
    end
end


% PLOT COMPARISION

figure;
plot(Vgs, Id_planar, 'LineWidth', 2);
hold on;
plot(Vgs, Id_finfet, 'LineWidth', 2);

xlabel('Vgs (V)');
ylabel('Drain Current Id (A)');
title('Planar vs FinFET Id-Vgs Comparison (High Vds)');
legend('Planar MOSFET','FinFET');
grid on;


% DIBL CALCULATION

DIBL_planar = (Vt_low_planar - Vt_high_planar) / (Vds_high - Vds_low);
DIBL_finfet = (Vt_low_finfet - Vt_high_finfet) / (Vds_high - Vds_low);

fprintf('\n----DIBL COMPARISON ----\n');
fprintf('Planar MOSFET DIBL  = %.4f V/V\n', DIBL_planar);
fprintf('FinFET DIBL         = %.4f V/V\n', DIBL_finfet);

if DIBL_finfet < DIBL_planar
    fprintf('\nResult: FinFET shows better electrostatic control.\n');
else
    fprintf('\nResult: Check parameters.\n');
end