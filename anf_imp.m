function [e, w, alpha_ ] = anf_imp(y, porc)
% Argumentos de entrada:
% y    =  señal a filtrar, vector de dimension Nx1
% porc  = porcentaje para relaciona alpha con rho (valor escalar [0,1] )
% 
% Argumentos de salida:
% e     = vector de errores de estimacion (salida del filtro), dimension Lx1
% alpha_  = valores de alpha estimado a través del tiempo, dimension Lx1
% w  = angulo adaptado, dimension Lx1

% El parámetro porc dependerá del tipo de señal, si la señal tiene una
% frecuencia grande o  varia mucho en frecuencia, este parámetro deberá ser 
% menor porque así permitirá que la adapatación sea mayor.

L = length(y);
if nargin < 2
    porc = 0.9;
end

% parámetros del filtro notch
alpha = 0.8; % valores iniciales
rho_0 = 0.99;
gamma = 1-rho_0;
a_ = zeros(L,1); 
R = zeros(L,1)*0.01;
e = zeros(L,1);

% señales
% Filtro notch a adaptar
b = [1, -2*cos(2*pi) , 1];
a = [1, -2*cos(2*pi)*alpha, alpha^2];

% tamaño del filtro, N = 3
N = length(b);
Y = convm(y,N)';

a_(N) =  -2*cos(2*pi); %inicializacion con cualquier valor

regressor = zeros(L,1); % psi 
gamma_notch = ones(L,1)*gamma;

% inicio de parámetros para alpha
alpha_ = zeros(L,1);
R_alpha = ones(L,1); % no puede ser 0
regressor_alpha = zeros(L+1,1);
alpha_(N) = alpha; % inicial
alpha_min = 0.1; % alpha_min

rho = ones(L,1)*rho_0;

    % primeros valores del filtro
    % regressor 1 y 2
    % e 1 y 2
    % solo para el caso en el que N = 3:
    e(1) = b*Y(:,1); % (13)
    e(2) = b*Y(:,2) - a(2:end)*[e(1);0];

    alpha_(1) = alpha; 
    alpha_(2) = alpha;
    regressor(1) = 0;
    regressor(2) = -y(1) +alpha_(2)*e(1) - a(2:end)*[regressor(1);0];

    a_(1) =  -2*cos(2*pi); 
    a_(2) =  -2*cos(2*pi);
    regressor_alpha(1) =  0;
    regressor_alpha(2) = [a_(2),2*alpha_(2)]*[e(1);0] - a(2:end)*[regressor(1);0];
    R_alpha(2) = 0.999*gamma.*(regressor_alpha(2).^2 );
    R(2) = 0 + gamma*(regressor(2).^2 );
    
%filtro ANF
for i = N:L
    % Los números en paréntesis al costado de las ecuaciones corresponden
    % al número de ecuación en el paper.
    
    rho(i) = porc*rho(i-1) + (1-porc)*alpha_(i); % al hacer mas presente la variacion de alpha, se adapta mas rápido
    gamma_notch(i) = 1 - rho(i); % (15) Se aproxima a este valor
    gamma_alpha = gamma_notch(i)*0.999; % se busca que sea menor para que alpha varíe menos rápido
    
    % adaptacion de la frecuencia: a_(i) = -2*cos(w_est)
    regressor(i) = -y(i-1) + alpha_(i)*e(i-1) - a(2:end)*regressor(i-1:-1:i-N+1); % (14)
    e(i) = b*Y(:,i) - a(2:end)*e(i-1:-1:i-N+1); % (13)
    R(i) = R(i-1) + gamma_notch(i)*(regressor(i).^2 - R(i-1)); % (12)
    a_(i+1) = a_(i) + gamma_notch(i)*((R(i))^(-1))*regressor(i)*e(i); % (11)
    
    % adaptacion de alpha
    regressor_alpha(i) = [a_(i),2*alpha_(i)]*[e(i-1);e(i-2)] - a(2:end)*regressor_alpha(i-1:-1:i-N+1); % (28)
    R_alpha(i) = R_alpha(i-1) + gamma_alpha.*(regressor_alpha(i).^2 - R(i-1)); % (27)
    alpha_(i+1) = alpha_(i) + gamma_alpha.*((R_alpha(i))^(-1))*regressor_alpha(i)*e(i); %(26)
    
    % proteccion del alpha:
    % Se recomienda reiniciar el valor de alpha al momento de que baje o
    % suba cierto umbral. Se reinicia con los valores 0.8 y 0.5
    if (alpha_(i+1) >= 1)
        alpha_(i+1) = 0.8; % se 'reinicia'
    elseif (alpha_(i+1) < alpha_min)
        alpha_(i+1) = 0.5;
    end
    
    % actualizacion de los valores del filtro:
    b = [1, a_(i+1) , 1]; 
    a = [1, a_(i+1)*alpha_(i+1), alpha_(i+1).^2];
    
end

% a_ = -2*cos(w), a_ : a_estimado
w = acos(-a_(2:end)/2);


end
