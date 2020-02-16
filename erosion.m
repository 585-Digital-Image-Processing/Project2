function B = erosion(X, A)

% padding
[r, c] = size(A);
X = padarray(X, [floor(r/2), floor(c/2)],0);

[m, n] = size(X);
B = zeros(m,n);
rlow = floor(r/2)+1;
rhigh = m - floor(r/2);
clow = floor(c/2)+1;
chigh = n - floor(r/2);
for i = rlow:rhigh
    for j = clow:chigh
        temp = X(i-floor(r/2): i + floor(r/2), j - floor(c/2):j + floor(c/2))
        X
        B(i,j) = all(temp(:) == A(:))
    end
end
B = B(rlow:rhigh, clow:chigh);
return