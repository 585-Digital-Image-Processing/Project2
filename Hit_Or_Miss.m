%%%%%%%%%%%%%  Function Hit_Or_Miss %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute the Hit_Or_Miss of X based the foreground and background
%      structure elements
%      
% Input Variables:
%      X       MxN input 2D binary image 
%      Bf      3x3 input 2D binary image
%      
% Returned Results:
%      C       result after bit-and operation of A and B
%
% Processing Flow:
%      1. Loop through every element in A and B. Check whether elements at
%      the same position (x,y) in A and B are the same.
%           If yes, then in the result image C, C(x,y) = A(x,y)
%           Otherwise, C(x,y) = 0
%
%  Restrictions/Notes:
%      The two input image should be of the same dimension 
%
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function A = Hit_Or_Miss(X, Bf, Bb)
   % Compute X minkowskin set subtract Bf
   X1 = erosion(X, Bf);
   
   % calculate the complement image of X
   X_c = xor(X, 1);
   % Compute X_c minkowski set subtract Bb
   X2 = erosion(X_c, Bb);
   
   % Compute intersection of X1 and X2)
   A = bitand_s(X1, X2); 
end