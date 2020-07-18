function distortion= distortion(d_bar, Theta, N, r)
% -------------------------------------------------------------------------
% Calculate the network risk-taking distortion
% -------------------------------------------------------------------------
global P_j;
state_number = 2^(N-1);
state = dec2bin((1:state_number)-1);
distortion = 0;
for i = 1:length(state)
    if i< length(state)
        state(i,:);
        omega =  convert(state(i,:));
        global Theta_ff Theta_fs one_f one_s s f;
        s = [find(omega);N];
        f = find(omega-1);
        Theta_ff = Theta(f',f');
        Theta_fs = Theta(f',s');
        one_f = ones(size(f));
        one_s = ones(size(s));
        options = optimset('Display','off');
        fun = @(x) payment_solver(x,d_bar,r);
        d_f = fsolve(fun,ones(size(f))*d_bar, options);
        dist = d_bar - (Theta(N,s) * one_s  * d_bar + Theta(N,f)*d_f);
        distortion = dist * (1-P_j)^length(f) * (P_j)^(length(s)-1) ...
                                                              + distortion;
    end
end
end

function F = payment_solver(d_f, d_bar, r)
% -------------------------------------------------------------------------
% Payment equilibrium fixed point system
% -------------------------------------------------------------------------
global Theta_ff Theta_fs one_f one_s f ;
global v ;
if Theta_ff * d_f + Theta_fs * one_s * d_bar + r*one_f - v*one_f <...
                                                        d_bar*ones(size(f))
F = max([Theta_ff * d_f + Theta_fs * one_s * d_bar + r*one_f - v*one_f,...
                                                  zeros(size(f))]')' - d_f;
else
F = d_bar*ones(size(f))- d_f;
end
end

function output = convert(input)
n=length(input);
output=zeros(n,1);
for k=1:n
    output(k)=str2double(input(k));
end
end

