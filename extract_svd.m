function svd_feature = extract_svd(img,locs)

[m n] = size(locs);

% % parameter for LBP and RILBP
% nFiltSize=8;
% nFiltRadius=1;
% filtR=generateRadialFilterLBP(nFiltSize, nFiltRadius);
% binsRange=(1:2^nFiltSize)-1;
for i = 1:m
    x_pt = floor(locs(i,2));
    y_pt = floor(locs(i,1));
    
    % 5*5 image patch
    img_patch = img(x_pt-2:x_pt+2,y_pt-2:y_pt+2);
    loc_feature(i,:) = [x_pt y_pt];
    
    % svd feature
    svd_img = svd(double(img_patch));
    svd_feature(i,1:5) = svd_img(:);
    
end
end