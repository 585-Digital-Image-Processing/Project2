
function a = Complexity(f)
    r = length(f);
    a = 0;
    for i = 1:r
        if(f(i) ~= 0)
            a = a - f(i)*log(f(i));
        end
    end   
end