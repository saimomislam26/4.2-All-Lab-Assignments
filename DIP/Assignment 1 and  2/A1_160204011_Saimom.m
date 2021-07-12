I1=imread('A1_160204011_Saimom_1.jpg');
I2=imread('A1_160204011_Saimom_2.jpg');

I1 = imresize(I1, [512 512]);
figure; imshow(I1);
I2 = imresize(I2, [512 512]);
figure; imshow(I2);
[row,column]=size(I2);

column=column/3;
new = uint8(zeros(row, column,3));

part=row/5;

for i = 1:3
    for j=0:2:4
         new(j*part:(j+1)*part, : , i)=I1(j*part:(j+1)*part,:,i);
    end
    for j=1:2:4
         new(j*part:(j+1)*part,:,i)=I2(j*part:(j+1)*part,:,i);
    end
end
figure; 
imshow(new);

imwrite(new , 'forrotate.jpg');

I = imread('forrotate.jpg');
[row, col , dim] = size(I);
K = uint8(ones(row, col,3));
M = uint8(ones(row, col,3));


for i = 1:row 
   for j = 1:col 
        K(i,j,:) = I(j,i,:);    
    end
end


[r,c,z]=size(K);

for l =1:z
    for i = 1:r
        for j=1:c
            temp = K(i,j,l);
            K(i,j,l)=K(i,c-j+1,l);
            M(i,c-j+1,l)=temp;
        end
    end
end
figure;
imshow(M);

 




