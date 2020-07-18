%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Endogenous Risk-Exposure and Systemic Instability (2020)
% Replication Code for Figure 5
% Date: 5/10/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% -------------------------------------------------------------------------
% Data Initialation
% ----------------------------------------------------------------------
% N = 8
% P_j = 0.1
% v = 1
% -------------------------------------------------------------------------
clear;
clc;
close();
global P_j v ;
P_j = 0.1;
v = 1;
N=8;
Theta_ring = [zeros(1,(N-1)), 1; eye(N-1),zeros((N-1),1)] ;        
Theta_complete = ones(N,N)/(N-1) - eye(N)/(N-1);


% -------------------------------------------------------------------------
% Calculate the distortion for different d_bar and lambda
% -------------------------------------------------------------------------
d_grid = [linspace(N*0,N*0.3,5) linspace(N*0.3,N+1,20)];
d_grid_number = length(d_grid);
lambda_grid = linspace(0,1,20); 
lambda_grid_number = length(lambda_grid);
distortion_mat = zeros(d_grid_number,lambda_grid_number);
for i = 1:d_grid_number
    for j=1:lambda_grid_number
        d_bar = d_grid(i);
        lambda = lambda_grid(j);
        Theta_lambda = Theta_complete* lambda + Theta_ring * (1-lambda);
        distortion_mat(i,j) = distortion(d_bar,Theta_lambda,N);
        fprintf('d_bar is %4.2f \nlambda is %4.2f \n\n' , d_bar,lambda);
    end
end

% -------------------------------------------------------------------------
% Plot Figure
% -------------------------------------------------------------------------
close()
linewidth = 2;
s = surf(lambda_grid,d_grid,distortion_mat,'LineWidth',linewidth);
hold on
set(s,'LineWidth',.2)
[X,Y] = meshgrid(lambda_grid,d_grid);
h1 = plot3(X(19,:),Y(19,:),distortion_mat(19,:),...
                                     'color','#D95319','LineWidth',3);
h2 = plot3(X(9,:),Y(9,:),distortion_mat(9,:), ...
                                     'color','#EDB120','LineWidth',3);
legend([h2, h1], {'$\bar{d} = 3.4$', '$\bar{d} = 6.9$'}, 'Position', ...
              [0.16, 0.7, .15, .15],'Interpreter','latex', 'FontSize', 12);
colormap summer
xlim([0 1]);
ylim([2 N+1]);                    
zlim([1.5, 6]);
set(gca,'Xdir','reverse')
set(gca,'TickLength',[0.1, 0.01])
ylabel('$\bar{d}$','Interpreter','latex','FontSize', 15)
xlabel('$\lambda$','Interpreter','latex','FontSize', 15)
zlabel('$\mathcal{D}$','Interpreter','latex','FontSize', 15, 'Rotation', 0)
view([55 9])
saveas(gcf,'..\figure\3d.jpg')

