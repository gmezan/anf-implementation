close all

% Se generan todas las señales para poder verificar la implementación del
% filtro ANF implementado.

L = 250;
P = 1;
k= (0:L-1)';
% fases
phi1 = 2*pi*(0.1+0.15*(k/L)).*k*P;
phi2 = 2*pi*(0.1+0.15*exp(-2*k/L)).*k*P;

% frecuencias instantáneas: solo se usará para comparar con el resultado
% final
w1 = 2*pi*(0.1+0.3*k/L)*P;
w2 = 2*pi*(0.1+0.15*exp(-2*k/L)-0.15*(2/L)*exp(-2*k/L).*k)*P;

% generacion del ruido
var = 1;
v_ =  ((var.^0.5).*randn(L,1));   
v = filter(1, [1, 0.8], v_);

% señales de entrada:
x_1 = cos(phi1);
x_2 = cos(phi1) + 0.05 * v;
x_3 = cos(phi2);
x_4 = cos(phi2) + 0.05 * v;

% aplicando los filtros
[e1, w_1, alpha1] = anf_imp(x_1,0.7);
[e2, w_2, alpha2] = anf_imp(x_2,0.6);
[e3, w_3, alpha3] = anf_imp(x_3,0.9);
[e4, w_4, alpha4] = anf_imp(x_4,0.8);

% vizualizando los filtros al final
% b1 = [1, -2*cos(w_1(end)) , 1]; 
% a1 = [1, -2*cos(w_1(end))*alpha1(end), alpha1(end).^2];
% freqz(b1,a1)
% b2 = [1, -2*cos(w_2(end)) , 1]; 
% a2 = [1, -2*cos(w_2(end))*alpha2(end), alpha2(end).^2];
% freqz(b2,a2)
% b3 = [1, -2*cos(w_3(end)) , 1]; 
% a3 = [1, -2*cos(w_3(end))*alpha3(end), alpha3(end).^2];
% freqz(b3,a3)
% b4 = [1, -2*cos(w_4(end)) , 1]; 
% a4 = [1, -2*cos(w_4(end))*alpha4(end), alpha4(end).^2];
% freqz(b4,a4)



figure(1)
subplot(2,2,1)
plot(x_1)
title("Señal original")
subplot(2,2,2)
plot(e1)
title("Salida del ANF")
subplot(2,2,3)
plot(k,w_1,k,w1)
legend('estimado','real')
title("Estimacion de frecuencia: -2*cos(w)")
subplot(2,2,4)
plot(alpha1)
title("alpha")



figure(2)
subplot(2,2,1)
plot(x_2)
title("Señal original")
subplot(2,2,2)
plot(e2)
title("Salida del ANF")
subplot(2,2,3)
plot(k,w_2,k,w1)
legend('estimado','real')
title("Estimacion de frecuencia")
subplot(2,2,4)
plot(alpha2)
title("alpha")




figure(3)
subplot(2,2,1)
plot(x_3)
title("Señal original")
subplot(2,2,2)
plot(e3)
title("Salida del ANF")
subplot(2,2,3)
plot(k,w_3,k,w2)
legend('estimado','real')
title("Estimacion de frecuencia")
subplot(2,2,4)
plot(alpha3)
title("alpha")



figure(4)
subplot(2,2,1)
plot(x_4)
title("Señal original")
subplot(2,2,2)
plot(e4)
title("Salida del ANF")
subplot(2,2,3)
plot(k,w_4,k,w2)
legend('estimado','real')
title("Estimacion de frecuencia")
subplot(2,2,4)
plot(alpha4)
title("alpha")

