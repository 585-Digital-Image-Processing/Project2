%%%%%%%%%%%%%  Function Pectrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute the complexity of an image
%      
% Input Variables:
%      f       Pectrum of the image, f(i) represent f_(i-1) because matlab
%      is one-indexed
%      
% Returned Results:
%      a       a complexity score
%
% Processing Flow:
%      a = -sum of f(i)*log(f(i))
%
%  Restrictions/Notes:
%     f must be a column vector
%      
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function a = Complexity(f)
    r = length(f);
    a = 0;
    for i = 1:r
        % Omitted f(i) = 0
        if(f(i) ~= 0)
            a = a - f(i)*log(f(i));
        end
    end   
end