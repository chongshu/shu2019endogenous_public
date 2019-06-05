clear;
clc;
close();
global P_j v ;
P_j = 0.3;
v = 1;
N=10;


d_grid = linspace(v,v*(N+1),15);
grid_numer = length(d_grid);


Theta_ring = [    zeros(1,(N-1)) 1 
                eye(N-1)  zeros((N-1),1) ] ;
            
            

Theta_complete = ones(N,N)/(N-1) - eye(N)/(N-1);

Theta_lambda = Theta_complete*0.6 + Theta_ring * 0.4

distortion_ring = zeros(1,grid_numer);
distortion_complete = zeros(1,grid_numer);
distortion_lambda = zeros(1,grid_numer);

for i=1:grid_numer
    distortion_ring(i) = solver(d_grid(i),Theta_ring,N);
    distortion_complete(i) = solver(d_grid(i),Theta_complete,N);
    distortion_lambda(i) = solver(d_grid(i),Theta_lambda,N);

end

close();
linewidth = 2;

plot(d_grid,distortion_complete,'r','LineWidth',linewidth,'DisplayName','Complete Network')
hold on
plot(d_grid,distortion_ring,'b','LineWidth',linewidth,'DisplayName','Ring Network')
hold on
fig = plot(d_grid,distortion_lambda,'--','LineWidth',linewidth,'DisplayName','$\lambda = 0.6$ Network')
fig.Color = [1 0 1];
l = legend('show','Location','northwest')
set(l, 'Interpreter', 'latex')

xlabel('size of interbank liabilities, $\bar{d}$','Interpreter','latex','FontSize', 15)
ylabel('network risk-taking distortion, $\mathcal{D}$','Interpreter','latex','FontSize', 15)

str = {'$v=1$','$P_{-i} = 0.3$','$N=10$'};
dim = [0.7 0.1 0.1 0.2];
a = annotation('textbox',dim,'String',str,'FitBoxToText','on');
set(a, 'FontSize', 12)
set(a, 'Interpreter', 'latex')
axis([-inf inf -inf 3.5])
set(l, 'FontSize', 12)
set(a, 'FontSize', 12)

saveas(gcf,'figure\CompleteVSRing.eps','epsc')
saveas(gcf,'figure\CompleteVSRing.jpg')

