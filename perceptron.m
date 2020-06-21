
clear;
% c=input('dosya ad�: ','s'); %istenilen veri dosyas�n�n ad� bu sat�r aktifle�tirilerek command windowa yaz�larak H verisi al�nabilir.
data=dlmread('denemenoktasi.txt');

train(:,1)=data(:,1);%s�n�flama i�in noktalar al�nd�
train(:,2)=data(:,2);
tag=data(:,3);%etiketler al�nd�.
z=0;m=0;
for l=1:size(train,1)
    if data(l,3)>0
        z=z+1;
        C1(z,:)=train(l,1:2);
    else
        m=m+1;
        C2(m,:)=train(l,1:2);
    end
end
plot(C1(:,1),C1(:,2),'r.','DisplayName','class1');
legend
hold on
plot(C2(:,1),C2(:,2),'b+','DisplayName','class2');
axis([min(train(:,1))-1 max(train(:,1))+1 min(train(:,2))-1 max(train(:,2))+1])
grid
%Kural gere�i noktalar�n soluna 1 yaz�ld�.
k=1;
for a=k:size(train,1)
    A(a,1)=1;
end
%form�ller uyguland�.
    H=[A,train];
    teta=pinv(H)*tag;
    
    W0=teta(1);
    W1=teta(2);
    W2=teta(3);

    %boundry �izimi i�in a�a��daki d�ng� kullan�ld�.
    n=0;
for x1=min(train(:,1))-5:0.01:max(train(:,1))+5
    n=n+1;
    x1_vec(n)=x1;
    x2=(-W0-W1*x1)/W2;
    x2_vec(n)=x2;
end
 plot(x1_vec,x2_vec,'g') % s�n�r do�rusu �izimi
 
%hata say�m� i�in a�a��daki d�ng� kullan�ld�.
h=0;
for i=1:z
    if W0+W1*C1(i,1)+W2*C1(i,2)<=0
        h=h+1;
    end
end
for i=1:m
    if W0+W1*C2(i,1)+W2*C2(i,2)>=0
        h=h+1;
    end
end

performans=(size(train,1)-h)/(size(train,1))*100 %DO�RULUK ORANI 
        
 


