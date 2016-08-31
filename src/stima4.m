function M = stima4 ( vertices )

  D_Phi = [ vertices(2,:) - vertices(1,:); vertices(4,:) - vertices(1,:) ]';

  B = inv ( D_Phi' * D_Phi );

  C1 =  [  2, -2; -2,  2 ] * B(1,1) ...
      + [  3,  0;  0, -3 ] * B(1,2) ...
      + [  2,  1;  1,  2 ] * B(2,2);

  C2 =  [ -1,  1;  1, -1 ] * B(1,1) ...
      + [ -3,  0;  0,  3 ] * B(1,2) ...
      + [ -1, -2; -2, -1 ] * B(2,2);

  M = det ( D_Phi ) * [ C1 C2; C2 C1 ] / 6;
end
