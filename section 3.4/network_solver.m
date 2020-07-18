function Z_star = network_solver(P_risky)
% -------------------------------------------------------------------------
% solve the risk-taking equilibrium (Nash Equilibrium)
% -------------------------------------------------------------------------
Z_grid = dec2bin((1:2^(6))-1); % possible candidates for the equilibrium
for i = 1:length(Z_grid) % Search for the Nash equilibrium
    Z = reshape(str2num(char(num2cell(Z_grid(i,:)))),1,[]); % e.g. [0,0,0,
                                                            % 0,0,0]     
    if isequal(fixed_point_system(Z,P_risky) , Z) % fixed point found
        Z_star = Z;
        break
    end
end
end

function F = payment_solver(d_f)
% -------------------------------------------------------------------------
% Payment equilibrium
% -------------------------------------------------------------------------
global Theta_ff Theta_fs   f  payment_s inter_country_liability;
F = max([Theta_ff * d_f + Theta_fs * payment_s ...
                                      - inter_country_liability(f)' * 2,...
                                                      zeros(size(f))]')'...
                                                                    - d_f ;
end


function dist = distortion(state)
% -------------------------------------------------------------------------
% Network-risking distortion as a function of the state of nature
% -------------------------------------------------------------------------
global normalizer inter_country_liability Theta 
global Theta_ff Theta_fs s f payment_s 
if state == '111111'
    dist = inter_country_liability' - Theta * inter_country_liability'   ;
    dist = dist ./ normalizer' ;
else
    omega =  convert(state);
    s = find(omega);
    f = find(omega-1);
    Theta_ff = Theta(f',f');
    Theta_fs = Theta(f',s');
    Theta_ss = Theta(s',s');
    Theta_sf = Theta(s',f');
    payment_s = inter_country_liability(s)';
    options = optimset('Display','off');
    fun = @(x) payment_solver(x);
    d_f = fsolve(fun,ones(size(f)), options);
    dist = zeros(6,1);
    dist(s) = inter_country_liability(s)' ...
                                   -Theta_ss * payment_s - Theta_sf * d_f ;
    dist = dist ./ normalizer' ;
end
end 


function Z_output = fixed_point_system(Z, P_risky)
% -------------------------------------------------------------------------
% Best-response function given the other's risk-taking Z_{-i}.
% -------------------------------------------------------------------------

global inside_debt
P_success = min(Z + P_risky,1); % if Z = 1, then P_success = 1;
                                % otherwise P_success = P_risky  
state_grid = dec2bin((1:2^(6))-1);
for country = 1:6
    E_pi_safe = 0;
    E_pi_risky = 0;
    P_success_safe = P_success;
    P_success_safe(country) = 1;
    P_success_risky = P_success;
    P_success_risky(country) = P_risky;
    for i = 1:length(state_grid) % calculate the expected payoff
        state = reshape(str2num(char(num2cell(state_grid(i,:)))),1,[]);
        P_state_safe = prod((P_success_safe .^ state) ...
                                   .* (1 - P_success_safe) .^ (1 - state));
        P_state_risky = prod((P_success_risky .^ state) ...
                                  .* (1 - P_success_risky) .^ (1 - state));
        dist = distortion(state_grid(i,:));
        pi_safe = (1 - inside_debt(country) -dist(country)) ...
                                                         .* state(country);
        pi_risky = (1.1 - inside_debt(country) - dist(country)) ...
                                                         .* state(country);
        E_pi_safe = E_pi_safe + pi_safe * P_state_safe;
        E_pi_risky = E_pi_risky + pi_risky * P_state_risky;
    end 
    Z_output(country) = E_pi_safe>E_pi_risky;
end
end

function output = convert(input)
n=length(input);
output=zeros(n,1);
for k=1:n
    output(k)=str2double(input(k));
end
end


 