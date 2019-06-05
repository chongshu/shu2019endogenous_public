function  distortion= solver(d_bar, Theta, N)
global P_j v ;
state_number = 2^(N-1);
state = dec2bin((1:state_number)-1);
distortion = 0;
for i = 1:length(state)  %%%%%%%% Except All fail or All succeed
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
        fun = @(x) payment_solver(x,d_bar);
        d_f = fsolve(fun,ones(size(f))*d_bar, options);
        dist = d_bar - (Theta(N,s) * one_s  * d_bar + Theta(N,f)*d_f);
        distortion = distortion + dist * (1-P_j)^length(f) * (P_j)^(length(s)-1);
    end
    if i ==length(state)
        dist = 0;
    end
     fprintf('d_bar is %d \n' , d_bar);
    fprintf('In loop %d of out of %d \n' , i ,length(state));
end
end