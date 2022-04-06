DualStateModel(0.1,1000,0.02,0.04,50)

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

%ceil(X) rounds each element of X to the nearest integer greater than or equal to that element.

state = zeros(1,N); %1D array of N elements, all initialized to 0

curr_state = 0; %set the initial state as closed
t = dt;
T_arr = dt * [1:N]; %array of absolute time

%set opening and closure probabilities
p_o = alpha * dt;
p_c = beta * dt;

for i = 1:(N-1)
    if curr_state == 0, %so our gate is closed
        if rand <= p_o, %generate random variable and check if is under the opening probability
            curr_state = 1; %update to 'open' status
            state(i+1) = 1; %the following cycle will start with the 'opened' condition
            t = dt; %set starting time to dt
        else
            %{
            if closed and probability to open is not matched, remain closed 
            and increase the reached time of dt 
            %}
            %curr_state = 0; 
            t = t+dt;
        end
    else
        if rand <= p_c,
            curr_state = 0;
            t = dt;
        else
            %curr_state = 1;
            state(i+1) = 1;
            t = t+dt;
        end
    end
end

%plot time curse of channel current
figure;
real_curr = Io * (state+(randn(1,N))*0.05);
plot(T_arr,real_curr);

%set labels and title
title('Single channel current simulation')
xlabel('Time [ms]')
ylabel('Current [pA]')

%plot the statistics
figure;
hist(real_curr, 100);

%set labels and title
title('Histogram of channel current simulation')
xlabel('Current [pA]')
ylabel('Absolute frequency [1/s]')



%compute open and closure state durations

state_2 = logical([1 state ~state(end)]);

%the ~ is the logical negation of the following element (in our case, the
% state vector). state(end) is the last element of state

%{

L = logical(A) converts A into an array of logical values. 
Any nonzero element of A is converted to logical 1 (true) and zeros 
are converted to logical 0 (false). 

Complex values and NaNs cannot be converted to logical values and result in
a conversion error.
%}

open_array = cumsum(state_2);

%{

B = cumsum(A) returns the cumulative sum of A starting at the beginning 
of the first array dimension in A whose size does not equal 1.

- If A is a vector, then cumsum(A) returns a vector containing 
  the cumulative sum of the elements of A.

- If A is a matrix, then cumsum(A) returns a matrix containing 
  the cumulative sums for each column of A.

- If A is a multidimensional array, then cumsum(A) acts along the first 
  nonsingleton dimension.


%}

open_array = diff(open_array(~state_2))


%{
Y = diff(X) calculates differences between adjacent elements of X along 
the first array dimension whose size does not equal 1:

- If X is a vector of length m, then Y = diff(X) returns a vector of length 
  m-1. 
  The elements of Y are the differences between adjacent elements of X.
  Y = [X(2)-X(1) X(3)-X(2) ... X(m)-X(m-1)]

- If X is a nonempty, nonvector p-by-m matrix, then Y = diff(X) returns 
  a matrix of size (p-1)-by-m, whose elements are the differences between 
  the rows of X.
  Y = [X(2,:)-X(1,:); X(3,:)-X(2,:); ... X(p,:)-X(p-1,:)]

- If X is a 0-by-0 empty matrix, then Y = diff(X) returns a 0-by-0 empty
  matrix.

%}
open_array (open_array == 0) = []

closed_array = cumsum(~state_2);
closed_array = diff(closed_array(state_2));
closed_array(closed_array == 0) = [];

%plot the histogram of closed channel state
figure;
[f_c,v_c] = hist(closed_array *dt, 30);
hist(closed_array * dt, 30);

%set labels and title
title('Statistics of closed channel state in simulation')
xlabel('Duration [ms]')
ylabel('Absolute frequency [1/s]')

hold on;

t_c = 0;v_c(end)/100:v_c(end);
plot(t_c,f_c(1)* exp(-alpha*t_c),'r');

%plot the histogram of opened channel state
figure;
[f_o,v_o] = hist(open_array * dt, 30);
hist(open_array * dt, 30);

%set labels and title
title('Statistics of opened channel state in simulation')
xlabel('Duration [ms]')
ylabel('Absolute frequency [1/s]')

hold on;

t_o = 0;v_o(end)/100:v_o(end);
plot(t_o,f_o(1)* exp(-beta*t_o),'r');



end



