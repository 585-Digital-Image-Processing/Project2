%%%%%%%%%%%%%  Function Hit_Or_Miss %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute the Hit_Or_Miss of X based the foreground and background
%      structure elements
%      
% Input Variables:
%      X       MxN input 2D binary image 
%      Bf      3x3 input 2D binary image, foreground structural element
%      Bb      3x3 input 2D binary image, background structural element
%      
% Returned Results:
%      A       result of hit or miss
%
% Processing Flow:
%      1. Compute minkowski set subtraction of X by Bf
%      2. Compute minkowski set subtraction of X^c by Bb
%      3. Compute the intersection of the two results above, which will be
%      the result A
%
%  Restrictions/Notes:
%      All the images are binary.
%
%  The following functions are called:
%      erosion.m
%      bitand_s.m
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