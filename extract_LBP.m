function LBP_feature = extract_LBP(img,locs)

% parameter for LBP and RILBP
nFiltSize=8;
nFiltRadius=1;
filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
binsRange=(1:2^nFiltSize)-1;

[m n] = size(locs);
for i = 1:m
    x_pt = floor(locs(i,2));
    y_pt = floor(locs(i,1));
    
    % 5*5 image patch
    img_patch = img(x_pt-2:x_pt+2,y_pt-2:y_pt+2);
    loc_feature(i,:) = [x_pt y_pt];
    
    % LBP feature
    LBP = efficientLBP(img_patch,'filtR', filtR, 'isRotInv', false, 'isChanWiseRot', false);
    hist_LBP = hist(single( LBP(:) ), binsRange);
    LBP_feature(i,1:256) = hist_LBP;
    
end
end