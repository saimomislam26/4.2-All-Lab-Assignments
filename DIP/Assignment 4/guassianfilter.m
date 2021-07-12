prompt = 'Enter the sigma value: ';
sigma = input(prompt);
S = rgb2gray(imread('input.jpg'));
X=zeros(11,11);
Y=zeros(11,11);
for i=1:11
    counter=-5;
    for j=1:11
        X(i,j)=counter;
        Y(j,i)=counter;
        counter=counter+1;
    end
end
temp1=1/(2*pi*(sigma^2));
temp2=(-((X.^2)+(Y.^2))/(2*(sigma^2)));
gauss=temp1*exp(temp2);

[row, col] = size(S);
R=uint8(zeros(row+10,col+10));
row=row+10;
col=col+10;
R(6:row-5,6:col-5)=S;
T=R;
R=double(R);

for i = 1:row-10
   for j = 1:col-10
      N = R(i:i+10, j:j+10);
      t = sum(sum(N.*gauss)); 
      T(i+5,j+5) = t;
   end
end
figure; imshow(S);
F=uint8(T(6:row-5,6:col-5)); 
figure;imshow(F, [min(F(:)), max(F(:))]);