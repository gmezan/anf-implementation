function [A, e]=lms_func(mu,M,y,x)
%
% Argumentos de entrada:
% mu    = tamano de paso (valor escalar)
% M     = longitud del filtro (valor escalar)
% y     = senal de entrada, vector de dimension Nx1
% x     = senal de referencia/deseada, vector de dimension Nx1
%
% Argumentos de salida:
% e     = vector de errores de estimacion, dimension Nx1
% A  = vector de salida que aproxima a la senal deseada, dimension Nx1


%Inicializacion del algoritmo
%(inicializar los valores del filtro y el punto de partida de las iteraciones)
N = length(x);  %longitud de la senal de entrada
h = zeros(M,N);
start = M;

%Etapa recursiva
e = zeros(N,1);
A = zeros(N,1);
for n = start:N
   A(n) = h(:,n)'*y(n:-1:n-M+1);
   e(n) = x(n) - A(n);
   h(:,n+1) = h(:,n) + mu.*e(n).*conj(y(n:-1:n-M+1));
end
    
end