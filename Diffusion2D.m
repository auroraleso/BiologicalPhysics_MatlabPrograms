Diffusion2Dim(1e-3,1e-5,220);

function Diffusion2Dim(T, dt, D)

    %Syntax
    
    N = round(T/dt); % Number of time steps 
    time = zeros(1,N); % Time vector
    sigma = sqrt(2*D*dt); % 1D displacement
    p = zeros(2,N); %(x,y) coordinates of the particle
    
    %generate the figure for the following plot
    figure;
    title('Plot of the particle moving along its path');
    xlabel('x (\mu m)');
    ylabel('y (\mu m)');
    axis([-2 2 -2 2]);
    hold on;
    % Generate the semi-casual path and plot a moving point
    
    
        for i = 1:N-1
            cla;
            dr = sigma * randn(2,1);
            p(:,i+1) = p(:,i)+ dr;
            scatter(p(1,i+1),p(2,i+1),'filled', 'r');
            pause(0.1);
            hold on;
            
        end
    

%plot all the final path
    figure;
    title('Final path plot');
    xlabel('x (\mu m)');
    ylabel('y (\mu m)');
    axis([-2 2 -2 2]);
    hold on;
    scatter(p(1,1),p(2,1),'filled', 'r');
    hold on;
    scatter(p(1,N),p(2,N),'filled', 'r');
    line(p(1,:),p(2,:));
    

end
   
