function [x_est, e]=nlms_func(lambda,M,y,x)
%
% Argumentos de entrada:
% mu    = tamano de paso (valor escalar)
% M     = longitud del filtro (valor escalar)
% y     = senal de entrada, vector de dimension Nx1
% x     = senal de referencia/deseada, vector de dimension Nx1
%
% Argumentos de salida:
% e     = vector de errores de estimacion, dimension Nx1
% x_est = vector de salida que aproxima a la senal deseada, dimension Nx1


%Inicializacion del algoritmo
%(inicializar los valores del filtro y el punto de partida de las iteraciones)
N = length(x);  %longitud de la senal de entrada
h = zeros(M,1);
start = M;

%Etapa recursiva
x_ = zeros(N,1);
for n = start:N
   x_(n) = h(:)'*y(n:-1:n-M+1);
   e = x(n) - x_(n);
   h = h + b.*e.*y(n:-1:n-M+1)/(epsilon + norm(y(n:-1:n-M+1)).^2 );
   
end
   x_est = x_;
    
end