%Plot mu surface, as a function of dosage and G


b = 300;
v = 0.5;
m = linspace(0,2000,2001);
g = linspace(-1,1,2001);

[M,G] = meshgrid(m,g);
%Trying different functions of G to make k
%Simple linear
K = -100.*G + 200;
%plot(g,K)
%hold on
%Hyperbolic
%K = 100./(G+1.5);
%plot(g,K)

Z = -M./(K + b*v);
surf(M,G,Z)
shading interp;
title('-\mu as a function of G and m')
xlabel('M')
ylabel('G')
zlabel('-\mu')