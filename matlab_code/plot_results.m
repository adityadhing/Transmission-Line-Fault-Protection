
%% Transmission Line Protection - Plot Results

% Find project folders
scriptFolder = fileparts(mfilename('fullpath'));
projectFolder = fileparts(scriptFolder);

resultsFolder = fullfile(projectFolder, ...
    '02_Results_and_Graphs');

dataFile = fullfile(resultsFolder, ...
    'simulation_data.mat');

if ~isfile(dataFile)
    error('Simulation data not found. Run run_fault_tests.m first.');
end

load(dataFile, 'simOut');

% Retrieve logged signals
V1 = simOut.get('Vabc_M1');
I1 = simOut.get('Iabc_M1');
V2 = simOut.get('Vabc_M2');
I2 = simOut.get('Iabc_M2');

%% 1. Normal Operation
figure('Name','Normal Operation');

subplot(2,1,1);
plot(V1.Time, squeeze(V1.Data));
xlim([0 0.19]);
grid on;
title('Three-Phase Voltage at M1');
xlabel('Time (s)');
ylabel('Voltage (V)');

subplot(2,1,2);
plot(I1.Time, squeeze(I1.Data));
xlim([0 0.19]);
grid on;
title('Three-Phase Current at M1');
xlabel('Time (s)');
ylabel('Current (A)');

saveas(gcf, fullfile(resultsFolder, ...
    'normal_operation.png'));

%% 2. Fault Current
figure('Name','Fault Current');

plot(I1.Time, squeeze(I1.Data), 'LineWidth', 1);
hold on;
plot(I2.Time, squeeze(I2.Data), '--', 'LineWidth', 1);

xline(0.2, ':k', 'Fault starts');
xline(0.3, ':r', 'Fault clears');

grid on;
title('Three-Phase Current During Fault');
xlabel('Time (s)');
ylabel('Current (A)');
legend('M1 phases','M2 phases', ...
    'Location','best');

saveas(gcf, fullfile(resultsFolder, ...
    'fault_current.png'));

%% 3. IEC Standard Inverse Characteristics
Ifault = linspace(126, 2000, 500);
M = Ifault / 125;

Tprimary = 0.14 * 0.10 ./ (M.^0.02 - 1);
Tbackup = 0.14 * 0.25 ./ (M.^0.02 - 1);

figure('Name','Relay Characteristics');

loglog(Ifault, Tprimary, 'LineWidth', 1.5);
hold on;
loglog(Ifault, Tbackup, 'LineWidth', 1.5);

grid on;
xlabel('Current (A)');
ylabel('Operating time (s)');
title('IEC Standard Inverse Relay Characteristics');
legend('Primary relay','Backup relay', ...
    'Location','best');

saveas(gcf, fullfile(resultsFolder, ...
    'relay_characteristics.png'));

%% 4. Relay Coordination Curves
figure('Name','Relay Coordination');

loglog(Ifault, Tprimary, 'LineWidth', 1.5);
hold on;
loglog(Ifault, Tbackup, 'LineWidth', 1.5);

grid on;
xlabel('Fault current (A)');
ylabel('Operating time (s)');
title('Primary and Backup Relay Coordination');
legend('Primary: TMS = 0.10', ...
    'Backup: TMS = 0.25', ...
    'Location','best');

saveas(gcf, fullfile(resultsFolder, ...
    'coordination_curves.png'));

fprintf('All four plots saved in %s\n', resultsFolder);
