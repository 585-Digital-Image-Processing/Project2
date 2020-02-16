function skeletons = skeletonize(ori_img, ele_f, ele_b)
% input ori_img is a binary image
% input ele_f is a set of structuring element from 8 directions wrt foreground
% input ele_b is a set of structuring element from 8 directions wrt background
% output skeletons is a cell including all intermediate result of the
% skeletonization operation

i = 1;
X_0 = ori_img;
set{i} = X_0;
i = i+1;
for j=1:8
    temp_X = thin(X_0, ele_f{j}, ele_b{j});
end
set{i} = temp_X;
while set{i}~=set{i-1}
    i = i+1;
    temp_X = set{i-1};
    for j=1:8
        temp_X = thin(temp_X, ele_f{j}, ele_b{j});
    end
    set{i} = temp_X;
end
skeletons = set;

end

