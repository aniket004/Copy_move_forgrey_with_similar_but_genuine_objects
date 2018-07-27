function uriLBP_feature = extract_uriLBP(img,locs)

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
    
    % uriLBP feature
    MAPPING=getmapping(16,'riu2');
    LBPHIST_uri=lbp(img_patch,2,16,MAPPING,'hist');
    uriLBP_feature(i,:) = LBPHIST_uri;
    
end
end