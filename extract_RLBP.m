function RLBP_feature = extract_RLBP(img,locs)

[m n] = size(locs);
for i = 1:m
    x_pt = floor(locs(i,2));
    y_pt = floor(locs(i,1));
    
    % 5*5 image patch
    img_patch = img(x_pt-10:x_pt+10,y_pt-10:y_pt+10);
    loc_feature(i,:) = [x_pt y_pt];
    
    % RLBP feature
    RLBP_feature(i,:) = rlbp(img_patch,4,8);
%     RLBP_feature = rlbp(img_patch,1,8);
%     RLBP_feature(i,:) = abs(fft(RLBP_feature));
    
end
end