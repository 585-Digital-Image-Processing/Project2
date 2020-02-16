%%%%%%%%%%%%%  Function erosion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      Compute the bit-and operation of two input matrices
%      
% Input Variables:
%      A       MxN input 2D binary image 
%      B       MxN input 2D binary image
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

function C = bitand_s(A, B)

C=(zeros(size(A)));
for i=1:size(A,1)
    for j=1:size(A,2)
        if A(i,j)==B(i,j)
            C(i,j)=A(i,j);
        else
            C(i,j)=0;
        end
    end
end

return

