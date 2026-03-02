clear; clc;

% Device Parameters
mu = 400e-4;          
Cox = 3e-3;           
W = 1e-6;             
L_values = [180e-9 90e-9 45e-9 22e-9];          
Vt = 0.4;             
Vgs = 0:0.01:1.2;  

figure;
hold on;

for j = 1:length(L_values)
  L = L_values(j);
  Id = zeros(size(Vgs));

  for i = 1:length(Vgs)
    if Vgs(i) > Vt
        Id(i) = 0.5 * mu * Cox * (W/L) * (Vgs(i)-Vt)^2;
    else
        Id(i) = 0;
    end
  end
  plot(Vgs, Id, 'LineWidth', 2);
end

plot(Vgs, Id, 'LineWidth', 2);
xlabel('Vgs (V)');
ylabel('Drain Current Id (A)');
title('Planar MOSFET Id-Vgs Characteristics');
grid on;

% Addition od threshold roll-off

Vt0 = 0.5;              % Long channel threshold voltage
alpha = 5e-9;           % Roll-off constant

L_values = [180e-9 90e-9 45e-9 22e-9];

Vt_values = zeros(size(L_values));

for i = 1:length(L_values)
    L = L_values(i);
    Vt_values(i) = Vt0 - (alpha / L);
end

figure;
plot(L_values*1e9, Vt_values, 'o-', 'LineWidth', 2);
xlabel('Channel Length (nm)');
ylabel('Threshold Voltage Vt (V)');
title('Threshold Voltage Roll-off');
grid on;


%ADDITION OD DIBL

L = 45e-9;
Vt0 = 0.5;
alpha = 5e-9;
eta = 0.1;              % DIBL coefficient

Vds_values = [0.05 1];  % Low and high drain voltage

figure; hold on;

for Vds = Vds_values
    
    % Threshold including roll-off
    Vt = Vt0 - (alpha / L);
    
    % Apply DIBL
Vt_eff = Vt - eta * Vds;
    
    Id = zeros(size(Vgs));
    
    for i = 1:length(Vgs)
        if Vgs(i) > Vt_eff
            Id(i) = 0.5 * mu * Cox * (W/L) * (Vgs(i)-Vt_eff)^2;
        else
            Id(i) = 0;
        end
    end
    
    plot(Vgs, Id, 'LineWidth', 2);
end

xlabel('Vgs (V)');
ylabel('Drain Current Id (A)');
title('DIBL Effect on Id-Vgs Characteristics');
legend('Vds = 0.05V','Vds = 1V');
grid on;

