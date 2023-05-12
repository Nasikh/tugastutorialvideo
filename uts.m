clear all
close all
clc

baby = imread('baby.jpg');
baby_gray = rgb2gray(baby);
baby_bw = im2bw(baby_gray,240/255);
baby_bw2 = imcomplement(baby_bw);
baby_bw3 = imfill(baby_bw2,'holes');
baby_bw3(end,:) = 1;
baby_bw3 = imfill(baby_bw3,'holes');
baby_bw3(end,:) = 0;
baby_bw4 = imerode(baby_bw3,strel('disk',1));

red_baby = baby(:,:,1);
green_baby = baby(:,:,2);
blue_baby = baby(:,:,3);

cloud = imread('cloud3.jpg');
red_cloud = cloud(:,:,1);
green_cloud = cloud(:,:,2);
blue_cloud = cloud(:,:,3);

red_cloud(baby_bw4) = red_baby(baby_bw4);
green_cloud(baby_bw4) = green_baby(baby_bw4);
blue_cloud(baby_bw4) = blue_baby(baby_bw4);

rgb = cat(3,red_cloud,green_cloud,blue_cloud);

imwrite(baby_bw4,'bw4.jpg')

figure, imshow(baby);
figure, imshow(baby_bw4);
figure, imshow(cloud);
figure, imshow(rgb);

%% Cropping Citra Bayi
red_baby(~baby_bw4) = 0;
green_baby(~baby_bw4) = 0;
blue_baby(~baby_bw4) = 0;
baby_RGB = cat(3,red_baby,green_baby,blue_baby);
[row,col] = find(baby_bw4==1);
bw = imcrop(baby_bw4,[min(col) min(row) max(col)-min(col) max(row)-min(row)]);
RGB = imcrop(baby_RGB,[min(col) min(row) max(col)-min(col) max(row)-min(row)]);
RGB2 = imcrop(baby,[min(col) min(row) max(col)-min(col) max(row)-min(row)]);

[B,L] = bwboundaries(bw,'noholes');
figure,imshow(RGB)
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end
hold off

figure,imshow(RGB2)
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end
hold off