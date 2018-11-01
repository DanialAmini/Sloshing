# for running this file, first copy test.jl in installatioin path of julia 
#type the following in julia
# include("test.jl")



##########################################
#                            functions                               #
##########################################
function phi(A,x,eta_)
    temp=A[1];
    for j=2:Nf+1
        jj=j-1;
        temp=temp+A[j]*cos(jj*x)*(cosh(jj*eta_)+tanh(jj*q)*sinh(jj*eta_));
    end
    z=temp;
end

function w(A,x,eta_)
    temp=0;
    for j=2:Nf+1
        jj=j-1;
        temp=temp+jj*A[j]*cos(jj*x)*(sinh(jj*eta_)+tanh(jj*q)*cosh(jj*eta_));
    end
    z=temp;
end

function u(A,x,eta_)
    temp=0;
    for j=2:Nf+1
        jj=j-1;
        temp=temp-jj*A[j]*sin(jj*x)*(cosh(jj*eta_)+tanh(jj*q)*sinh(jj*eta_));
    end
    z=temp;
end

function eta(B,x)
    temp=0;
    for j=2:Nf+1
        jj=j-1;
        temp=temp+B[j]*cos(jj*x);
    end
    z=temp;
end

function etax(B,x)
    temp=0;
    for j=2:Nf+1
        jj=j-1;
        temp=temp-jj*B[j]*sin(jj*x);
    end
    z=temp;
end

function fphi(A,B)
    fphiR=zeros(Nf+1,1);
    dx=pi/M;
    
    for m=0:M
        x=m*pi/M;
        eta_=eta(B,x);
        phi_=phi(A,x,eta_);
        alpha=1;
        if m==0 || m==M
            alpha=0.5;
        end
        for j=1:Nf+1
            jj=j-1;
            if j==1 
                fourier_=1/pi;
            else
                fourier_=2/pi;
            end
            fourier_=1;
            fphiR[j]=fphiR[j]+phi_*alpha*dx*cos(jj*x)*fourier_; 
        end
    end

    z=fphiR;
end

function fkdR(A,B)
    fkdR_res=zeros(Nf+1,2);
    dx=pi/M;
    
    for m=0:M
        x=m*pi/M;
        eta_=eta(B,x);
        etax_=etax(B,x);
        u_=u(A,x,eta_);
        w_=w(A,x,eta_);
        alpha=1;
        if m==0 || m==M
            alpha=0.5;
        end

        for j=1:Nf+1
            jj=j-1;
            if j==1
                fourier_=1/pi;
            else
                fourier_=2/pi;
            end
            fourier_=1;
            if j>=2
                fkdR_res[j,1]=fkdR_res[j,1]+(w_-u_*etax_)*alpha*dx*cos(jj*x)*fourier_;
            end
            fkdR_res[j,2]=fkdR_res[j,2]-(eta_+1/2*(u_^2+w_^2))*alpha*dx*cos(jj*x)*fourier_; 
        end
    end
    

    z=fkdR_res;
end

function CC(B)
    global q;
    CC_=zeros(Nf+1,Nf+1);
    dx=pi/M;
    CC_[1,1]=pi;
    for m=0:M
        x=m*pi/M;
        eta_=eta(B,x);
        alpha=1;
        if m==0 || m==M
            alpha=0.5;
        end
        for jCol=2:Nf+1
            j=jCol-1;
            beta=(cosh(j*eta_)+tanh(j*q)*sinh(j*eta_))*cos(j*x);
            for jRow=1:Nf+1
                jj=jRow-1;
                CC_[jRow,jCol]=CC_[jRow,jCol]+beta*cos(jj*x)*dx*alpha;
            end
        end
    end
    
    z=CC_;
end



##########################################
# testing the file
##########################################




global a1;
global b1;


print(' ');
Nf=10; #trigonometric terms
M=100; #collocation points
Nt=8000;#20000; #time step
dx=pi/M;

FR=zeros(M+1,1);
C=zeros(M+1,Nf+1);

b0=zeros(Nf+1,1);


# a_=rand(Nf+1,No);
# b_=rand(Nf+1,No);

listA=zeros(Nf+1,Nt);
listB=zeros(Nf+1,Nt);

b0[2+1]=0.200407244;
# b0[3]=0.019816477;
# b0[4]=0.002981289;
# b0[5]=0.000429811;
# b0[6]=4.11347E-05;
# 
# b0[1+1]=0.1215854203000;
# b0[2+1]=0.0000000000000;
# b0[3+1]=0.0135094911500;
# b0[4+1]=0.0000000000000;
# b0[5+1]=0.0048634168120;
# b0[6+1]=0.0000000000000;
# b0[7+1]=0.0024813351090;
# b0[8+1]=0.0000000000000;
# b0[9+1]=0.0015010545720;
# b0[10+1]=0.0000000000000;
# b0[11+1]=0.0010048381850;
# b0[12+1]=0.0000000000000;
# b0[13+1]=0.0007194403568;
# b0[14+1]=0.0000000000000;
# b0[15+1]=0.0005403796459;
# b0[16+1]=0.0000000000000;
# b0[17+1]=0.0004207107969;
# b0[18+1]=0.0000000000000;
# b0[19+1]=0.0003368017183;
# b0[20+1]=0.0000000000000;


# b0[0+1]=-0.0000000000000;
# b0[1+1]=0.0000000000000;
# b0[2+1]=-0.0160587519200;
# b0[3+1]=0.0000000000000;
# b0[4+1]=0.0119432451600;
# b0[5+1]=0.0000000000000;
# b0[6+1]=-0.0072913275850;
# b0[7+1]=0.0000000000000;
# b0[8+1]=0.0036539666530;
# b0[9+1]=0.0000000000000;
# b0[10+1]=-0.0015031290000;
# b0[11+1]=0.0000000000000;
# b0[12+1]=0.0005075766482;
# b0[13+1]=0.0000000000000;
# b0[14+1]=-0.0001406956657;
# b0[15+1]=0.0000000000000;
# b0[16+1]=0.0000320135259;
# b0[17+1]=-0.0000000000000;
# b0[18+1]=-0.0000059794330;
# b0[19+1]=0.0000000000000;
# b0[20+1]=0.0000009167696;

#b0[0+1]=-0.0000000000000;
#b0[1+1]=0.0036768280420;
#b0[2+1]=-0.0036298792670;
#b0[3+1]=-0.0071059194110;
#b0[4+1]=-0.0034480029150;
#b0[5+1]=0.0033176014140;
#b0[6+1]=0.0063298005670;
#b0[7+1]=0.0029934712800;
#b0[8+1]=-0.0028071744400;
#b0[9+1]=-0.0052200293200;
#b0[10+1]=-0.0024060006110;
#b0[11+1]=0.0021990128160;
#b0[12+1]=0.0039853734560;
#b0[13+1]=0.0017903153560;
#b0[14+1]=-0.0015947745120;
#b0[15+1]=-0.0028169443780;
#b0[16+1]=-0.0012333220800;
#b0[17+1]=0.0010707398790;
#b0[18+1]=0.0018433197900;
#b0[19+1]=0.0007865686676;
#b0[20+1]=-0.0006655517600;
#b0[21+1]=-0.0011166993560;
#b0[22+1]=-0.0004644189635;
#b0[23+1]=0.0003829947848;
#b0[24+1]=0.0006263037501;
#b0[25+1]=0.0002538612494;
#b0[26+1]=-0.0002040408155;
#b0[27+1]=-0.0003251972950;
#b0[28+1]=-0.0001284683209;
#b0[29+1]=0.0001006362412;
#b0[30+1]=0.0001563226840;

#b0=b0*2;

q=4.06859336;

dt=0.00631767;

 #       a1=zeros(Nf+1,1);
#        b1=b0;    
#        listA[:,1]=a1;
 #       listB[:,1]=b1;
a0=zeros(Nf+1,1);
a1=zeros(Nf+1,1);
b1=zeros(Nf+1,1);
ap1=zeros(Nf+1,1);
ap2=zeros(Nf+1,1);
bp1=zeros(Nf+1,1);
bp2=zeros(Nf+1,1);

for k=2:Nt #time steps
    if k==2
        b1[:]=b0[:];
        listA[:,1]=a1[:];
        listB[:,1]=b1[:];
    end

    fphi_=fphi(a1,b1);
    CC1=CC(b1);  

    fkdR1=fkdR(a1,b1);
    bp1[:]=b1[:]; 
    L=fphi_+fkdR1[:,2]*dt;
    for j=2:Nf+1
        bp1[j]=bp1[j]+2/pi*dt*fkdR1[j,1];
    end  
    ap1=CC1\L;  


    temp=fkdR(ap1,bp1);    
    fkdR1[:]=fkdR1[:]/2+temp[:]/2;
    bp2[:]=b1[:]; 
    L=fphi_+fkdR1[:,2]*dt;
    for j=2:Nf+1
        bp2[j]=bp2[j]+2/pi*dt*fkdR1[j,1];
    end
    ap2=CC1\L;     


    a1[:]=ap2[:];
    b1[:]=bp2[:];
    listA[:,k]=a1;	
    listB[:,k]=b1;

    progress=round(k/Nt*1000)/10;
    print(" Calculation progress: $(progress)%   \r");

#	print(L,"\r\n");

end
print(' ');
listBT=transpose(listB);
listAT=transpose(listA);
#writedlm("b.txt",listBT,"\t");   #has  a problem with unix/windows new line character

fff=open("b.txt","w");
for i=1:Nt
    for j=1:Nf+1
        write(fff,string(listBT[i,j]));
        if j<Nf+1
            write(fff,"\t");
        end
    end
    write(fff,"\r\n");
end
close(fff);


fff=open("a.txt","w");
for i=1:Nt
    for j=1:Nf+1
        write(fff,string(listAT[i,j]));
        if j<Nf+1
            write(fff,"\t");
        end
    end
    write(fff,"\r\n");
end
close(fff);


print(' ');

