clear; clc; close all;

% 1. Carica i file CSV generati da Python
sai = readtable('telemetria_SAI.csv');
ver = readtable('telemetria_VER.csv');

% Conversione forzata della colonna Btake in numeri
sai.Brake = double(string(sai.Brake) == "True");
ver.Brake = double(string(ver.Brake) == "True");

% 2. Crea il grafico di telemetria
figure('Name', 'Telemetria F1 - Monza 2023', 'NumberTitle', 'off');

% Subplot 1: Velocità
subplot(3,1,1);
plot(sai.Distance, sai.Speed, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Sainz');
hold on;
plot(ver.Distance, ver.Speed, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Verstappen');
ylabel('Velocità (km/h)');
title('Confronto Giro Veloce Monza 2023');
legend('Location', 'northeast');
grid on;

% Subplot 2: Acceleratore
subplot(3,1,2);
plot(sai.Distance, sai.Throttle, 'r-', 'LineWidth', 1.2);
hold on;
plot(ver.Distance, ver.Throttle, 'b--', 'LineWidth', 1.2);
ylabel('Acceleratore (%)');
grid on;

% Subplot 3: Freno
subplot(3,1,3);
plot(sai.Distance, sai.Brake, 'r-', 'LineWidth', 1.2);
hold on;
plot(ver.Distance, ver.Brake, 'b--', 'LineWidth', 1.2);
xlabel('Distanza Pista (m)');
ylabel('Freno');
grid on;

% --- CALCOLO DELTA TIME (Distacco in secondi lungo il circuito) ---
% 1. Calcolo del tempo impiegato per percorrere ogni intervallo di distanza (dt = dx / v)
% Convertiamo la velocità da km/h a m/s dividendo per 3.6
dt_sai = [0; diff(sai.Distance) ./ (sai.Speed(1:end-1) / 3.6)];
dt_ver = [0; diff(ver.Distance) ./ (ver.Speed(1:end-1) / 3.6)];

% 2. Integrale del tempo accumulato
t_sai = cumsum(dt_sai);
t_ver = cumsum(dt_ver);

% 3. Interpolazione per confrontare i tempi alla stessa identica distanza
t_ver_interp = interp1(ver.Distance, t_ver, sai.Distance, 'linear', 'extrap');
delta_time = t_sai - t_ver_interp; % Valori positivi = Sainz perde tempo, Negativi = Sainz guadagna

% --- NUOVO GRAFICO CON DELTA TIME ---
figure('Name', 'Telemetria F1 + Delta Time', 'NumberTitle', 'off');

% Subplot 1: Velocità
subplot(2,1,1);
plot(sai.Distance, sai.Speed, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Sainz');
hold on;
plot(ver.Distance, ver.Speed, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Verstappen');
ylabel('Velocità (km/h)');
title('Confronto Velocità e Delta Time (Sainz vs Verstappen)');
legend('Location', 'northeast');
grid on;

% Subplot 2: Delta Time
subplot(2,1,2);
plot(sai.Distance, delta_time, 'k-', 'LineWidth', 1.5);
xlabel('Distanza Pista (m)');
ylabel('Delta Time (s)');
title('Distacco cumulato (Sotto lo 0 = Sainz in vantaggio)');
grid on;