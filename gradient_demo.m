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
%desciende más lento que en los 3 otros casos, pero no fluctúa tanto. Por
%otro lado, cuando alpha = 5, converge más rápido pero se puede ver una
%ligera fluctuación. En el caso de alpha= 10, hay bastante fluctuación pero
%al final converge. Esto se debe a que el gradiente depende directamente
%del factor alpha. Este factor al ser más grande, generará una mayor
%variación al gradiente y por tanto habrán cambios más grandes
%(fluctuaciones). Una forma para evitar esto sería usar NLMS para que el
%módulo del gradiente no afecte y solo brinde la dirección. Por tanto, el
%escenario donde resultará más difícil será alpha =10, porque los pasos son
%más grandes.

%b)Cuando se cambia los valores por 0.2, y al ser alpha=10, se obtendrá un
%gradiente bastante grande, lo cual significará que las variaciones serán
%aún mayores por el tamaño de los pasos. En la gráfica se pudo observar que hay muchas fluctuaciones
%en los 3 casos, y no se puede ver si al final se converge o solo varía
%entre el valor óptimo.
