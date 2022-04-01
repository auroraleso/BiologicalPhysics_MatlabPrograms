%The aim of the program is to plot a cube divided into 10*10*10 voxels and 
%some casually generated particles inside it. 

%define parameters 
L = 10; %cube dimension
N = 100; % number of particles


%for the external cube
vert = [0 0 0;L 0 0;L L 0;0 L 0;0 0 L;L 0 L;L L L;0 L L];
fac = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];

%plot the external cube

    patch('Vertices',vert,'Faces',fac,...
        'FaceVertexCData',hsv(6),'FaceColor','flat', ...
        'FaceAlpha', 0);
    view(3)
    axis vis3d
    rotate3d
    xlabel('x')
    ylabel('y')
    zlabel('z')
    hold on


for i = 0:9
    for j = 0:9
        for k = 0:9
            vert_voxel = [i j k ; (i+1) j k ; (i+1) (j+1) k ; i (1+j) k ; i j (1+k) ; (1+i) j (1+k) ; (1+i) (1+j) (1+k) ; i (1+j) (1+k)];
            patch('Vertices',vert_voxel,'Faces',fac,...
            'FaceVertexCData',hsv(6),'FaceColor','flat', ...
            'FaceAlpha', 0);

            view(3)
            axis vis3d
            rotate3d
            xlabel('x')
            ylabel('y')
            zlabel('z')
            hold on
        end

    end
end



%position of particles: let's first generate a 3N array 
%and then reshape it in a N x 3 matrix: columns will be our (x,y,z)

pos_array = L.*rand(3*N,1);
pos = reshape(pos_array,[N,3])

x = pos(:,1);
y = pos(:,2);
z = pos(:,3);

%plot the points 
plot3(x,y,z,'o','MarkerSize',5,'MarkerFaceColor','red' )