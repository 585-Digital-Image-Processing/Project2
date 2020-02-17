%%%%%%%%%%%%%  Function Pectrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute the size distribution of an image
%      
% Input Variables:
%      u       Mx1 size distribution of the image
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
function  [u, r]  = sizeDistribution (img)

% structuring element
% B = ones(3);
X = img;
m =1;
u(m)=sum(X(:));
% m=m+1;
% B1 = ones(3+2*(m-1));
% X=erosion(X,B1);
% X=dilation(X,B1);
% u(m)=sum(X(:));
while u(m)~= 0
    %m= m+1;
    B1 =ones (3+2*(m-1));
    X = erosion(X, B1); 
    X = dilation_s(X, B1);
    if sum(X(:))==0
        break;
    end
    m = m+1;
    u(m)=sum(X(:));
end
r = m-1;
end
