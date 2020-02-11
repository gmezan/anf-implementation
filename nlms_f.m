function [A, e, w]= nlms_f(x,d, b,epsilon,M)
%
% Argumentos de entrada:
% b     = tamano de paso (beta)
% epsilon     = evita que el filtro crezca mucho (valor escalar)
% M     = Tamaño del filtro (valor escalar)
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
X = convm(x,M)'; % se usa convm para disminuir el costo 
%Etapa recursiva
% considerar no poner indice de tiempo a los pesos
for n = M:N
   A(n) = w(:,n)'*X(:,n);
   e(n) = d(n) - A(n);
   w(:,n+1) = w(:,n) + b*e(n)*(X(:,n))/ (epsilon + norm(X(:,n))^2); 
end
    
end