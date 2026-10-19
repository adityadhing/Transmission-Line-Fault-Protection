
%% Transmission Line Protection - Initialize Parameters

% Source
VLL = 11e3;             % Line-to-line RMS voltage (V)
f = 50;                 % Frequency (Hz)
Rs = 0.1;               % Source resistance (ohm)
Ls = 1e-3;              % Source inductance (H)

% Transmission line
LineLength = 20;        % Length (km)
R1 = 0.01273;           % Positive-sequence resistance (ohm/km)
L1 = 0.9337e-3;         % Positive-sequence inductance (H/km)
C1 = 12.74e-9;          % Positive-sequence capacitance (F/km)
R0 = 0.3864;            % Zero-sequence resistance (ohm/km)
L0 = 4.1264e-3;         % Zero-sequence inductance (H/km)
C0 = 7.751e-9;          % Zero-sequence capacitance (F/km)

% Load
Pload = 1.8e6;          % Active power (W)
Qload = 0.872e6;        % Reactive power (var)

% Primary relay
Is_B1 = 125;            % Pickup current (A)
TMS_B1 = 0.10;

% Backup relay
Is_B2 = 125;            % Pickup current (A)
TMS_B2 = 0.25;

% Fault
FaultOnTime = 0.2;      % Fault inception time (s)
FaultOffTime = 0.3;     % Fault clearing time (s)
FaultResistance = 0.01;
GroundResistance = 0.01;

% Simulation
Ts = 1e-4;              % Sample time (s)
StopTime = 0.35;        % Stop time (s)

fprintf('Protection parameters initialized.\n');
