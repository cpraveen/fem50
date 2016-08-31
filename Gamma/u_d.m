function value = u_d ( u )

%*****************************************************************************80
%
%% U_D evaluates the Dirichlet boundary conditions.
%
%  Discussion:
%
%    The user must supply the appropriate routine for a given problem
%
%  Parameters:
%
%    Input, real U(N,M), contains the M-dimensional coordinates of N points.
%
%    Output, VALUE(N), contains the value of the Dirichlet boundary
%    condition at each point.
%
  x = u(:,1);
  y = u(:,2);
  theta = atan2(y, x);
  j = find(theta < 0);
  theta(j) = theta(j) + 2*pi;
  r = sqrt(x.^2 + y.^2);
  value = r.^(2.0/3.0) .* sin(2.0*theta/3.0);

end
