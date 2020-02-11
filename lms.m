function [Y,E, w] = lms(x,d,mu,nord,a0)
% Implementación basada en el libro 
% "Statistical Digital Signal Processing and Modeling"
% (John Wiley & Sons, 1996).
%
% Argumentos de entrada:
% mu    = tamano de paso (valor escalar)
% nord  = longitud del filtro (valor escalar)
% x     = senal de entrada, vector de dimension Nx1
% d     = senal de referencia/deseada, vector de dimension Nx1
% a0    = valor inicial (valor escalar)
% 
% Argumentos de salida:
% E     = vector de errores de estimacion, dimension Nx1
% Y  = vector de salida que aproxima a la senal deseada, dimension Nx1
% w  = fitro, dimension Nx1

X = convm(x,nord);
[M,N] = size(X);
if nargin < 5, a0 = zeros(1,N); end
a0 = a0(:)';
E = zeros(M-nord+1,1);
E(1) = d(1) - a0*X(1,:)';
w(1,:) = a0 + mu*E(1)*(X(1,:));
if M > 1
    Y = zeros(M-nord+1,1);
    for k = 2:M-nord+1
        Y(k) =  w(k-1,:)*X(k,:)';
        E(k) = d(k) - Y(k);
        w(k,:) = w(k-1,:) + mu*E(k)*(X(k,:));
    end
end
