clc
clear all
a = imread('C:\Users\PRIYANSHU SHARMA\Desktop\PRIYANSHU\6 STUDY\MATLAB\LAB 8\1.png');
imshow(a)
a = im2bw(a,graythresh(a));
[B,L] = bwboundaries(a);
figure, imshow(a);
hold on;
for k=1:length(B)
    boundary = B{k};
    plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
end

[L, N] = bwlabel(a);
RGB = label2rgb(L, 'hsv', [.5 .5 .5], 'shuffle');

figure, imshow(RGB);
hold on;

for k=1:length(B)
    boundary = B{k};
    plot(boundary(:,2),boundary(:,1),'w','LineWidth',2);
    text(boundary(1,2)-11,boundary(1,1)+11,num2str(k),'Color','y','FontSize',14,'FontWeight','bold');
end

stats = regionprops(L,'all');
temp = zeros(1,N);
for k = 1:N
    temp(k) = 4*pi*stats(k,1).Area / (stats(k,1).Perimeter)^2;
    stats(k,1).ThinnessRatio = temp(k);
    temp(k) = (stats(k,1).BoundingBox(3))/(stats(k,1).BoundingBox(4));
    stats(k,1).AspectRatio = temp(k);
end

areas = zeros(1,N);
for k=1:N
    areas(k) = stats(k).Area;
end

TR = zeros(1,N);
for k = 1:N
    TR(k) = stats(k).ThinnessRatio;
end

cmap = colormap(lines(16))
for k = 1:N
    scatter(areas(k), TR(k), [], cmap(k,:), 'filled'), ylabel('Thinness Ratio'), xlabel('Area')
    hold on 
end
