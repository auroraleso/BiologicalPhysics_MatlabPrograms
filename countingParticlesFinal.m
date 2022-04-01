%define parameters 
L = 10; %cube dimension
N = 100; % number of particles
M = 5; %number of voxels in my cube for dimension (M*M*M is total number)

%position of particles: let's first generate a 3N array 
%and then reshape it in a N x 3 matrix: columns will be our (x,y,z)

pos_array = L.*rand(3*N,1);
pos = reshape(pos_array,[N,3])

[C,Npos] = CountParticles2Best(pos,L,M)

%we can now define the function that will count our particles

function [C,Npos] = CountParticles2Best(pos,L,M)

% Syntax [C,Npos] = CountParticles2Best(pos,L,M);
%
% Input:
%   pos is a Nx3 array containing the positions of N
%   particles randomly distributed within the box.
%
%   L is the box side.
%
%   M is the number of voxels along one dimension.
%
% Output:
%   C is a MxMxM matrix having the (i,j,k)-th element
%   equal to the number of particles within the (i,j,k)- %th voxel of the box.
%   
%   Npos is a Nx1 array having the i-th element equal
%   to the number of particles within the voxel of the
%   i-th particle in pos matrix. 

% Number of particles
N = size(pos,1); 

% Preallocate the C matrix
C = zeros(M,M,M);  

% Resize particle coordinates to fit a box of side M
pos = ceil(pos.*M/L);

% Transform the new particle coordinates into C matrix indexes 
loc = pos(:,1)+M*(pos(:,2)-1)+(pos(:,3)-1)*M*M;

% Count particles
for k = 1:N
    C(loc(k)) = C(loc(k)) + 1;    
end

% Generate Npos
Npos = C(loc);

end