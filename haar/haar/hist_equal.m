function ch = hist_equal(img)

 %% Show current image.
   imshow(img);
   %% draw the cumulative  histogram of  orginal image.
   figure; 
   histogram = imhist(img);%image histogram.
   ch = cumsum(histogram);%cumulative  histogram.
   bar(ch,'BarWidth',1)%draw bar.
   %% image equalization and cumulative histogram 
   figure; 
   J = histeq(img);
   imshow(J);
   figure; 
   histogramEq = imhist(J);%image histogram.
   ch = cumsum(histogramEq);%cumulative  histogram.
   bar(ch,'BarWidth',1)%draw bar.