%%%%%%%%%%%%%%%%% main.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:
%      Realize Hit-or-miss
%
% Input Variables:
%      f            input 2D 8-bit image
%
% Returned Results:
%      B            A binary image of f
%      new_B        Image B after noise removal
%      min_r        Radius of the smallest circles
%      max_r        Radius of the biggest circles
%      smallest     An image indicating locations of smallest circles in B
%      biggest      An image indicating locations of biggest circles in B
%
% Processing Flow:
%      1. Load, extract the gray layer, and display the input image
%      2. Convert the input image into binary image
%      3. use opening and closing to remove noise at the background and
%         inside circles
%      4. Find all circles in the image and get their centers and radius,
%         especially the radius of the smallest and biggest circles:
%         min_r and max_r.
%      5. Find the locations of smallest circles:
%         - Erode the binary image with a structure element: a circle with
%           radius (min_r) - 1.
%         - Erode the complement of the image with a structure element: a
%           square having a round cavity with radius (min_r) + 1.
%         - Perform bitand of the two resulted matrices
%         - The circles with radius in range [(min_r) - 1, (min_r) + 1] will
%           be located.
%      6. Find the locations of biggest circles:
%         - Erode the binary image with a structure element: a circle with
%           radius (max_r) - 1.
%         - Erode the complement of the image with a structure element: a
%           square having a round cavity with radius (max_r) + 1.
%         - Perform bitand of the two resulted matrices
%         - The circles with radius in range [(max_r) - 1, (max_r) + 1] will
%           be located.
%
%
%  Restrictions/Notes:
%      This function requires an 8-bit image as input.
%
%  The following functions are called:
%      bilImageConv.m       Convert an 8-bit image to a binary image
%      opening.m            Remove the noise outside circles
%      closing.m            Fill the noise in the circles
%      erosion.m            Erode an image with a structure element
%      bitand_s.m           Perform bitand operation of two matrices
%
%  Author:      Yanxi Yang, Jiuchao Yin, Hongjie Liu
%  Date:        1/30/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Homotopic Skeletonization
% Step1: Load the images and convert them to binary images
bear=imread('bear.gif');
bear=imbinarize(bear);
figure()
imshow(bear);
title('Binary image');

penn256 = imread('penn256.gif');
penn256 = imbinarize(penn256);
figure()
imshow(penn256);
title('Binary image');

% Construct 8 pairs of structural elements with function structure_E
[Bfs,Bbs] = structure_E();

% Compute the skeleton of input images
skeleton_bear = skeletonize(bear, Bfs, Bbs);


% Show X_2, X_5, X_11, and the final skeletonized image
to_be_shown = [3, 6, 11, length(skeleton_bear)];


to_be_shown = [3, 6, 11, length(skeleton_bear)];
%<<<<<<< HEAD
% for i = 1:length(to_be_shown)
%    subplot(2,2,i);
%    figure();
%     imshow(skeleton_bear(to_be_shown(i)));
% end



% Show X_2, X_5, X_11, and the final skeletonized image
% show bear
to_be_shown_bear = [3, 6, 11, length(skeleton_bear)];

figure();
for i = 1:length(to_be_shown_bear)
    bear_g=bear.*255;
    [M, N]=size(bear_g);
    rgb_bear = zeros(M,N,3);
    rgb_bear(:,:,1)=bear_g;
    rgb_bear(:,:,2)=bear_g;
    rgb_bear(:,:,3)=bear_g;
    subplot(2,2,i);
    result=skeleton_bear{to_be_shown_bear(i)};
    for m=1:M
        for n=1:N
            if result(m,n)==1
                rgb_bear(m,n,1)=255;
                rgb_bear(m,n,2)=0;
                rgb_bear(m,n,3)=0;
            end
        end
    end
    imshow(rgb_bear);
    caption = sprintf('X_{%d}', to_be_shown_bear(i)-1);
    title(caption);
end


skeleton_penn = skeletonize(penn256, Bfs, Bbs);

% show penn256
to_be_shown_penn = [3, 6, length(skeleton_penn)];

figure();
for i = 1:length(to_be_shown)
    subplot(2,2,i);
    imshow(skeleton_bear{to_be_shown(i)});
    caption = sprintf('X_{%d}', to_be_shown(i)-1);
    title(caption);
end

%% Shape Analysis

% Step1: Load the images and convert them to binary images
match1=imread('match1.gif');
match1=imbinarize(match1);
figure()
imshow(match1);
title('Binary image');

% Isolate distinct objects and find the minimum bounding box enclosing each
% distinct object
CC = bwconncomp(match1);
% numOfPixels = cellfun(@numel,CC.PixelIdxList);

% Show the isolated images
match1_imgs = regionprops(CC, 'image');
figure();
for i = 1:4
    subplot(2,2,i)
    imshow(match1_imgs(i).Image);
end
% Bounding box four values: [left, top, width, height]
match1_obs = regionprops(CC);
match1_obs.BoundingBox



% Compute the size distribution
for i = 1:4
    [size_distribution{i},r] = sizeDistribution(match1_imgs(i).Image);
end

% Compute Pectrum
for i = 1:4
    Pec{i} = Pectrum(match1_imgs(i).Image, cell2mat(size_distribution(i)));
end
% Compute complexity
complexity = zeros(1,4);
for i = 1:4
    complexity(i) = Complexity(cell2mat(Pec(i)));
end

% Distance
