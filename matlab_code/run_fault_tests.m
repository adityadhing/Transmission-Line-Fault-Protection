
%% Transmission Line Protection - Run Fault Test

% Find project folders automatically
scriptFolder = fileparts(mfilename('fullpath'));
projectFolder = fileparts(scriptFolder);

modelFolder = fullfile(projectFolder, ...
    '01_Simulation_Model');

resultsFolder = fullfile(projectFolder, ...
    '02_Results_and_Graphs');

% Initialization script
initFile = fullfile(scriptFolder, ...
    'initialize_parameters.m');

if ~isfile(initFile)
    error('Initialization file not found: %s', initFile);
end

run(initFile);

% Locate Simulink model
modelName = 'Transmission_Line_Protection';
modelFile = fullfile(modelFolder, ...
    [modelName '.slx']);

if ~isfile(modelFile)
    error('Simulink model not found: %s', modelFile);
end

% Create results folder if needed
if ~exist(resultsFolder, 'dir')
    mkdir(resultsFolder);
end

% Load model
load_system(modelFile);

% Set simulation stop time
set_param(modelName, ...
    'StopTime', num2str(StopTime));

% Run simulation
fprintf('Starting simulation...\n');
simOut = sim(modelName);
disp(simOut.who);

% Save simulation results and parameters
save(fullfile(resultsFolder, 'simulation_data.mat'), ...
    'simOut', 'VLL', 'f', ...
    'Is_B1', 'Is_B2', ...
    'TMS_B1', 'TMS_B2', ...
    'FaultOnTime', 'FaultOffTime', ...
    'StopTime');

fprintf('Simulation completed successfully.\n');
fprintf('Results saved in: %s\n', resultsFolder);
