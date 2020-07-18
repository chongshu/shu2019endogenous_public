function Z_star = standalone_solver(P_risky)
% -------------------------------------------------------------------------
% solve countries' risk-taking choices if stand alone
% -------------------------------------------------------------------------
global total_net_debt
E_pi_safe = (1 - total_net_debt);
E_pi_risky = (1.1 - total_net_debt) .* P_risky;
Z_star = double(E_pi_safe > E_pi_risky);
end

function output = convert(input)
n=length(input);
output=zeros(n,1);
for k=1:n
    output(k)=str2double(input(k));
end
end