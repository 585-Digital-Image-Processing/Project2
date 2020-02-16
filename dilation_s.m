%%%%%%%%%%%%%  Function dilation_s %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute dilation of an input image X with respect to an input 
%      structural element A. Note that the number of rows and columns of A
%      must be odd, so that A = A^s is possible.
%      
%
% Input Variables:
%      X       MxN input 2D binary image to be eroded
%      A       rxc structuring element, r and c are both odd
%      
% Returned Results:
%      newimg  Result after dilation
%
% Processing Flow:
%      1.  Padding image with 0s, so that the border of the image could 
%          processed propery
%      2.  For each valid pixel (x,y) in X, check whether the stucturing 
%          element A can hit X after translated with (x,y)
%             If yes, in the dilation image newimg, newimg(x,y) = 1
%             Otherwise, newimg(x,y) = 0
%
%  Restrictions/Notes:
%      X and A must be binary images.
%      The number of rows and columns of A must be odd.   
%
%  The following functions are called:
%      none
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function newimg = dilation_s(X,A)

% padding image with 0s
[r, c] = size(A);
Xprime=padarray(X,[floor(size(A,1)/2) floor(size(A,2)/2)]);

% find the original border of image X
[m, n]=size(Xprime);
newimg = zeros(m,n);
rlow = floor(r/2)+1;
rhigh = m - floor(r/2);
clow = floor(c/2)+1;
chigh = n - floor(c/2);

% compute newimg
% for each (x,y), check whether A hits X after translated by (x,y)
for i = rlow:rhigh
    for j = clow:chigh
        % get a region from X whose size is the same as the size of
        % structuring element A
        region = Xprime(i-floor(r/2): i + floor(r/2), j - floor(c/2):j + floor(c/2));
        % use "AND" operation to check whether A hits X after translation
        temp = region&A;
        % if yes (i.e. there exists 1 in the region), newimg(i,j)=1
        % otherwise, newimg(i,j)=0
        val=sum(temp(:));
        newimg(i,j) = val;
    end
end

return

