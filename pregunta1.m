% 
clc
clear all; 
close all;

% En este ejemplo se tiene un cancelador de ruido, se tiene una señal de
% ruido proviniente de un sensor, y se tiene la señal deseada con una
% cantidad de ruido adicionada. La idea del cancelador de ruido es a partir
% de la señal deseada con ruido, obtener una señal estimada con la señal
% medida con el sensor y de esta forma eliminar el ruido y solo tener la
% señal deseada

N = 1000;
n = 1:N;
d = sin(0.05*pi*n)';  % Señal deseada

var1 = 1;
var2 = linspace(0.25,6,1000);
v1 =  ((var1.^0.5).*randn(1,N))';  % rudio estacionario
v2 =  ((var2.^0.5).*randn(1,N))';  % ruido no estacionario

% Las señales a continuacion representan el ruido, v_1 será el ruido
% acoplado a la señal deseada, v_2 será el ruido medido con un sensor
% exterior. Ambos ruidos están correlacionados.
v_1 = filter(1, [1, -0.8], v1);  % ruido sensor 1
v_2 = filter(1, [1, 0.6], v1);

% Las señales a continuacion representan el ruido, v_3 será el ruido
% acoplado a la señal deseada, v_4 será el ruido medido con un sensor
% exterior. Ambos ruidos están correlacionados.
v_3 = filter(1, [1, -0.8], v2);  % ruido sensor 2
v_4 = filter(1, [1, 0.6], v2);

% con ruido no estacionario:
%v_1 = v_3(:);
%v_2 = v_4(:);

x = d + v_1; % x es la señal deseada con el ruido

clc
% Se muestran los tiempos de ejecucion

% Filtro LMS implementacion 2
fprintf("Tiempo lms_f: \n");
tic
[v1_est, e1, w1]=lms_f(v_2,x,0.02,12);
toc

% filtro LMS implementacion del libto
fprintf("Tiempo lms: \n");
tic
[v1_est, e, w]=lms(v_2,x,0.01,12);
toc


% Filtro NLMS 
fprintf("Tiempo nlms_f\n");
tic
[v1_est3, e2, w2]=nlms_f(v_2,x, 0.2,0.0001,12);
toc

% Filtro RLS 
fprintf("Tiempo rls_f\n");
tic
[v1_est4, e3, w3]=rls_f(v_2,x,12,0.99);
toc

% Se muestran los resultados del filtrado
figure(1) 
subplot(5,1,1); plot(d); title('Senal de interes');
subplot(5,1,2); plot(x); title('Senal observada, x');
subplot(5,1,3); plot(x-v1_est); title('Senal recuperada, filtro LMS');
subplot(5,1,4); plot(x-v1_est3); title('Senal recuperada, filtro NLMS ');
subplot(5,1,5); plot(x-v1_est4); title('Senal recuperada, filtro RLS ');


