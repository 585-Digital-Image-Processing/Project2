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
    X = dilation(X, B1);
    if sum(X(:))==0
        break;
    end
    m = m+1;
    u(m)=sum(X(:));
end
r = m-1;
end
