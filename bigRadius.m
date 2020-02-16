function  r = bigRadius (img, B)

% structuring element
B = ones(3);
X = img;
m =0;
while sum(X(:)~= 0)
            m= m+1;
            B1 =ones (3+2*m);
            X = erosion(X, B1); 
            X = dilation(X, B1);
end
r = m
end
