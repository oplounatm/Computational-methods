dt = 20; T = 100;
f = @(u,t) 0.1*(1-u/500)*u;
U_0 = 100;

[u_old, t_old] = ode_FE(f, U_0, dt, T);
k = 1;
answer = 'yes';

while answer == true
    dt_k = 2^(-k)*dt;
    [u_new, t_new] = ode_FE(f, U_0, dt_k, T);
    plot(t_old, u_old, 'b-', t_new, u_new, 'r--')
    xlabel('t'); ylabel('N(t)'); 
    fprintf('Timestep was: %g\n', dt_k);
    answer = input('Do one more with finer dt (y/n)? ', 's')
    if answer == 'yes'
        u_old = u_new;
        t_old = t_new;
    else
        answer = false;
    end
    k = k + 1;
end

function [sol, time] = ode_FE(f, U_0, dt, T)
N_t = floor(T/dt);
u = zeros(N_t+1, 1);
t = linspace(0, N_t*dt, length(u));
u(1) = U_0;
for n = 1:N_t
u(n+1) = u(n) + dt*f(u(n), t(n));
end
sol = u;
time = t;
end