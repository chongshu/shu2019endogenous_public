% Endogenous Risk-Exposure and Systemic Instability (2020)
% Replication Code for Table in Section 3.4
% Date: 5/10/2020
% -------------------------------------------------------------------------
% Each country is to choose an economy from a safe or risky choice.
% If safe
%             e = 1 w.p 1
%             e = 0 w.p 0
% If risky
%             e = 1.1 w.p  P_risky
%             e = 0   w.p  1 - P_risky
% -------------------------------------------------------------------------

clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data Initialation
% -------------------------------------------------------------------------
% debt_matrix                --- Cross-holdings of debt among six European
%                                countries France, Germany, Greece, Italy,
%                                Portungal, and Spain. The data is provided
%                                by Elliott, Golub, and Jackson (2014)   
% normalizer                 --- 20 years of the countries' GDP. The spirit
%                                is to let country choose a safe/risky
%                                economy with a 0.95 discount factor. 
% inter_country_liability    --- The total inter-country liabilities of
%                                each country. (column sum of debt_matrix)
% Theta                      --- Share of country i's inter-country claim
%                                on country j's total inter-country
%                                liability. (column sum should be 1; row
%                                sum is not necessarily one due to
%                                irregular network ) 
% inside_debt                --- following Elliott, Golub and Jackson
%                                (2014), I use Reinhart and Rogoff (2011)'s
%                                estimation: a country's inside debt is 2/3
%                                of its total debt. This variable is
%                                similar to v in equation 2 of the paper.
% total_net_debt             --- This is the total net debt of each
%                                country. This is used in the
%                                counterfactual scenario when countries are
%                                not connected (stand-alone)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global debt_matrix Theta inter_country_liability inside_debt ...
       total_net_debt normalizer Theta_complete
   
debt_matrix = csvread('debt.csv');
normalizer = csvread('gdp.csv') * 20;                                                        
inter_country_liability = ones(1,6) * debt_matrix ;                                          
Theta = debt_matrix ./ inter_country_liability;
inside_debt = inter_country_liability*2 ./ normalizer;                                       
total_net_debt =  inside_debt + ...
                  (sum(debt_matrix,1)  - sum(debt_matrix,2)')./ normalizer;

Theta_complete = ones(6,6)/(6-1) - eye(6)/(6-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Equilibrium Risk-taking
% ----------------------------------------------------------------------
% Z = 1: choosing safe economy
% Z = 0: choosing risky economy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for P_risky = [.900 .906 .909 .910]
fprintf('P_risky = %g', P_risky)
fprintf('\nconnected risk-taking:     ')
fprintf('%g ', network_solver(P_risky))
fprintf('\nstand-alone risk-taking:   ')
fprintf('%g ', standalone_solver(P_risky))
fprintf('\n\n')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESULT
% -------------------------------------------------------------------------
% P_risky = 0.9
% connected risk-taking:     1 1 1 1 1 1 
% stand-alone risk-taking:   1 1 1 1 1 1 
% 
% P_risky = 0.906
% connected risk-taking:     1 1 0 1 0 1 
% stand-alone risk-taking:   1 1 0 1 0 1 
% 
% P_risky = 0.909
% connected risk-taking:     0 0 0 0 0 0 
% stand-alone risk-taking:   1 0 0 0 0 0 
% 
% P_risky = 0.91
% connected risk-taking:     0 0 0 0 0 0 
% stand-alone risk-taking:   0 0 0 0 0 0 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
 
 
 
 
