%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Endogenous Risk-Exposure and Systemic Instability (2020)
% Replication Code for Figure 3
% Date: 5/10/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
% Data Initialation
% ----------------------------------------------------------------------
% N = 10
% P_j = 0.3
% v = 1
% -------------------------------------------------------------------------
clear;
clc;
global P_j v ;
P_j = 0.3;
v = 1;
N=10;
Theta_ring = [zeros(1,(N-1)), 1; eye(N-1),zeros((N-1),1)] ;        
Theta_complete = ones(N,N)/(N-1) - eye(N)/(N-1);
Theta_lambda = Theta_complete*0.6 + Theta_ring * 0.4;


% -------------------------------------------------------------------------
% Calculate the distortion for different d_bar
% -------------------------------------------------------------------------
d_grid = linspace(v,v*(N+1),15);
grid_number = length(d_grid);
distortion_ring = zeros(1,grid_number);
distortion_complete = zeros(1,grid_number);
distortion_lambda = zeros(1,grid_number);
for i=1:grid_number
    distortion_ring(i) = distortion(d_grid(i),Theta_ring,N);
    distortion_complete(i) = distortion(d_grid(i),Theta_complete,N);
    fprintf('d_bar is %4.2f \n' , d_grid(i));
end

% -------------------------------------------------------------------------
% Plot Figure
% -------------------------------------------------------------------------
close();
linewidth = 3;
plot(d_grid,distortion_complete,'r','LineWidth',linewidth...
                                         ,'DisplayName','Complete Network')
hold on
plot(d_grid,distortion_ring,'b','LineWidth',linewidth,...
                                              'DisplayName','Ring Network')
l = legend('show','Location','northwest');
set(l, 'Interpreter', 'latex')
xlabel('size of interbank liabilities, $\bar{d}$',...
                                      'Interpreter','latex','FontSize', 15)
ylabel('network risk-taking distortion, $\mathcal{D}$',...
                                      'Interpreter','latex','FontSize', 15)
str = {'$v=1$','$P_{-i} = 0.3$','$N=10$'};
dim = [0.7 0.1 0.1 0.2];
a = annotation('textbox',dim,'String',str,'FitBoxToText','on');
set(a, 'FontSize', 12)
set(a, 'Interpreter', 'latex')
axis([-inf inf -inf 3.5])
set(l, 'FontSize', 15)
set(a, 'FontSize', 12)
yline(distortion_complete(end),'-.','$\mathcal{D}^{max}$','Interpreter',...
           'latex', 'FontSize', 15,'LineWidth',1,'Color',[17 17 17]/255,...
                                                  'HandleVisibility','off')
saveas(gcf,'..\figure\CompleteVSRing.jpg')









