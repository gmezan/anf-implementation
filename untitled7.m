% parámetros del filtro notch
w = 2*pi*0.05;
alpha = 0.99;
b = [1, -2*cos(w), 1];
a = [1, -2*cos(w)*alpha, alpha^2];

% t
t = 1:500;

% AWGN
var = 1;
v =  ((var.^0.5).*randn(1,length(t)))';   

% señales
A = 5;
x = A*cos(w.*t)' + A*cos(2*w.*t)';
y = filter(b,a,x)';



figure(1)
subplot(2,1,1)
plot(x )
subplot(2,1,2)
plot(y)

figure(2)
freqz(b,a)