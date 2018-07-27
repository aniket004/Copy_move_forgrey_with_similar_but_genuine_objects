  


% th =2.2 min_pt=3 rlbp(1,8) 21*21 dr2 = 0.95 d=1 0.4789 TP 34 TN 92 FN 66
% FP 8.
% th =2.2 min_pt=3 rlbp(2,8) 21*21 dr2 = 0.95 d=1 0.5802 TP 47 TN 85 FN 53
% FP 15.
% th =2.2 min_pt=3 rlbp(3,8) 21*21 dr2 = 0.95 d=1 0.6519 TP 59 TN 78 FN 41
% FP 22.
% th =2.2 min_pt=3 rlbp(4,8) 21*21 dr2 = 0.95 d=1 0.6947 TP 66 TN 76 FN 34
% FP 24.
% th =2.2 min_pt=3 rlbp(5,8) 21*21 dr2 = 0.95 d=1 0.6737 TP 64 TN 74 FN 36
% FP 26.
% th =2.2 min_pt=3 rlbp(6,8) 21*21 dr2 = 0.95 d=1 0.6484 TP 59 TN 77 FN 41
% FP 23.

P = 1:6;
acc = [ 63  66  68.5 71 69 68 ];
plot(P,acc,'-*'), xlabel('Radius of Neighbourhood of RLBP (R)'),ylabel('Detection Accuracy'),axis([1 6 55 75])