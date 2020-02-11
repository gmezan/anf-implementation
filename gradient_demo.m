%funcion a minimizar
alpha=2.5;
f = @(x)( x(1)^2 + alpha*x(2)^2 ) /2;
%campo de valores para graficar el 'fondo' de la funcion
t = linspace(-.7,.7,101);
[u,v] = meshgrid(t,t);
F = ( u.^2 + alpha*v.^2 )/2 ;

%metodo para calcular el graficar el gradiente de la funcion
Gradf = @(x)[x(1); alpha*x(2)];
%aplicacion del algoritmo 'gradient descent' para tres valores diferentes
%del tamano de paso (tau)
mulist = [0.03 0.1 0.17];
xinit = [[.7;.7],[-.7;.5],[-.7;-.6]]; %(se utilizan 3 valores iniciales distintos solo para facilitar la visualizacion de la grafica)
collist = {'k' 'g' 'r'};

clf; hold on;
imagesc(t,t,F); colormap jet(256);
contour(t,t,F, 20, 'k');
for k=1:length(mulist)
    mu = mulist(k);
    
    x = xinit(:,k);
    niter = 100;
    X = [];
    for i=1:niter
        X(:,i) = x;
        x = x - mu*Gradf(x);
    end
    %grafico del progreso del algoritmo en cada caso
    h = plot(X(1,:), X(2,:), [collist{k} '.-']);
    set(h, 'LineWidth', 2);
    set(h, 'MarkerSize', 15);
    axis off; axis equal;
end
%%
%funcion a minimizar
alpha=5;
f = @(x)( x(1)^2 + alpha*x(2)^2 ) /2;
%campo de valores para graficar el 'fondo' de la funcion
t = linspace(-.7,.7,101);
[u,v] = meshgrid(t,t);
F = ( u.^2 + alpha*v.^2 )/2 ;

%metodo para calcular el graficar el gradiente de la funcion
Gradf = @(x)[x(1); alpha*x(2)];
%aplicacion del algoritmo 'gradient descent' para tres valores diferentes
%del tamano de paso (tau)
mulist = [0.03 0.1 0.17];
xinit = [[.7;.7],[-.7;.5],[-.7;-.6]]; %(se utilizan 3 valores iniciales distintos solo para facilitar la visualizacion de la grafica)
collist = {'k' 'g' 'r'};

clf; hold on;
imagesc(t,t,F); colormap jet(256);
contour(t,t,F, 20, 'k');
for k=1:length(mulist)
    mu = mulist(k);
    
    x = xinit(:,k);
    niter = 100;
    X = [];
    for i=1:niter
        X(:,i) = x;
        x = x - mu*Gradf(x);
    end
    %grafico del progreso del algoritmo en cada caso
    h = plot(X(1,:), X(2,:), [collist{k} '.-']);
    set(h, 'LineWidth', 2);
    set(h, 'MarkerSize', 15);
    axis off; axis equal;
end

%%
%funcion a minimizar
alpha=10;
f = @(x)( x(1)^2 + alpha*x(2)^2 ) /2;
%campo de valores para graficar el 'fondo' de la funcion
t = linspace(-.7,.7,101);
[u,v] = meshgrid(t,t);
F = ( u.^2 + alpha*v.^2 )/2 ;

%metodo para calcular el graficar el gradiente de la funcion
Gradf = @(x)[x(1); alpha*x(2)];
%aplicacion del algoritmo 'gradient descent' para tres valores diferentes
%del tamano de paso (tau)
mulist = [0.03 0.1 0.17];
xinit = [[.7;.7],[-.7;.5],[-.7;-.6]]; %(se utilizan 3 valores iniciales distintos solo para facilitar la visualizacion de la grafica)
collist = {'k' 'g' 'r'};

clf; hold on;
imagesc(t,t,F); colormap jet(256);
contour(t,t,F, 20, 'k');
for k=1:length(mulist)
    mu = mulist(k);
    
    x = xinit(:,k);
    niter = 100;
    X = [];
    for i=1:niter
        X(:,i) = x;
        x = x - mu*Gradf(x);
    end
    %grafico del progreso del algoritmo en cada caso
    h = plot(X(1,:), X(2,:), [collist{k} '.-']);
    set(h, 'LineWidth', 2);
    set(h, 'MarkerSize', 15);
    axis off; axis equal;
end


%%
%%
%funcion a minimizar
alpha=10;
f = @(x)( x(1)^2 + alpha*x(2)^2 ) /2;
%campo de valores para graficar el 'fondo' de la funcion
t = linspace(-.7,.7,101);
[u,v] = meshgrid(t,t);
F = ( u.^2 + alpha*v.^2 )/2 ;

%metodo para calcular el graficar el gradiente de la funcion
Gradf = @(x)[x(1); alpha*x(2)];
%aplicacion del algoritmo 'gradient descent' para tres valores diferentes
%del tamano de paso (tau)
mulist = [0.2 0.2 0.2];
xinit = [[.7;.7],[-.7;.5],[-.7;-.6]]; %(se utilizan 3 valores iniciales distintos solo para facilitar la visualizacion de la grafica)
collist = {'k' 'g' 'r'};

clf; hold on;
imagesc(t,t,F); colormap jet(256);
contour(t,t,F, 20, 'k');
for k=1:length(mulist)
    mu = mulist(k);
    
    x = xinit(:,k);
    niter = 100;
    X = [];
    for i=1:niter
        X(:,i) = x;
        x = x - mu*Gradf(x);
    end
    %grafico del progreso del algoritmo en cada caso
    h = plot(X(1,:), X(2,:), [collist{k} '.-']);
    set(h, 'LineWidth', 2);
    set(h, 'MarkerSize', 15);
    axis off; axis equal;
end

%%
%a) En el primer caso cuando alpha = 2.5, se puede ver que la gradiente
%desciende m�s lento que en los 3 otros casos, pero no fluct�a tanto. Por
%otro lado, cuando alpha = 5, converge m�s r�pido pero se puede ver una
%ligera fluctuaci�n. En el caso de alpha= 10, hay bastante fluctuaci�n pero
%al final converge. Esto se debe a que el gradiente depende directamente
%del factor alpha. Este factor al ser m�s grande, generar� una mayor
%variaci�n al gradiente y por tanto habr�n cambios m�s grandes
%(fluctuaciones). Una forma para evitar esto ser�a usar NLMS para que el
%m�dulo del gradiente no afecte y solo brinde la direcci�n. Por tanto, el
%escenario donde resultar� m�s dif�cil ser� alpha =10, porque los pasos son
%m�s grandes.

%b)Cuando se cambia los valores por 0.2, y al ser alpha=10, se obtendr� un
%gradiente bastante grande, lo cual significar� que las variaciones ser�n
%a�n mayores por el tama�o de los pasos. En la gr�fica se pudo observar que hay muchas fluctuaciones
%en los 3 casos, y no se puede ver si al final se converge o solo var�a
%entre el valor �ptimo.
