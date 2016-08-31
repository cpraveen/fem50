function heat ( )
%
%  Read the nodal coordinate data file.
%
  load coordinates.dat;
%
%  Read the triangular element data file.
%
  eval ( 'load elements3.dat;', 'elements3=[];' );
%
%  Read the quadrilateral element data file.
%
  eval ( 'load elements4.dat;', 'elements4=[];' );
%
%  Read the Neumann boundary condition data file.
%  I THINK the purpose of the EVAL command is to create an empty NEUMANN array
%  if no Neumann file is found.
%
  eval ( 'load neumann.dat;', 'neumann=[];' );
%
%  Read the Dirichlet boundary condition data file.
%
  eval ( 'load dirichlet.dat;', 'dirichlet=[];' );

  A = sparse ( size(coordinates,1), size(coordinates,1) );
  b = sparse ( size(coordinates,1), 1 );
%
%  Assembly.
%
  for j = 1 : size(elements3,1)
    A(elements3(j,:),elements3(j,:)) = A(elements3(j,:),elements3(j,:)) ...
      + stima3(coordinates(elements3(j,:),:));
  end

  for j = 1 : size(elements4,1)
    A(elements4(j,:),elements4(j,:)) = A(elements4(j,:),elements4(j,:)) ...
      + stima4(coordinates(elements4(j,:),:));
  end
%
%  Volume Forces.
%
  for j = 1 : size(elements3,1)
    b(elements3(j,:)) = b(elements3(j,:)) ...
      + det( [1,1,1; coordinates(elements3(j,:),:)'] ) * ...
      f(sum(coordinates(elements3(j,:),:))/3)/6;
  end

  for j = 1 : size(elements4,1)
    b(elements4(j,:)) = b(elements4(j,:)) ...
      + det([1,1,1; coordinates(elements4(j,1:3),:)'] ) * ...
      f(sum(coordinates(elements4(j,:),:))/4)/4;
  end
%
%  Neumann conditions.
%
  if ( ~isempty(neumann) )
    for j = 1 : size(neumann,1)
      b(neumann(j,:)) = b(neumann(j,:)) + ...
        norm(coordinates(neumann(j,1),:) - coordinates(neumann(j,2),:)) * ...
        g(sum(coordinates(neumann(j,:),:))/2)/2;
    end
  end
%
%  Determine which nodes are associated with Dirichlet conditions.
%  Assign the corresponding entries of U, and adjust the right hand side.
%
  u = sparse ( size(coordinates,1), 1 );
  BoundNodes = unique ( dirichlet );
  u(BoundNodes) = u_d ( coordinates(BoundNodes,:) );
  b = b - A * u;
%
%  Compute the solution by solving A * U = B for the remaining unknown values of U.
%
  FreeNodes = setdiff ( 1:size(coordinates,1), BoundNodes );

  u(FreeNodes) = A(FreeNodes,FreeNodes) \ b(FreeNodes);
%
%  Graphic representation.
%
  show ( elements3, elements4, coordinates, full ( u ) );

end
