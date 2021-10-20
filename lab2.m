%duom
x = 0.1:1/22:1;
%x2 = 0.1:1/22:1;
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;

figure(1), plot(x, d,'b*'), grid on

%paslėptasis sluoksnis
w11_1 = rand(1);
w21_1 = rand(1);
w31_1 = rand(1);
w41_1 = rand(1);
b1_1 = rand(1);
b2_1 = rand(1);
b3_1 = rand(1);
b4_1 = rand(1);

%antras slouksnis
w11_2 = rand(1);
w12_2 = rand(1);
w13_2 = rand(1);
w14_2 = rand(1);
b1_2 = rand(1);

%tinklo atsakas
n=0.1;
for indx_n = 1:100000    
for indx=1:length(x)
    %tinklo atsakas pirmojo slouksnio neuronams
    v1_1 = x(indx)*w11_1+b1_1;
    v2_1 = x(indx)*w21_1+b2_1;
    v3_1 = x(indx)*w31_1+b3_1;
    v4_1 = x(indx)*w41_1+b4_1;
    
    %aktyvios funkcijos pritaikymas
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1)); 
    
    %tinklo atsakas antrojo slouksnio neuronams 
    v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+b1_2;
    
    %aktyvios funkcijos pritaikymas
    y1_2 = v1_2; %???
    y = y1_2;
    
    %klaidos skaiciavimas
    e=d(indx) - y;
    
    
    delta_out=1*e;
    
    
    delta1 = y1_1*(1-y1_1) * delta_out*w11_2;
    delta2 = y2_1*(1-y2_1) * delta_out*w12_2;
    delta3 = y3_1*(1-y3_1) * delta_out*w13_2;
    delta4 = y4_1*(1-y4_1) * delta_out*w14_2;
    
    %svoriai paskutinio isejimo
    w11_2 = w11_2 + n*e*y1_1;
    w12_2 = w12_2 + n*e*y2_1;
    w13_2 = w13_2 + n*e*y3_1;
    w14_2 = w14_2 + n*e*y4_1;
    
    b2_1 = b2_1+n+delta2;
    
    %pasleptojo sluoksnio neuronai
    b1_1 = b1_1+n*delta1;
    b2_1 = b2_1+n*delta2;
    b3_1 = b3_1+n*delta3;
    b4_1 = b4_1+n*delta4;
    
    w11_1 = w11_1 +n*delta1*x(indx);
    w21_1 = w21_1 +n*delta2*x(indx);
    w31_1 = w31_1 +n*delta3*x(indx);
    w41_1 = w41_1 +n*delta4*x(indx);
    
    %y=v; %end

end
end

%tinklo atsakas
Y=0.1:1/22:1;
for indx = 1:length(x)
    %tinklo atsakas pirmo sluoksnio neuronams
    v1_1 = x(indx)*w11_1+b1_1;
    v2_1 = x(indx)*w21_1+b2_1;
    v3_1 = x(indx)*w31_1+b3_1;
    v4_1 = x(indx)*w41_1+b4_1;

    %aktyv. f. pritaikymas
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    
    %tinklo atsakas antrojo sluoksnio neuronui
    v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+b1_2;
    %aktyv. f. pritaikymas
    y1_2 = v1_2;
    y = y1_2;
    %tarpines reiksmes
    Y(indx) = y;
end
plot(x,d,'rx',x,Y,'go');


