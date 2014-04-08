% clear all;
% clc;
% a=[1,2,3,4;4,5,6,9;2,5,6,5;5 2 8 6];
% [filename,pathname]=uigetfile('*.jpg')
% a=imread(strcat(pathname,filename));
% % a=imread('imag.jpg');

function [v]=haaar(img)
% img = imresize(img, 2);
% myfilter = fspecial('gaussian',[3 3], 0.5);
% img = imfilter(img, myfilter, 'replicate');
img=0.299*img(:,:,1) + 0.587*img(:,:,2) + 0.114*img(:,:,3);
% img = histeq(img);
img = medfilt2(img,[2,1]);

gray = img;

% figure, imshow(img);
level = 1;
v = zeros(size(img));
v = img;
for p=1:level
[r,c]=size(img);
    for i=1:r
        v(i,:) = haar1d(v(i,:),c);
    end
    for i=1:c
        v(:,i) = (haar1d(v(:,i)',r))';
    end    
end

figure,a = subplot(2,2,1), subimage(v), title(a,'haar');

thres_img = zeros(size(img));

ll = v(1:end/2,end/2+1:end);
ll = threshold(ll);
thres_img(1:end/2,end/2+1:end) = ll;
ll = dilationH(ll);

v(1:end/2,end/2+1:end) = ll;

lh = v(end/2+1:end, 1:end/2);
lh = threshold(lh);
thres_img(end/2+1:end, 1:end/2) = lh;
lh = dilationV(lh);

v(end/2+1:end, 1:end/2) = lh;

hh = v(end/2+1:end, end/2+1:end);
hh = threshold(hh);
thres_img(end/2+1:end, end/2+1:end) = hh;
hh = dilationD(hh);

v(end/2+1:end, end/2+1:end) = hh;

b = subplot(2,2,2), subimage(thres_img), title(b,'thresholded');

figure,imshow(v);
final = hh.*lh.*ll;
final = final > 1;
final = final*1.0;
final = imfill(final,'holes');
figure,a = subplot(2,2,1), subimage(final), title(a,'mask');
b = subplot(2,2,2),subimage(gray), title(b,'gray');
final = imresize(final,2);
final = final >= 0.1;
masked = double(gray) .* final;
c = subplot(2,2,3),subimage(uint8(masked)), title(c,'masked gray');
end

function res = haar1d(x, w)
   divizor =1/sqrt(2);
%    divizor = 0.5;
   res = zeros(size(x));
   w = floor(w/2);
   for i=1:w
        res(i) = (x(2*i-1 ) + x(2*i))*divizor;
        res(i+w) = (x(2*i-1) - x(2*i))*divizor;
   end
end

function res = threshold(img)
g1 = [-1 0 1];
g2 = [-1 0 1]';

img = double(img);
res1 = zeros(size(img));
res2 = zeros(size(img));
res1(:,1:end-2) = img(:,3:end)-img(:,1:end-2);
res2(1:end-2,:) = img(3:end,:)-img(1:end-2,:);
% res1 = res1(:,2:end-1);
% res2 = res2(2:end-1,:);
res1 = max(abs(res1(:)),abs(res2(:)));
top = img(:) .* res1(:);
t = sum(top(:))/(sum(res1(:)));

res = img > t;
res = res*256;    
end

function res = dilationH(img)
    se = strel('rectangle', [5,3]);
    res = imdilate(img,se);
end

function res = dilationV(img)
    se = strel('rectangle', [3,5]);
    res = imdilate(img,se);
end

function res = dilationD(img)
    se = strel('rectangle', [3,3]);
    res = imdilate(img,se);
end


            
            

