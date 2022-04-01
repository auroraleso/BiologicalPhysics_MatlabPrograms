%define parameters 
L = 10; %cube dimension
N = 10; % number of particles
M = 5; %number of voxels in my cube for dimension (M*M*M is total number)

%position of particles: let's first generate a 3N array 
%and then reshape it in a N x 3 matrix: columns will be our (x,y,z)

pos_array = L.*rand(3*N,1);
pos = reshape(pos_array,[N,3])

x = pos(:,1);
y = pos(:,2);
z = pos(:,3);

plot3(x,y,z,'.')