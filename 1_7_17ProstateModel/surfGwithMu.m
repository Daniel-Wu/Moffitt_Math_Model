%Plot Fitness curves - G as a function of dose m and resist strat v, for 1
%set of coefficients at a time

%Coefficients
v = linspace(0,1,1001);     %Strategies to plot
m = linspace(0,0.5,1001);    %Drug levels to plot
o = 1;                   %Cost of resistance^2
k_max = 200;                %Max K
r = 0.1;                    %Base growth rate coefficient
E = 0.2;                    %Benefit level     %Somehow shifts all G up?
x = 200;                    %Total population
alpha = 3;                 %Coeff for impact of G
b = 4;                     %Coeff for impact of strat

G = zeros(length(v), length(m));
numericdG = G;
[V,M] = meshgrid(v,m);


    
%% Define Function
%Carrying capacity as a function of strategy
K = @(V)(k_max.*exp(-V.*V/(2*o)));

%Intermediate, unadjusted G
rawG = @(V)(r.*(1 - ((1-E).*x)./K(V)));

%surf(V,M,G) If you want to look at G before mu is added

%Drug kill as a linear function of G
D = @(V)(alpha*(1-rawG(V))); %DON'T LET THIS BE NEGATIVE
%Drug kill as a down-curve of G
%D = alpha/G;    %DON'T LET THIS BE INF

mu = @(V, currM)(currM./(D(V) + b.*V));

%Final G
finalG =@(V, currM)(rawG(V) - mu(V, currM));

%% Calc Data
for iM = 1:length(m)
    
    currM = m(iM);
    
    G(iM, :) = finalG(v, currM);
    numericdG(iM,:) = (finalG(v+0.001, currM) - finalG(v-0.001, currM))/0.002;
    
end

%Find best strategy
[zBestStrat, bestStratInd] = max(G,[],2);

yBestStrat = m;
xBestStrat = v(bestStratInd);


%Calculate dGdV
dGdV = gradient(G);


%Check code
% checkData = zeros(length(v),length(m));
% 
% for i = 1:length(v)
%     for j = 1:length(m)
%         holder = calcdUdt(x, [v(i) v(i) v(i)], [k_max k_max k_max], [r r r], m(j), [E E E], o, b, alpha);
%         checkData(i,j) = holder(1);
%         
%     end
% end

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
surf(V,M,numericdG);%dGdV)
view(3)
shading interp
contour(V,M,dGdV,[0 0],'r','lineWidth',3)

xlabel('Strategy')
ylabel('Drug')
zlabel('dGdV')