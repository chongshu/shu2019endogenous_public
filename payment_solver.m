function F = payment_solver(d_f, d_bar)
    global Theta_ff Theta_fs one_f one_s s f ;
    global v ;
%     F = max([Theta_ff * d_f + Theta_fs * one_s * d_bar - v*one_f, zeros(size(f))]')' - d_f ;
    if Theta_ff * d_f + Theta_fs * one_s * d_bar - v*one_f < d_bar*ones(size(f))
         F = max([Theta_ff * d_f + Theta_fs * one_s * d_bar - v*one_f, zeros(size(f))]')' - d_f ;
    else
        F = d_bar*ones(size(f))- d_f;
    end
end