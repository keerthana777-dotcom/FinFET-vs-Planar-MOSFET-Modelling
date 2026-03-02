clc;
clear;
close all;

%FinFET PARAMETERS
mu = 0.05;                   % Mobility (m^2/Vs)
eps_ox = 3.45e-11;           % Oxide permittivity
tox = 1e-9;                  % Oxide thickness
Cox = eps_ox / tox;

%Fin Dimentions
Hfin = 30e-9;                % Fin height
Wfin = 10e-9;                % Fin width
L = 45e-9;                   % Channel length

Weff = 2*Hfin + Wfin;        % Effective width

%IMPROVED DIBL
Vt0 = 0.5;                   
alpha = 1e-9;                % Smaller roll-off than planar
eta = 0.03;                  % Much smaller DIBL

Vgs = 0:0.01:1.2;
Vds_values = [0.05 1];

figure;
hold on;

for Vds = Vds_values
   % Roll-off 
   Vt = Vt0 - (alpha / L);
    
    % DIBL
    Vt_eff = Vt - eta * Vds;
    
    Id = zeros(size(Vgs));
    
    for i = 1:length(Vgs)
        
        if Vgs(i) > Vt_eff
            Id(i) = 0.5 * mu * Cox * (Weff/L) * (Vgs(i)-Vt_eff)^2;
        else
            Id(i) = 0;
        end
        
    end 
    plot(Vgs, Id, 'LineWidth', 2);
    
end

xlabel('Vgs (V)');
ylabel('Drain Current Id (A)');
title('FinFET Id-Vgs Characteristics with Reduced DIBL');
legend('Vds = 0.05V','Vds = 1V');
grid on;


%IMPROVED Id-Vgs GRAPH

Esat = 1e6;   % Critical electric field (V/m)

figure;
hold on;

for Vds = Vds_values
    
    % Threshold with roll-off
    Vt = Vt0 - (alpha / L);
    
    % Apply DIBL
    Vt_eff = Vt - eta * Vds;
    
    Id_improved = zeros(size(Vgs));
    
    for i = 1:length(Vgs)
        
        if Vgs(i) > Vt_eff
            Vov = Vgs(i) - Vt_eff;
            
            % Velocity saturation correction
            Id_improved(i) = (mu*Cox*(Weff/L) * (Vov^2)/2) ...
                / (1 + Vov/(Esat*L));
            
        else
            Id_improved(i) = 0;
        end
        
    end
    
    plot(Vgs, Id_improved, 'LineWidth', 2);
    
end

xlabel('Vgs (V)');
ylabel('Drain Current Id (A)');
title('Improved FinFET Id-Vgs with Velocity Saturation');
legend('Vds = 0.05V','Vds = 1V');
grid on;