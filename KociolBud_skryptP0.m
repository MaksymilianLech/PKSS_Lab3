%Na zewnatrz ustawione
%Tzew0, Qk0; Fg0 ; Qd0 = [0, 0, 0];   
%------ obliczanie zmiennych stanu ------------------
s_123 = Fg0(1) + Fg0(2) + Fg0(3);
s_23 = Fg0(2) + Fg0(3);
s_12 = Fg0(1) + Fg0(2);
A=[-Kcg(1)-Kcw(1),  Kcg(1),                         0,0,                                                       0,0,                                                     0;
      Kcg(1),              -Kcg(1)-cpw*Fg0(1) ,    0,0,                                                       0,0,                                                      cpw*Fg0(1);
      0,0,                                                       -Kcg(2)-Kcw(2),  Kcg(2),                        0,0,                                                      0;    
      0,0,                                                        Kcg(2),               -Kcg(2)-cpw*Fg0(2),   0,0,                                                       cpw*Fg0(2);
      0,0,                                                        0,0,                                                       -Kcg(3)-Kcw(3),  Kcg(3),                       0;
      0,0,                                                        0,0,                                                        Kcg(3),              -Kcg(3)-cpw*Fg0(3),  cpw*Fg0(3);
      0,cpw*Fg0(1),                                       0,cpw*Fg0(2),                                       0,cpw*Fg0(3),                                     -cpw*s_123];
B=[Kcw(1), 0;      
      0,          0;
      Kcw(2), 0;     
      0,           0;
      Kcw(3), 0;     
      0,0;
      0,          1];
u0 = [Tzew0; Qk0];
x0 = -A^-1*B*u0;
for i = 1:IlePom
    Twew0(i) = x0( (i-1)*2+1);
    Tgp0(i) = x0( (i-1)*2+2);
end
Tkz0 = x0( IlePom*2+1);
Tgp032 = (Tgp0(3)*Fg0(3) + Tgp0(2)*Fg0(2)  )   /   (  Fg0(3)+Fg0(2)    );               %TransportDelay
Tgp0321 = (Tgp0(3)*Fg0(3) + Tgp0(2)*Fg0(2)  + Tgp0(1)*Fg0(1)  )   /   (  Fg0(3) + Fg0(2) + Fg0(1)    ); %TransportDelay
Tkp0 = Tgp0321;
