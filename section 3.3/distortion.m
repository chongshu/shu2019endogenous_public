function  distortion= distortion(d_bar, Theta, N)
% -------------------------------------------------------------------------
% Calculate the network risk-taking distortion
% -------------------------------------------------------------------------
global P_j;
global Theta_ff Theta_fs one_f one_s s f;
state_number = 2^(N-1);
state = dec2bin((1:state_number)-1);
distortion = 0;
for i = 1:length(state)  
    if i< length(state)
        state(i,:);
        omega =  convert(state(i,:));
        s = [find(omega);N];
        f = find(omega-1);
        Theta_ff = Theta(f',f');
        Theta_fs = Theta(f',s');
        one_f = ones(size(f));
        one_s = ones(size(s));
        options = optimset('Display','off');
        fun = @(x) payment_solver(x,d_bar);
        d_f = fsolve(fun,ones(size(f))*d_bar, options);
        dist = d_bar - (Theta(N,s) * one_s  * d_bar + Theta(N,f)*d_f);
        distortion = dist * (1-P_j)^length(f) * (P_j)^(length(s)-1) ...
                                                              + distortion;
    end
end
end

function F = payment_solver(d_f, d_bar)
% -------------------------------------------------------------------------
% Payment equilibrium fixed point system
% -------------------------------------------------------------------------
global Theta_ff Theta_fs one_f one_s f ;
global v ;
F = max([Theta_ff * d_f + Theta_fs * one_s * d_bar - v*one_f...
                                            , zeros(size(f))]')'...
                                                                   - d_f ;
end

function output = convert(input)
n=length(input);
output=zeros(n,1);
for k=1:n
    output(k)=str2double(input(k));
end
end

