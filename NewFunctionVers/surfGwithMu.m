%Plot Fitness curves - G as a function of dose m and resist strat v, for 1
%set of coefficients at a time

%Coefficients
v = linspace(0,1,1001);     %Strategies to plot
m = linspace(0,0.1,1001);    %Drug levels to plot
o = 0.2;                      %Cost of resistance^2
k_max = 200;                %Max K
r = 0.1;                    %Base growth rate coefficient
E = 0.2;                    %Benefit level     %Somehow shifts all G up?
x = 200;                    %Total population
alpha = 0.1;                  %Coeff for impact of G
b = 5;                      %Coeff for impact of strat

[V,M] = meshgrid(v,m);
%Carrying capacity as a function of strategy
K = k_max.*exp(-V.*V/(2*o));

%Intermediate, unadjusted G
G = r.*(1 - ((1-E).*x)./K);

%surf(V,M,G) If you want to look at G before mu is added

%Drug kill as a linear function of G
D = alpha*(1-G); %DON'T LET THIS BE NEGATIVE
%Drug kill as a down-curve of G
%D = alpha/G;    %DON'T LET THIS BE INF

mu = M./(D + b.*V);

%Final G
G = G - mu;

%Find best strategy
[zBestStrat, bestStratInd] = max(G,[],2);

yBestStrat = m;
xBestStrat = v(bestStratInd);


%Calculate dGdV
dGdV = gradient(G);

figure;
%Plot G
subplot(1,2,1)
hold on
surf(V,M,G)
view(3)
shading interp

plot3(xBestStrat, yBestStrat, zBestStrat,'r','lineWidth',3)
xlabel('Strategy')
ylabel('Drug')
zlabel('G')

%Plot dGdV
subplot(1,2,2)
hold on
surf(V,M,dGdV)
view(3)
shading interp
contour(V,M,dGdV,[0 0],'r','lineWidth',3)

xlabel('Strategy')
ylabel('Drug')
zlabel('dGdV')