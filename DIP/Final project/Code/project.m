%step 1 : read the image and show
I=imread('input.png');
I=rgb2gray(I);
subplot(2,4,1);
imshow(I);
title('a');

I = im2double(I);
[row,col]=size(I);


%zero padding 
tempI=[zeros(row,1) I zeros(row,1)]; 
I2=[zeros(1,col+2); tempI ; zeros(1,col+2)];

M = 2;
I2=double(I2);

%step 2 : Laplacian filter 

mask=[0 1 0;1 -4 1;0 1 0];

%calling user defined function for calulating convolution

Ic=(size(I2));
for i = 1:row
    for j =1:col
        Temp = I2(i:i+M,j:j+M).*mask;
        Ic(i,j)=sum(Temp(:));
    end
end


subplot(2,4,2);
imshow(Ic,[]);
title('b');


%step3 : enhaced image of 'b' 
output=I-Ic;
subplot(2,4,3);
imshow(output);
title('c');


%step4 : Sobel Filter
Gx = [-1 0 1;
-2 0 2;
-1 0 1];
Gy = [ 1 2 1;
0 0 0;
-1 -2 -1];


ISX=(size(I2));
for i = 1:row
    for j =1:col
        Temp = I2(i:i+M,j:j+M).*Gx;
        ISX(i,j)=sum(Temp(:));
    end
end


ISY=(size(I2));
for i = 1:row
    for j =1:col
        Temp = I2(i:i+M,j:j+M).*Gy;
        ISY(i,j)=sum(Temp(:));
    end
end

sobel_output=sqrt(ISX.^2 + ISY.^2);

T = 0.1;
for i = 1:row
    for j =1:col
        if(sobel_output(i,j)<T)
            sobel_output(i,j)=0;
        end
    end
end

subplot(2,4,4);
imshow(sobel_output);
title('d');

%step 5 :  average filter on sobel output
mask_avg=[1/25 1/25 1/25 1/25 1/25; 
          1/25 1/25 1/25 1/25 1/25;
          1/25 1/25 1/25 1/25 1/25; 
          1/25 1/25 1/25 1/25 1/25;
          1/25 1/25 1/25 1/25 1/25];

%new padding for avg filter
tempI2=[zeros(row,2) sobel_output zeros(row,2)]; 
I3=[zeros(2,col+4); tempI2 ; zeros(2,col+4)];
I3=double(I3);  




avg_filter=(size(I3));
for i = 1:row
    for j =1:col
        Temp = I3(i:i+4,j:j+4).*mask_avg;
        avg_filter(i,j)=sum(Temp(:));
    end
end




subplot(2,4,5);
imshow(avg_filter);
title('e');

%step6 : product of laplacian enhanced and avg_filter ('c'*'e')
result= avg_filter.*output;
subplot(2,4,6);
imshow(result);
title('f');

%step7 : add input and result of previous step ('a'+'f')
g=I+result;
subplot(2,4,7);
imshow(g);
title('g');

%step 8 : power law of previous output 'g'
c = 1;
gamma = 0.1s;
powerlaw_output=zeros(size(I));
for i = 1:row
    for j =1:col
       powerlaw_output(i,j) = c.*(g(i,j).^gamma);
    end
end
subplot(2,4,8);
imshow(abs(powerlaw_output));
title('h');
