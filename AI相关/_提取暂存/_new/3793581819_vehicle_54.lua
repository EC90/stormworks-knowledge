-- source: steam id 3793581819 / vehicle.xml block#54
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3793581819
a=math;c=input;F=cos;G=sin;O=pi;T=output;
--yyy--
ap=a.cos;aq=a.sin;O=a.pi;d=2*O;r=2*O;ar=0;as=0;at=0;au=0;av=0;aw=0;B=0;C=0;f=0;s={0,0,0}e={1,1,1}U={0.007,0.007,0.007}V={1,1,1}t={0,0,0}W=0.6;function X(f)ax={}ay={}for b=1,3 do t[b]=s[b]+(s[b]-t[b])*W;e[b]=e[b]+U[b]P=e[b]/(e[b]+V[b])s[b]=t[b]+P*(f[b]-t[b])e[b]=(1-P)*e[b]end;return s end;function D(E,u,v,w)x={}F=a.cos;G=a.sin;g=F(w)h=G(w)y=F(u)i=G(u)j=F(v)k=G(v)Y=g*y;Z=g*i*k-h*j;_=g*i*j+h*k;a0=h*y;a1=h*i*k+g*j;a2=h*i*j-g*k;a3=-i;a4=y*k;a5=y*j;H=E.x;I=E.y;J=E.z;x.x=Y*H+Z*I+_*J;x.y=a0*H+a1*I+a2*J;x.z=a3*H+a4*I+a5*J;return x end;function onTick()l,m=a.cos(B),a.sin(B)z,n=a.cos(C),a.sin(C)o,p=a.cos(f),a.sin(f)Q=z*o;az=-l*p+m*n*o;a6=m*p+l*n*o;q=z*p;K=l*o+m*n*p;L=-m*o+l*n*p;R=-n;aA=m*z;a7=l*z;a8=a.atan(a6,a7)/-r;a9=a.atan(q,a.sqrt(Q*Q+R*R))/r;aa=a.atan(K,a.sqrt(q*q+L*L))/r;ab=a.atan(L,a.sqrt(K*K+q*q))/r;ac=c.getNumber(1)ad=c.getNumber(3)ae=c.getNumber(2)B=c.getNumber(4)C=c.getNumber(5)f=c.getNumber(6)af=-c.getNumber(7)*d;ag=c.getNumber(8)*d;S=c.getNumber(9)w=a8*-d;u=ab*d;v=-a9*d;ah=aa*d;ai=a.atan(a.sin(v),a.sin(ah))A={}A.x=0;A.y=S;A.z=0;aj=D(A,0,ag,af)ak=D(aj,ai,0,0)M=D(ak,0,u,-w)al,am,an=M.x+ac,M.y+ad,M.z+ae;ao={al,am,an}N=X(ao)if S~=0 then T.setNumber(1,N[1])T.setNumber(2,N[2])T.setNumber(3,N[3])end end
-- ________   ________          _____ ______   _______   ________  ________      ___    ___ 
--|\   ___  \|\   __  \        |\   _ \  _   \|\  ___ \ |\   __  \|\   ____\    |\  \  /  /|
--\ \  \\ \  \ \  \|\  \       \ \  \\\__\ \  \ \   __/|\ \  \|\  \ \  \___|    \ \  \/  / /
-- \ \  \\ \  \ \  \\\  \       \ \  \\|__| \  \ \  \_|/_\ \   _  _\ \  \        \ \    / / 
--  \ \  \\ \  \ \  \\\  \       \ \  \    \ \  \ \  \_|\ \ \  \\  \\ \  \____    \/  /  /  
--   \ \__\\ \__\ \_______\       \ \__\    \ \__\ \_______\ \__\\ _\\ \_______\__/  / /    
--    \|__| \|__|\|_______|        \|__|     \|__|\|_______|\|__|\|__|\|_______|\___/ /     
--                                                                             \|___|/      
                                                                                          