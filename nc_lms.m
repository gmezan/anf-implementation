%% b) escenario 1 e(n) = v1(n) - v1_est(n)
n = 0:999;
d = sin(0.05*pi*n)';  %GENERACION DE SENAL A ESTIMAR (DESEADA)
N = 1000;

var = 1; 
% Cambiar por var = linspace(0.25,6.25,1000) si es que se desea ruido no
% estacionario

v =  ((var.^0.5).*randn(1,N))';     %RUIDO BLANCO (MEDIA 0, VARIANZA 1)
v_1 = filter(1, [1, -0.8], v);  %RUIDO MEDIDO POR CADA SENSOR (PROCESOS AR(1))
v_2 = filter(1, [1, 0.6], v);

x = d + v_1;
figure(1); subplot(6,1,1); plot(d); title('Senal de interes');
subplot(6,1,2); plot(x); title('Senal observada (sensor 1)');
%subplot(6,1,3); plot(v_2); title('Ruido observado (sensor 2)');

clc
%Invocar aqui la funcion implementada lms_func
tic
[v1_est, e]=lms_f(0.02,12,v_2,v_1);

toc
tic
[v1_est2, e]=lms_func(0.02,12,v_2,v_1);
toc

tic
[v1_est3, e]=lms(v_2,v_1,0.02,12);
toc

tic
[v1_est4, e]=rls_f(v_2,v_1,12,0.999);
toc

subplot(6,1,3); plot(x-v1_est2); title('Senal recuperada esenario 1 orignal');
subplot(6,1,4); plot(x-v1_est); title('Senal recuperada esenario 1 lmsf');
subplot(6,1,5); plot(x-v1_est3); title('Senal recuperada esenario 1 lms ');
subplot(6,1,6); plot(x-v1_est4); title('Senal recuperada esenario 1 rls ');

%% b) escenario 2 e(n) = x(n) - v1_est(n)
n = 0:999;
d = sin(0.05*pi*n)';  %GENERACION DE SENAL A ESTIMAR (DESEADA)
N = 1000;

var = 1; 
% Cambiar por var = linspace(0.25,6.25,1000) si es que se desea ruido no
% estacionario

v =  ((var.^0.5).*randn(1,N))';     %RUIDO BLANCO (MEDIA 0, VARIANZA 1)
v_1 = filter(1, [1, -0.8], v);  %RUIDO MEDIDO POR CADA SENSOR (PROCESOS AR(1))
v_2 = filter(1, [1, 0.6], v);

x = d + v_1;
figure; subplot(5,1,1); plot(d); title('Senal de interes');
subplot(5,1,2); plot(x); title('Senal observada (sensor 1)');
subplot(5,1,3); plot(v_2); title('Ruido observado (sensor 2)');


%Invocar aqui la funcion implementada lms_func
[v1_est, e]=lms_func(0.02,12,v_2,x);

subplot(5,1,4); plot(v1_est); title('Senal estimada');
subplot(5,1,5); plot(x-v1_est); title('Senal recuperada escenario 2');

% b) si se puede observar una diferencia en el rendimiento del filtro, pero
% no es muy significativa. En principio, con el escenario 1 se obtiene una
% se�al un poco mejor a la que se obtiene con el escenario 2, debido a que
% en el primer caso se usa directamente el ruido observado para poder
% suprimirlo. Por otro lado, en el segundo caso, se usa la se�al  con el
% ruido acoplado para poder suprimir el mismo ruido acoplado con el ruido
% observado. El hecho de que el segundo caso tambi�n funcione bien, se debe
% a que la se�al d est� muy poco correlacionada con el ruido a la entrada,
% y al realizar la actualizaci�n del filtro, en el h (coeficientes del filtro)
% se anular� la parte de d y se quedar� con la  resta del ruido v_1 y el
% ruido v_1 estimado, lo cual har� que el la se�al de salida se parezca m�s
% al ruido estimado y a la vez la se�al d_est = d + v_1 - v_1_est se parezca
% m�s a d:
% v1_est = v_2(n) * (hn + (d(n) + v_1(n) - v_1_est(n)) * v_2(n)))
% la parte de d(n) * v_2(n) ser� aprox cero por la baja correlaci�n,
% entonces:
% v1_est = v_2(n) * (hn + (v_1(n) - v_1_est(n)) * v_2(n)))
% Por el criterio de convergencia, la variacion del h: 
% (v_1(n) - v_1_est(n)) * v_2(n)) tiene que tender a cero, entonces en el
% infinito : v_1(n) = v_1_est(n)


%% c)

n = 0:999;
d = sin(0.05*pi*n)';  %GENERACION DE SENAL A ESTIMAR (DESEADA)
N = 1000;

var = linspace(0.25,6.25,1000); 
% Cambiar por var = linspace(0.25,6.25,1000) si es que se desea ruido no
% estacionario

v =  ((var.^0.5).*randn(1,N))';     %RUIDO BLANCO (MEDIA 0, VARIANZA 1)
v_1 = filter(1, [1, -0.8], v);  %RUIDO MEDIDO POR CADA SENSOR (PROCESOS AR(1))
v_2 = filter(1, [1, 0.6], v);

x = d + v_1;
figure; subplot(5,1,1); plot(d); title('Senal de interes');
subplot(5,1,2); plot(x); title('Senal observada (sensor 1)');
subplot(5,1,3); plot(v_2); title('Ruido observado (sensor 2)');


%Invocar aqui la funcion implementada lms_func
[v1_est, e]=lms_func(0.02,12,v_2,v_1);

subplot(5,1,4); plot(v1_est); title('Senal estimada');
subplot(5,1,5); plot(x-v1_est); title('Senal recuperada');

%c) al aplicar el ruido no wss es imposible recuperar la se�al, esto se
%debe a que ahora la se�al de error adem�s de que es muy grande, tiene una
%variaci�n muy "brusca". Entonces, la parte de restar x- v1_est, arrojar�
%un valor muy grande, que har� que la gradiente tambi�n lo sea y al volver
%a ser multiplicada y restada a la se�al vista x, la se�al d ser� anulada.



%%  nc_nlms:

n = 0:999;
d = sin(0.05*pi*n)';  %GENERACION DE SENAL A ESTIMAR (DESEADA)
N = 1000;

var = linspace(0.25,6.25,1000); 
% Cambiar por var = linspace(0.25,6.25,1000) si es que se desea ruido no
% estacionario

v =  ((var.^0.5).*randn(1,N))';     %RUIDO BLANCO (MEDIA 0, VARIANZA 1)
v_1 = filter(1, [1, -0.8], v);  %RUIDO MEDIDO POR CADA SENSOR (PROCESOS AR(1))
v_2 = filter(1, [1, 0.6], v);

x = d + v_1;
figure; subplot(5,1,1); plot(d); title('Senal de interes');
subplot(5,1,2); plot(x); title('Senal observada (sensor 1)');
subplot(5,1,3); plot(v_2); title('Ruido observado (sensor 2)');


%Invocar aqui la funcion implementada lms_func
clc
tic
[v1_est, e]=nlms_f(0.2,0.0001,12,v_2,v_1);
toc
tic
[v1_est2, e]=nlms_func(0.2,0.0001,12,v_2,v_1);
toc
subplot(5,1,4); plot(x-v1_est2); title('Senal recuperada esenario 1 orignal');
subplot(5,1,5); plot(x-v1_est); title('Senal recuperada esenario 1 lmsf');


% e) Al usar nlms, se soluciona la cancelaci�n de ruido dr�sticamente, esto
% se debe a que ahora el tama�o de la gradiente ya no afecta a al error,
% entonces no anular� a la se�al d, sino que ahora solo anular� la parte
% necesaria de la se�al x para que se pueda restar solo la se�al de ruido.
% En otras palabras, el gradiente (d estimado) dar� la direcci�n de
% actualizaci�n pero el tama�o estar� dado solo por la diferencia entre los
% ruidos obervados.

