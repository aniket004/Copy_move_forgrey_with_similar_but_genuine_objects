function LTP_feature = extract_LTP(img,locs)

binsRange = 256;
[m n] = size(locs);
for i = 1:m
    x_pt = floor(locs(i,2));
    y_pt = floor(locs(i,1));
    
    % 5*5 image patch
    img_patch = img(x_pt-2:x_pt+2,y_pt-2:y_pt+2);
    loc_feature(i,:) = [x_pt y_pt];
    
    % LTP feature 
    [LTP_up LTP_low] = LTP(img_patch,5);
    LTP_feature(i,1:256) = hist(single( LTP_up(:) ), binsRange);
    LTP_feature(i,257:512) = hist(single( LTP_low(:) ), binsRange);
    
    %LTP_feature(i,1:256) = ltp_up_feature;
    %LTP_feature(i,257:512) = ltp_low_feature;
    
end
end