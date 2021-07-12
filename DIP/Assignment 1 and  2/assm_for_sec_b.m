rgb=imread('A1_160204011_Saimom_1.jpg');

%Gray Scale Image
I=rgb2gray(rgb);
[row,col]=size(I);

Q='Histogram of Grayscale Image';
Hist(I,Q);

%Power Law Transformation
J=im2double(I);
c=1.5;
line = 'What is the gamma value? ';
y = input(line);
gamma=c*(J.^y);
gamma = im2uint8(gamma);
Q='Histogram of Power Law Transformation';
Hist(gamma,Q);

%Threshold Value Transformation
thres=I;
line = 'What is the threshold value? ';
y = input(line);
for i=1:row
    for j=1:col
        if(I(i,j)<y)
            thres(i,j)=I(i,j)+I(i,j)*.5;
        else
            thres(i,j)=I(i,j)-I(i,j)*.25;
        end
    end
end
Q='Histogram of Thresholded Image';
Hist(thres,Q);

%Log Transformation
c=1.9;
logim=c*log(1+J);
logim = im2uint8(logim);
Q='Histogram of Log Transformation';
Hist(logim,Q);


%Negation Transformation
neg=255-I;
Q='Histogram of Negation Transformation';
Hist(neg,Q);


function [y,levels] = Hist(P,Q)
    [row,col]=size(P);
    y=zeros(1,256);
    for i=1:row
        for j=1:col
            x=P(i,j);
            y(x+1)=y(x+1)+1;
        end
    end
    figure();
    levels = 0 : 255;
    bar(levels, y);
    xlabel('Gray Level', 'FontSize', 10);
    ylabel('Pixel Count', 'FontSize', 10);
    title(Q, 'FontSize', 10);
    grid on;
end