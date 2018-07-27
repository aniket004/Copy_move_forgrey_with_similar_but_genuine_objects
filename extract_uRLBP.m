function uRLBP_feature = extract_uRLBP(img,locs)

[m n] = size(locs);
for i = 1:m
    x_pt = floor(locs(i,2));
    y_pt = floor(locs(i,1));
    
    % 5*5 image patch
    img_patch = img(x_pt-10:x_pt+10,y_pt-10:y_pt+10);
    loc_feature(i,:) = [x_pt y_pt];
    
    % RLBP feature
     mapping=getmapping_u(8,'u2'); 
%   [RLBP]=RLBP(I, 1,8,mapping,'h'); 
    uRLBP_feature(i,:) = rlbp(img_patch,3,8,mapping,'h'); %RLBP histogram in (8,1) neighborhood
    %using uniform patterns
    
end
end