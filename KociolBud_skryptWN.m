
%=============wartosci nominalne globalne=====================
cpw = 4200; row = 1000;     %woda cp [J/kg K], ro [kg/m3]
cpp = 1000; rop = 1.2;          %powietrze cp [J/kg K], ro [kg/m3]
cps = 800; ros = 840;           %beton komorkowy cp [J/kg K], ro [kg/m3]
%----------- zapotrzebowanie i kociol --------------
QkN = 15*1000;           %moc kotla. 15 kW
Vk = 10/1000;         %pojemnosc kotla
Cvk = cpw*row*Vk/skala;    %pojemnosc cieplna kotla
%----- wymiary budynku --------------------------------
VgN = IlePom * 50/1000;      %l -> m^3 (wszystkie grzejniki)
VwN = 10 * 10 * 2.5;             %m3 (caly budynek)
gs = 0.10;                              %grubosc scian
VsN = (10 + 2 * gs) * (10 + 2 * gs) * 2.5 - VwN;   %m3 (ca³y budynek)
 tau_siec = 240 / skala;          %opoznienia w sieci:  180 duze 
 %---------------------------------------------------------
CvwN = cpp*rop*VwN + cps*ros*VsN ; CvgN = cpw*row*VgN; CvsN = 0;
CvwN = CvwN / skala; CvgN = CvgN / skala ; CvsN = CvsN / skala;  %przeskalowanie
 %-----------------------------------------
TzewN = -20;
TwewN = 20; TsN = 5;
TgpN = 70;
TgzN = 90;
QdN = 0;
%----------- pomieszczenia (takie same) --------------
for i = 1:IlePom
    QgN(i) = QkN / IlePom; 
    Kcg(i) = QgN(i) / (TgpN-TwewN);
    Kcw(i) = QgN(i) / (TwewN-TzewN);
    Cvg(i) = CvgN  / IlePom;     % grzejnik, zalezy od jednostki czasu
    Cvw(i) = CvwN / IlePom;     % pomieszczenie 
    Cvs(i) = CvsN / IlePom;     % sciany      
    FgN(i) = QgN(i) / (cpw*(TgzN-TgpN));
end    
