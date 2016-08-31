function Gamma(n)

X=zeros(n*(2*n-1)+(n-1)*n,1);
Y=zeros(n*(2*n-1)+(n-1)*n,1);

c=1;

%------------------------------------------------------------------------------
% Create boundary edges
%------------------------------------------------------------------------------
x=linspace(-1,0,n);
for j=1:n
   X(c) = x(j);
   Y(c) = -1;
   c = c + 1;
end

y=linspace(-1,0,n);
for j=2:n
   X(c) = 0;
   Y(c) = y(j);
   c = c + 1;
end

x=linspace(0,1,n);
for j=2:n
   X(c) = x(j);
   Y(c) = 0;
   c = c + 1;
end

y=linspace(0,1,n);
for j=2:n
   X(c) = 1;
   Y(c) = y(j);
   c = c + 1;
end

x=linspace(1,-1,2*n-1);
for j=2:2*n-1
   X(c) = x(j);
   Y(c) = 1;
   c = c + 1;
end

y=linspace(1,-1,2*n-1);
for j=2:2*n-2
   X(c) = -1;
   Y(c) = y(j);
   c = c + 1;
end

bedge = zeros(c-1, 2);
bedge(:,1) = 1:c-1;
bedge(:,2) = 2:c;
bedge(c-1,2)=1;

figure(1)
plot(X(bedge(:,1)), Y(bedge(:,1)), 'o-')
%------------------------------------------------------------------------------
% Generate interior points
%------------------------------------------------------------------------------

% generate points inside (-1,0) x (-1,+1)
nx=n;
ny=2*n-1;
x=linspace(-1, 0, nx);
y=linspace(-1, 1, ny);
for j=2:nx-1
   for k=2:ny-1
      X(c) = x(j);
      Y(c) = y(k);
      c    = c + 1;
   end
end

% generate points inside (0,1) x (0,1)
nx=n;
ny=n;
x=linspace(0,1,nx);
y=linspace(0,1,ny);
for j=1:nx-1
   for k=2:ny-1
      X(c) = x(j);
      Y(c) = y(k);
      c    = c + 1;
   end
end

tri=DelaunayTri([X,Y], bedge);

% Plot all triangles
figure(2)
triplot(tri)

% Triangles inside our domain
figure(3)
inside=inOutStatus(tri);
triplot(tri(inside, :), tri.X(:,1), tri.X(:,2));

e=tri.edges;           % all edges
eb=tri.freeBoundary;   % boundary edges

np   = length(X);   % no of vertices
nt   = size(tri,1); % no of triangles
fprintf(1,'Number of points         = %d\n', np);
fprintf(1,'Number of triangles      = %d\n', nt);

n_e  = size(e ,1); % no of all edges
n_eb = size(eb,1); % no of boundary edges

% find neighbouring cell of boundary edges
for j=1:n_eb
   nbr = tri.edgeAttachments(eb(j,:));
   nbr = nbr{:};
   dx = X(eb(j,2)) - X(eb(j,1));
   dy = Y(eb(j,2)) - Y(eb(j,1));
   % order vertices 
   v  = tri.Triangulation(nbr(1),:);
   dx1= sum(X(v))/3 - X(eb(j,1));
   dy1= sum(Y(v))/3 - Y(eb(j,1));
   if(dx1*dy - dx*dy1 > 0)
      tmp = eb(j,:);
      eb(j,1) = tmp(2);
      eb(j,2) = tmp(1);
   end
end

fid=fopen('coordinates.dat','w');
fprintf(fid,'%24.14e %24.14e\n', tri.X');
fclose(fid);

fid=fopen('elements3.dat','w');
fprintf(fid,'%8d %8d %8d\n', (tri(inside,:))');
fclose(fid);

fid=fopen('dirichlet.dat','w');
fprintf(fid,'%8d %8d\n', bedge);
fclose(fid);
