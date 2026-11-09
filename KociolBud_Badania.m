clear all; close all; clearvars;
skala = 60;             %skala czasu (wszystkie czasy w minutach) 
%gdy n=60, to Max step size daæ 0.1 
schemat = 'KociolBud3CvwCvg';        
IlePom = 3;                     %ile pomieszczen
czas = 3000; czas_skok = 500;
%----------------------------------------------------
kolor = 'rgbcm'; linia = ['- '; '--'; ': '];
KociolBud_skryptWN;                             %obliczenia parametrow (warunki nominalne), nazwa schematu
%model (wartosci parametrow z identyfikacji)
k = 8 / (0.2*QkN);
T_st = 500; T0_st = 50;       %4 / 3000 = 0.0013
t1 = 230; t2 = 470;
T_mp = 1.5*(t2 - t1); T0_mp = t2 - T_mp;
%===========================================================
%            BADANIA 
%===========================================================
%============= warunki poczatkowe nominalne  ===================
Tzew0 = TzewN;                  
Qk0 = QkN*1;
Fg0 = [1, 1, 1] .* FgN;
Qd0 = [0, 0, 0];                                   %zawsze
KociolBud_skryptP0;
%=================== zaklocenie ======================
dTzew = 0;
dQk = 0.1*QkN;
dFg = [0, 0, 0] .* FgN;     %procent przeplywu nominalnego danego grzejnika
dQd = [0, 0, 0] .* QgN;      %procent zapotrzebowania nominalnego danego pomieszczenia
%-------------------------------------------------------
%wartosci dla regulacji
SP0 = Twew0(1);
dSP = 1;
%nastawy styczna
a_st = (k * T0_st)/T_st;
Kp_st = 0.9/a_st;
Ti_st = 3*T0_st;
Ki_st = 1/Ti_st;
%nastawy m2p
a_mp = (k * T0_mp)/T_mp;
Kp_mp = 0.9/a_mp;
Ti_mp = 3*T0_mp;
Ki_mp = 1/Ti_mp;
%nastawy pid tune 
G_st = tf(k, [T_st 1], 'InputDelay', T0_st);
G_mp = tf(k, [T_mp 1], 'InputDelay', T0_mp);
C_c = pidtune(G_st, 'PI');   Kp_c = C_c.Kp;   Ti_c = C_c.Kp / C_c.Ki;   % c) styczna
C_d = pidtune(G_mp, 'PI');   Kp_d = C_d.Kp;   Ti_d = C_d.Kp / C_d.Ki;
%==============================================================================
%symulacja                                                     % wersja po 2019
%[t] = sim(schemat, czas);                                     %[out] = sim(schemat, czas);
%figure(1); hold on;grid on;
%plot(t, aTwew_1, strcat(kolor(1), linia(1,:)));     %plot(out,tout, out.aTwew_1, strcat(kolor(1), linia(1,:)));
%plot(t, aTwew_2, strcat(kolor(2), linia(2,:)));  
%plot(t, aTwew_3, strcat(kolor(3), linia(3,:)));
%plot(t,aPV,'k');
%title('T_w_e_w [^oC]'); xlabel('t[min]'); ylabel('Twew');
%legend('T_w_e_w_1');

[y] = sim('regulacja', czas);

figure(1); hold on;grid on; 
plot(y.tout, y.PV);
xlim([0, 1400]); 
legend('Metoda stycznej regulacja(PV - Twew(1))');

figure(2); hold on;grid on; 
plot(y.tout, y.PV1);
legend('Metoda 2 pkt. regulacja(PV - Twew(1))');
xlim([0, 2000]);

figure(3); hold on; grid on;
CV_st = y.CV + Qk0;
plot(y.tout, CV_st);
legend('Metoda 2 pkt. regulacja(CV1 - Qk)');

figure(4); hold on; grid on;
CV1_mp = y.CV1 + Qk0;
plot(y.tout, CV1_mp);
legend('Metoda 2 pkt. regulacja(CV1 - Qk)');

figure(5); hold on; grid on;
[t] = sim(schemat, czas);
plot(t.tout, t.PV_O);

% figure(4); hold on;grid on; 
% [y] = sim('styczna', czas);
% plot(t, aTwew_1, strcat(kolor(1), linia(1,:)));
% plot(y.tout, y.st, strcat(kolor(2), linia(1,:)));
% plot(y.tout, y.st1, strcat(kolor(3), linia(1,:)));
% legend('obiekt', 'model - st', 'model - m2p');




