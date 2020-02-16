function f = Pectrum (A, U)
    %d(r) - d(r+1) /m(A)

    r = length(U);
    f = zeros(1,r);
    areaA = sum(A(:));
    
    for i = 1:r
        if i ~= r
            diff = U(i) - U(i+1);
        else
            diff = U(i);
        end
        f(i) = diff/areaA;
    end
end