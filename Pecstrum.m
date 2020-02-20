%%%%%%%%%%%%%  Function Pectrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute the Pectrum of an image
%      
%
% Input Variables:
%      U       Mx1 size distribution of the image
%      
% Returned Results:
%      f       Pectrum of the image, f(i) represent f_(i-1) because matlab
%      is one-indexed
%
% Processing Flow:
%      1. calculate f(i) = (U(i) - U(i+1))/U(1). Note that U(1) is the
%      total area of the image of interest
%
%  Restrictions/Notes:
%     U must be a column vector
%      
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = Pectrum (U)
    
    r = length(U);
    f = zeros(1,r);
    
    for i = 1:r
        % check boundary
        if i ~= r
            diff = U(i) - U(i+1);
        else
            diff = U(i);
        end
        f(i) = diff/U(1);
    end
end