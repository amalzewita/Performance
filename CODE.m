clearvars
clc

%%% 1969 Ford Mustang Sportsroof 200 Six %%%

% configure plot 
f = figure;
ax = axes(f);
ax.NextPlot = "add";
lg = legend(ax);

% specs
sympref('FloatingPointOutput', true)
Mass = 1295; % car weight
Cd = 0.5; % drag coefficient
iFinal = 3.08; % final drive
Ro = 1.23; % air density 
Rt = 0.3175; % tire radius 
Af = 1.96; % frontal area 
Vmax = 161; % top speed (km/hr)
Fr = 0.015; % rolling coefficient
Eff = 0.95; % mechanical efficiency
g = 9.81; % gravitational acceleration
u = 0.9; % coff of friction 
h = 0.781; % height of CG
Kp = 0.9; % progressive coefficient
N = 5; % number of gears 
syms V % velocity for the 4th gear shift
Ne = 1000:100:4300; % rotational speed array
% wheelbase
L = 2.743; 
l1 = 1.454;
l2 = 1.289;



% torque array for each Ne
Te = [112.9, 136.1, 157.2, 176.4, 193.5, 208.6, 221.7, 232.8, 241.9, 248.9, 254, 257, 258, 257.8, 257.3, 256.5, 255.4, 253.9, 252.1, 250, 247.5, 244.7, 241.6, 238.2, 234.4, 230.3, 225.9, 221.2, 216.1, 209.7, 202, 193.1, 183, 171.9];
% find the coefficients of brake engine torque polynomial 
T = polyfit(Ne, Te, 2);
% brake engine torque equation
Te = T(1) * Ne.^2 + T(2) .* Ne + T(3);
% plotting
plot(ax, Ne, Te, DisplayName = 'Torque');

% power array for each Ne
Pe = [11.8, 15.7, 19.8, 24, 28.4, 32.8, 37.1, 41.4, 45.6, 49.5, 53.2, 56.5, 59.4, 62.1, 64.7, 67.2, 69.5, 71.8, 73.9, 75.9, 77.8, 79.4, 81, 82.3, 83.5, 84.4, 85.2, 85.7, 86, 85.6, 84.6, 82.9, 80.5, 77.4];
% find the coefficients of brake engine power polynomial 
P = polyfit(Ne, 1.4.*Pe, 3);
% brake engine power equation
Pe = P(1) * Ne.^3 + P(2) * Ne.^2 + P(3) .* Ne + P(4);
% plotting
plot(ax, Ne, Pe, DisplayName = 'Power');



% highest gear shift 
syms NE
Te = T(1) * NE.^2 + T(2) .* NE + T(3);
% calculate resistive pressure
Pres = ((0.5 * Ro * Cd * Af * (Vmax / 3.6)^2) + Fr * g * Mass) * Vmax / 3.6;
% double to convert from class to class
soln = double(solve(Te * 2 * pi * NE / 60 * Eff == Pres, NE));
Ne2 = soln(2); 
ig5 = (2 * pi * Ne2 * 3.6 * Rt) / (60 * Vmax * iFinal);



% lowest gear shift 
Te_max = 258; 
% RWD constant
kr = ((l1 - h * Fr) / (L - u * h));
% max tractive effort
Ft_max = kr * u * Mass * g;
ig1 = Ft_max * Rt / iFinal / Eff / Te_max;



Kg = nthroot (ig1 / ig5, N - 1);



% progressive gearbox
% get the C(s)
C1 = Kg * Kp^(1 - N / 2);
C2 = C1 * Kp;
C3 = C2 * Kp;
% get the ig(s) 
ig2 = ig1 / C1;
ig3 = ig2 / C2;
ig4 = ig3 / C3;
% get Ne3, 4
Ne3 = 60 * iFinal * ig3 * V / 2 / pi / Rt / 3.6;
Ne4 = 60 * iFinal * ig4 * V / 2 / pi / Rt / 3.6;
% find Te in terms of v for both 3rd and 4th shifts
Te3 = T(1) * Ne3.^2 + T(2) .* Ne3 + T(3);
Te4 = T(1) * Ne4.^2 + T(2) .* Ne4 + T(3);
% find Ft in terms of v for both 3rd and 4th shifts
Ft3 = Te3 * ig3 * iFinal * Eff / Rt;
Ft4 = Te4 * ig4 * iFinal * Eff / Rt;
% calculate upshift velocity
Sol = solve(Ft3 == Ft4);
Vshift = max(double(Sol));
% calculate total resisitance 
Tr_progressive = (0.5 * Ro * Cd * Af * (V / 3.6)^2) + (Fr * 9.81 * Mass);
Te_progressive = T(1) * (NE.^2) + T(2) .* NE + T(3);
Fe_progressive = Te_progressive * ig3 * iFinal * Eff / Rt;
% substitute NE with...
Fe_progressive = subs(Fe_progressive, NE, 60 * iFinal * ig4 * V / 2 / pi / Rt);
% calculate time 
t_progressive = double(vpaintegral(Mass / (Fe_progressive - Tr_progressive), [110, 140] / 3.6));
% calculate distance 
Vavg = (110 + 140) / 3.6 / 2;
s_progressive = Vavg * t_progressive;



% geometric gearbox
% get the ig(s) 
ig_2 = ig1 / Kg;
ig_3 = ig_2 / Kg;
ig_4 = ig_3 / Kg;
% get Ne3, 4
Ne_3 = 60 * iFinal * ig_3 * V / 2 / pi / Rt / 3.6;
Ne_4 = 60 * iFinal * ig_4 * V / 2 / pi / Rt / 3.6;
% find Te in terms of v for both 3rd and 4th shifts
Te_3 = T(1) * Ne_3.^2 + T(2) .* Ne_3 + T(3);
Te_4 = T(1) * Ne_4.^2 + T(2) .* Ne_4 + T(3);
% find Ft in terms of v for both 3rd and 4th shifts
Ft_3 = Te_3 * ig_3 * iFinal * Eff / Rt;
Ft_4 = Te_4 * ig_4 * iFinal * Eff / Rt;
% calculate upshift velocity
Sol = solve(Ft_3 == Ft_4);
V_shift = max(double(Sol));
% calculate total resisitance 
Tr_geometric = (0.5 * Ro * Cd * Af * (V / 3.6)^2) + (Fr * 9.81 * Mass);
Te_geometric = T(1) * (NE.^2) + T(2) .* NE + T(3);
Fe_geometric = Te_geometric * ig3 * iFinal * Eff / Rt;
% substitute NE with...
Fe_geometric = subs(Fe_geometric, NE, 60 * iFinal * ig4 * V / 2 / pi / Rt);
% calculate time 
t_geometric = double(vpaintegral(Mass / (Fe_geometric - Tr_geometric), [85, 115] / 3.6));
% calculate distance 
Vavg = (85 + 115) / 3.6 / 2;
s_geometric = Vavg * t_geometric;