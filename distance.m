function dist = distance(f1, f2)
% input f1 is the pecstrum of test object (a vector)
% input f2 is the pecstrum of a reference object R_i (a vector)

% first, make the length of f1 equal to that of f2
f1 = [1,2];
f2 = [1,2,3];
l1 = length(f1);
l2 = length(f2);
if l1 > l2
    f2 = [f2, zeros(1, l1-l2)];
else
    f1 = [f1, zeros(1, l2-l1)];
end

% second, compute the distance of test object and reference object
% all the values of c_n is 1
dist = 0;
for i = 1:length(f1)
    temp = (f1(i)-f2(i))^2;
    dist = dist + temp;
end
dist = sqrt(dist);

end

