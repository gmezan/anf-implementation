function [A, e, w]=lms_f(x,d,mu,M)
%
% Argumentos de entrada:
% mu    = tamano de paso (valor escalar)
% M     = longitud del filtro (valor escalar)
% x     = senal de entrada, vector de dimension Nx1
% d     = senal de referencia/deseada, vector de dimension Nx1
%
% Argumentos de salida:
% e     = vector de errores de estimacion, dimension Nx1
% A  = vector de salida que aproxima a la senal deseada, dimension Nx1
% w  = fitro, dimension Nx1

%Inicializacion del algoritmo
N = length(d);  %longitud de la senal de entrada
w = zeros(M,N+1);
e = zeros(N,1);
A = zeros(N,1);
X = convm(x,M)'; % se usa convm para hacer más rápido el algoritmo
%Etapa recursiva
for n = M:N
   A(n) = w(:,n)'*X(:,n);
   e(n) = d(n) - A(n);
   w(:,n+1) = w(:,n) + mu*e(n)*(X(:,n)); 
end
    
end