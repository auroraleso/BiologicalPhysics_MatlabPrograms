Model = DualStateModel(0.1,100000,0.02,0.04,50)

function DualStateModel(dt,T,alpha,beta,Io)
%{
    Syntax
    -dt is simulation time step (ms), with the hypotesis of not having more
    than a single closure or opening event in the dt period
    - T is total time of simulation (ms)
    - alpha is the opening probability P_o during dt --> P_o = alpha * dt
    - beta is the closure probability P_c during dt --> P-c = beta * dt
    - Io is the current of the open state (pA)
%}

N = ceil(T/dt);
%Y = ceil(X) rounds each element of X to the nearest integer greater than or equal to that element.
state = zeros(1,N); %1D array of N elements, all initialized to 0

curr_state = 0; %set the initial state as closed
t = dt
T_arr = dt * [1:N] %array of absolute time

%set opening and closure probabilities
p_o = alpha * dt
p_c = beta * dt

for i = 1:(N-1)
    if curr_state == 0,
        if rand <= p_o, %generate random variable and check if is under the opening probability
            curr_state = 1; %update to open status
            state(i+1) = 1;
            t = dt;
        else
            curr_state = 0;
            t = t+dt;
        end
    else
        if rand <= p_c,
            curr_state = 0;
            t = dt;
        else
            curr_state = 1;
            state(i+1) = 1;
            t = t+dt;
        end
    end
end

%plot time curse of channel current
figure;
real_curr = Io * (state+(randn(1,N))*0.05);
plot(T_arr,real_curr);
end



