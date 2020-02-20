%%%%%%%%%%%%%%%%% main.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Purpose:  
%      Impelement homotopic skeletonization, shape analysis, and pattern 
%      recognition 
%
% Input Variables:
%      bear.gif         input 2D image for homotopic skeletonization analysis
%      penn256.gif      input 2D image for homotopic skeletonization analysis
%      match1.gif       input 2D image for shape analysis and pattern
%                       recognition
%      match3.gif       input 2D image for shape analysis and pattern
%                       recognition
%      shadow1.gif      input 2D image for shape analysis and pattern
%                       recognition
%      shaodow1rotaed.gif   input 2D image for shape analysis and pattern
%                       recognition
%    
% Returned Results:
%      skeleton_bear    Skeleton of bear.gif
%      rgb_bear         Skeleton of bear.gif on top of the original image
%      skeleton_penn    Skeleton of penn256.gif
%      rgb_penn256      Skeleton of penn256.gif on top of the original image
%      {}_imgs          isolated objects of in match1, match3, shadow1,
%                       shadow1rotated
%      {}_obs           isolated objects with bounding box information of 
%                       match1, match3, shadow1,shadow1rotated.
%      size_distribution Size distribution of isolated objects
%      Pec              Pecstrum of isolated objects  
%      complexity       Complexity of isolated objects
%      dist             Distance of each test object with each reference
%                       object
%
% Processing Flow:
%      1. Homotopic Skeletonization:
%         1.1 Load, and onvert the input image into binary image.
%         1.2 Build the structuring element set as given, with foreground 
%             and background as each pairs of structuring element set.
%         1.3 Perfom thinning of input image with the 8 pair of structuring
%         elements iteratively until we get the skeleton results.
%         1.4 Show the superposition plotting with intermediate results 
%             as well as the final skeleton result.
%      2. Shape Analysis and pattern recognition
%         2.1 Compute shape distribution, pecstrum, and complexity.
%         2.2 Determine which object is most complex based on complexity.
%         2.3 Compute shap distribution and pecstrum of test objects as
%         well.
%         2.4 Calculate the dist of all test objects with each reference
%         object.
%         2.5 The reference object with the smallest distance is considered
%         to be the one resemsble the test object.         
%
%  Restrictions/Notes:
%      N/A
%
%  The following functions are called:
%      structure_E.m            Construct the 8 pair of structural elements  
%      skeletonize.m            Compute the skeleton of the input image
%      sizeDistribution.m       Compute the size distribution of input images 
%      Pecstrum.m               Compute the Pecstrum of the input image
%      Complexity.m             Compute the complexity of the input image
%      distance.m               Compute the distance of the two input
%                               objects
%      distance_cartoon.m       Compute the distance of the two input
%                               objects
%
%  Author:      Yanxi Yang, Jiuchao Yin, Hongjie Liu
%  Date:        2/17/2020
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
% show bear
to_be_shown_bear = [3, 6, 11, length(skeleton_bear)];
figure();
for i = 1:length(to_be_shown_bear)
    bear_g=bear.*255;
    [M N]=size(bear_g);
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
to_be_shown_penn = [3, 6, length(skeleton_penn)];
% show penn256
figure();
for i = 1:length(to_be_shown_penn)
    penn256_g=penn256.*255;
    [M N]=size(penn256_g);
    rgb_penn256 = zeros(M,N,3);
    rgb_penn256(:,:,1)=penn256_g;
    rgb_penn256(:,:,2)=penn256_g;
    rgb_penn256(:,:,3)=penn256_g;
    subplot(2,2,i);
    result=skeleton_penn{to_be_shown_penn(i)};
    for m=1:M
        for n=1:N
            if result(m,n)==1
                rgb_penn256(m,n,1)=255;
                rgb_penn256(m,n,2)=0;
                rgb_penn256(m,n,3)=0;
            end
        end
    end
    imshow(rgb_penn256);
    caption = sprintf('X_{%d}', to_be_shown_penn(i)-1);
    title(caption);
end


%% Shape Analysis

% Quetion a (i):
% Step1: Load the images and convert them to binary images
match1=imread('match1.gif');
match1=imbinarize(match1);
figure()
imshow(match1);
title('Binary image');

% Step 2: Isolate distinct objects and find the minimum bounding box 
% enclosing each distinct object
CC = bwconncomp(match1);

% Show the isolated images
match1_imgs = regionprops(CC, 'image');
figure();
for i = 1:4
    subplot(2,2,i)
    imshow(match1_imgs(i).Image);
    caption = sprintf('%d', i);
    title(caption);
end
% Bounding box four values: [left, top, width, height]
match1_obs = regionprops(CC);
match1_obs.BoundingBox

% Step 3: compute size distribution, Pecstrum, and complexity
% Compute the size distribution
for i = 1:4
    size_distribution{i} = sizeDistribution(match1_imgs(i).Image);
end

% Compute Pecstrum
for i = 1:4
    Pec{i} = Pecstrum(size_distribution{i});
end
% Compute complexity 
complexity = zeros(1,4);
for i = 1:4
    complexity(i) = Complexity(Pec{i});
end


% Distance
% Step1: Load the images and convert them to binary images

% Question a(ii):

match3=imread('match3.gif');
match3=imbinarize(match3);
figure()
imshow(match3);
title('Binary image');


% Isolate distinct objects and find the minimum bounding box enclosing each
% distinct object
CC = bwconncomp(match3);
% numOfPixels = cellfun(@numel,CC.PixelIdxList);

% Show the isolated images
match3_imgs = regionprops(CC, 'image');

figure();
for i = 1:4
    subplot(2,2,i)
    imshow(match3_imgs(i).Image);
end
% Bounding box four values: [left, top, width, height]
match3_obs = regionprops(CC);
match3_obs.BoundingBox


% Compute the size distribution of match3
for i = 1:4
    [size_distribution3{i},r] = sizeDistribution(match3_imgs(i).Image);
end

% Compute Pecstrum
for i = 1:4
    Pec3{i} = Pecstrum(cell2mat(size_distribution3(i)));
end
% Compute complexity
complexity = zeros(1,4);
for i = 1:4
    complexity3(i) = Complexity(cell2mat(Pec3(i)));
end

% Compute distance
for i = 1:4
    for j=1:4
        dist(i,j)=distance(cell2mat(Pec3(i)),cell2mat(Pec(j)));
    end
end

for i=1:4
    [min_dis, obj_num] = min(dist(i,:));
    most_similar(i) = obj_num;
end

for i = 1:4
    subplot(2,2,i)
    imshow(match3_imgs(i).Image);
    caption = sprintf('most similar:%d', most_similar(i));
    title(caption);
end


%% part(b)

img_num = 4;
show_column = 2;

% Step1: Load the images and convert them to binary images
shadow1=imread('shadow1.gif');
shadow1=imbinarize(shadow1);
shadow1 = shadow1(78:256,:);
%shadow1_skeleton = shadow1(1:77,:);
figure()
imshow(shadow1);
title('Binary image-shadow1');

% Isolate distinct objects and find the minimum bounding box enclosing each
% distinct object
CC = bwconncomp(shadow1);
% numOfPixels = cellfun(@numel,CC.PixelIdxList);

% Show the isolated images
shadow1_imgs = regionprops(CC, 'image');
figure();
for i = 1:img_num
    subplot(show_column,show_column,i)
    imshow(shadow1_imgs(i).Image);
    caption = sprintf('%d', i);
    title(caption);
end
% Bounding box four values: [left, top, width, height]
shadow1_obs = regionprops(CC);
shadow1_obs.BoundingBox



% Compute the size distribution
for i = 1:img_num
    [size_distribution{i},r] = sizeDistribution(shadow1_imgs(i).Image);
end

% Compute Pecstrum
for i = 1:img_num
    Pec{i} = Pecstrum(cell2mat(size_distribution(i)));
end
% Compute complexity
complexity = zeros(1,img_num);
for i = 1:img_num
    complexity(i) = Complexity(cell2mat(Pec(i)));
end

% Distance
% Step1: Load the images and convert them to binary images
shadow1rotated=imread('shadow1rotated.gif');
shadow1rotated=imbinarize(shadow1rotated);
shadow1rotated = shadow1rotated(78:256,:);
figure()
imshow(shadow1rotated);
title('Binary image-shadow1rotated');

% Isolate distinct objects and find the minimum bounding box enclosing each
% distinct object
CC = bwconncomp(shadow1rotated);
% numOfPixels = cellfun(@numel,CC.PixelIdxList);

% Show the isolated images
shadow1rotated_imgs = regionprops(CC, 'image');
figure();
for i = 1:img_num
    subplot(show_column,show_column,i)
    imshow(shadow1rotated_imgs(i).Image);
end
% Bounding box four values: [left, top, width, height]
shadow1rotated_obs = regionprops(CC);
shadow1rotated_obs.BoundingBox

% Compute the size distribution of match3
for i = 1:img_num
    [size_distribution3{i},r] = sizeDistribution(shadow1rotated_imgs(i).Image);
end

% Compute Pecstrum
for i = 1:img_num
    Pec3{i} = Pecstrum(cell2mat(size_distribution3(i)));
end
% Compute complexity
complexity = zeros(1,img_num);
for i = 1:img_num
    complexity3(i) = Complexity(cell2mat(Pec3(i)));
end

% Compute distance
for i = 1:img_num
    for j=1:img_num
        dist(i,j)=distance_cartoon(cell2mat(Pec3(i)),cell2mat(Pec(j)));
    end
end

for i=1:img_num
    [min_dis, obj_num] = min(dist(i,:));
    most_similar(i) = obj_num;
end

for i = 1:img_num
    subplot(show_column,show_column,i)
    imshow(shadow1rotated_imgs(i).Image);
    caption = sprintf('most similar:%d', most_similar(i));
    title(caption);
end

