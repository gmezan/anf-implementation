% t
L = 500;
t = 1:L;

% parámetros del filtro notch
w = 2*pi*0.1;
alpha = 0.975;
rho = alpha;
a_ = zeros(L,1); 
R = zeros(L,1)*0.01;
e = zeros(L,1);
a_(1) = -2*cos(w);
b = [1, a_(1) , 1];
a = [1, a_(1)*alpha, alpha^2];


% AWGN
var = 1;
v_ =  ((var.^0.5).*randn(L,1));   
v = filter(1, [1, 0.6], v_);

% señales
A = 5;
y = cos(w.*t)' + 0.1*v;
N = length(b);
M = length(a);
Y = convm(y,N)';

gamma = 1-alpha;
regressor = zeros(L,1); % psi 
a_(N) =  -2*cos(0.3*w); %inicializacion random?
gamma_notch = gamma; gamma_alpha = gamma*1.5;

% inicio de parámetros para alpha
alpha_ = zeros(L,1);
R_alpha = ones(L,1); % nol puede ser 0
regressor_alpha = zeros(L+1,1);
alpha_(N) = alpha; % inicial

% alpha_min
alpha_min = 0.7;

%filtro ANF
for i = N:L

    regressor(i) = -y(i-1) + alpha_(i)*e(i-1) - a(2:end)*regressor(i-1:-1:i-N+1); % (14)
    e(i) = b*Y(:,i) - a(2:end)*e(i-1:-1:i-N+1); % (13)
    R(i) = R(i-1) + gamma_notch*(regressor(i).^2 - R(i-1)); % (12)
    a_(i+1) = a_(i) + gamma_notch*((R(i))^(-1))*regressor(i)*e(i); % (11)
    
    % for alpha:
    regressor_alpha(i) = [a_(i),2*alpha_(i)]*[e(i-1);e(i-2)] - a(2:end)*regressor_alpha(i-1:-1:i-N+1); % (28)
    R_alpha(i) = R_alpha(i-1) + gamma_alpha.*(regressor_alpha(i).^2 - R(i-1)); % (27)
    alpha_(i+1) = alpha_(i) + gamma_alpha.*((R_alpha(i))^(-1))*regressor_alpha(i)*e(i); %(26)
    
    % proteccion:
    if (alpha_(i+1) >= 1)
        alpha_(i+1) = 1;
    elseif (alpha_(i+1) < alpha_min)
        alpha_(i+1) = alpha_min;
    end
    
    % actualizacion:
    b = [1, a_(i+1) , 1]; a = [1, a_(i+1)*alpha_(i+1), alpha_(i+1).^2];
    %b = [1, a_(i+1) , 1]; a = [1, a_(i+1)*alpha, alpha.^2];
    
    % consultas:
    % alpha siempre tiende a ser pequeño
    % R^-1 esta bien interpretado?
    % la proteccion esta bien?
    % relacion de los gamma y como se deben actualizarr
    
end





