function [A, e, W] = rls_f(x,d,nord,lambda)
% Implementación basada en el libro 
% "Statistical Digital Signal Processing and Modeling"
% (John Wiley & Sons, 1996).
%
% Argumentos de entrada:
% x     = senal de entrada, vector de dimension Nx1
% d     = senal de referencia/deseada, vector de dimension Nx1
% nord  = longitud del filtro (valor escalar)
% lambda  = valor inicial (valor escalar)
% 
% Argumentos de salida:
% e     = vector de errores de estimacion, dimension Nx1
% A  = vector de salida que aproxima a la senal deseada, dimension Nx1
% W  = fitro, dimension Nx1

delta=0.001;
X=convm(x,nord);
[M,N] = size(X);
if nargin < 4, lambda = 1.0; end
P = eye(N)/delta;
W(1,:) = zeros(1,N);
A = zeros(N,1);
alpha = A(:);
for k=2:M-nord+1
    z=P*(X(k,:)');
    g=z/(lambda+X(k,:)*z);
    A(k) = X(k,:)*W(k-1,:)';
    alpha(k)=d(k)-A(k);
    W(k,:) = W(k-1,:) + alpha(k)*g';
    P=(P-g*z.')/lambda;
end

e = alpha;

