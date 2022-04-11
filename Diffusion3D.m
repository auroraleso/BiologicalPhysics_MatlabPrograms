Diffusion3Dim(1e-3,1e-5,100);

function Diffusion3Dim(T, dt, D)

    %Syntax
    
    N = round(T/dt); % Number of time steps 
    time = zeros(1,N); % Time vector
    sigma = sqrt(2*D*dt); % 1D displacement
    p = zeros(3,N); %(x,y) coordinates of the particle
    
    %generate the figure for the following plot
    figure;
    title('Plot of the particle moving along its path');
    xlabel('x (\mu m)');
    ylabel('y (\mu m)');
    zlabel('z (\mu m)');
    axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
    grid on;
    hold on;

    view(3);
    axis vis3d;
    rotate3d;
    % Generate the semi-casual path and plot a moving point
    
    
        for i = 1:N-1
            cla;
            dr = sigma * randn(3,1);
            p(:,i+1) = p(:,i)+ dr;
            plot3(p(1,i+1),p(2,i+1),p(3,i+1),'o','MarkerSize',5,'MarkerFaceColor','red');
            pause(0.02);
            hold on;
            
        end
    

%plot all the final path
    figure;
    view(3);
    axis vis3d;
    rotate3d;

    title('Final path plot');
    xlabel('x (\mu m)');
    ylabel('y (\mu m)');
    zlabel('z (\mu m)');
    grid on;
    axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]);
    hold on;
    
    plot3(p(1,1),p(2,1),p(3,1),'o','MarkerSize',5,'MarkerFaceColor','red' );
    hold on;
    plot3(p(1,N),p(2,N),p(3,N),'o','MarkerSize',5,'MarkerFaceColor','red' );
    line(p(1,:),p(2,:), p(3,:));
    

end
   
