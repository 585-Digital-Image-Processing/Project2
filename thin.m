%%%%%%%%%%%%%%%%%%%%%  Function thin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute thinning of X by Bb and Bf
%      
% Input Variables:
%      X       MxN input 2D binary image 
%      Bf      3x3 input 2D binary image, foreground structural element
%      Bb      3x3 input 2D binary image, background structural element
%      
% Returned Results:
%      A       result of thinning
%
% Processing Flow:
%      1. Compute the result of hit or miss of X by Bb and Bf
%      2. Compute the complement image of the result above
%      3. Compute the intersection of the two results above, which will be
%      the result A
%
%  Restrictions/Notes:
%      All the input images are binary.
%
%  The following functions are called:
%      Hit_Or_Miss.m
%      bitand_s.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function A = thin(X, Bf, Bb)
    % Compute the result of hit or miss with X and Bf, Bb
    X_horm = Hit_Or_Miss(X, Bf, Bb);
    
    % Find out the complement image of X_horm
    X_horm_c = xor(X_horm, 1);
    A = bitand_s(X, X_horm_c);
end