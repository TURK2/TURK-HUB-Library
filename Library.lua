-- This script was generated using the MoonVeil Obfuscator v1.4.5 [https://moonveil.cc]

local RF,rI,q,Hk,Vw,Ek=pairs,type,bit32.bxor,getmetatable
local ta,DF,mc,lr,Jr,ow,ZO,eK,QK,Lo,gv,Lb,Rk,vq,qR,Of,eQ,CH,Si,lK,ag,Cl,Qs,_i,_b,Qc,Mj,FK,GJ,vw,wK,Iq,Dh,rE,Ar,yn,CJ,nh,lQ,jj,nj,El;
CH=(getfenv());
vw,gv,ow=(string.char),(string.byte),(bit32 .bxor);
eK=(select);
ZO=(function(...)
    return{[1]={...},[2]=eK('#',...)}
end);
eQ=((function()
    local function rj(ya,Fr,Gf)
        if Fr>Gf then
            return
        end
        return ya[Fr],rj(ya,Fr+1,Gf)
    end
    return rj
end)());
GJ,Lb=(string.gsub),(string.char);
ta=(function(DP)
    DP=GJ(DP,'[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]','')
    return(DP:gsub('.',function(xv)
        if(xv=='=')then
            return''
        end
        local Su,sx='',(('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'):find(xv)-1)
        for yc=6,1,-1 do
            Su=Su..(sx%2^yc-sx%2^(yc-1)>0 and'1'or'0')
        end
        return Su
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?',function(IO)
        if(#IO~=8)then
            return''
        end
        local iz=0
        for sc=1,8 do
            iz=iz+(IO:sub(sc,sc)=='1'and 2^(8-sc)or 0)
        end
        return Lb(iz)
    end))
end);
lQ,qR,DF,QK,Mj,Lo,Of,FK=CH[(function(pt,pk)
    local Bh,Fj,dE,mv,SE,oO,Zv,Hv;
    Hv,Zv=function(zt,Rs,QA)
        Zv[Rs]=q(QA,50443)-q(zt,8845)
        return Zv[Rs]
    end,{};
    dE=Zv[31368]or Hv(60216,31368,11188)
    repeat
        if dE<18357 then
            if dE<=9482 then
                if dE<=5190 then
                    if(mv>=0 and Bh>SE)or((mv<0 or mv~=mv)and Bh<SE)then
                        dE=Zv[14116]or Hv(44457,14116,3570)
                    else
                        dE=29823
                    end
                else
                    oO='';
                    dE,mv,SE,Bh=Zv[4241]or Hv(44551,4241,125349),1,(#pt-1)+124,124
                end
            else
                return oO
            end
        elseif dE>=29823 then
            if dE<=29823 then
                oO,dE=oO..vw(ow(gv(pt,(Fj-124)+1),gv(pk,(Fj-124)%#pk+1))),Zv[16275]or Hv(11180,16275,38365)
            else
                Fj=Bh
                if SE~=SE then
                    dE=14805
                else
                    dE=5190
                end
            end
        else
            Bh=Bh+mv;
            Fj=Bh
            if Bh~=Bh then
                dE=Zv[11663]or Hv(60487,11663,118164)
            else
                dE=5190
            end
        end
    until dE==11582
end)('X\203\tB\209\28','+\191{')][(function(DM,tr_)
    local li,ws,jh,_J,mf,P,_z,qr;
    jh,ws={},function(NP,WK,DN)
        jh[WK]=q(NP,12155)-q(DN,38211)
        return jh[WK]
    end;
    _z=jh[-22096]or ws(82470,-22096,11619)
    while _z~=17202 do
        if _z<46397 then
            if _z>=32125 then
                if _z<=32125 then
                    li=mf
                    if _J~=_J then
                        _z=35848
                    else
                        _z=jh[-30789]or ws(79019,-30789,30930)
                    end
                else
                    return qr
                end
            else
                if(P>=0 and mf>_J)or((P<0 or P~=P)and mf<_J)then
                    _z=35848
                else
                    _z=jh[-15715]or ws(67856,-15715,47918)
                end
            end
        elseif _z<56836 then
            qr='';
            _z,P,_J,mf=32125,1,(#DM-1)+153,153
        elseif _z<=56836 then
            mf=mf+P;
            li=mf
            if mf~=mf then
                _z=35848
            else
                _z=11839
            end
        else
            _z,qr=jh[-2650]or ws(96484,-2650,60632),qr..vw(ow(gv(DM,(li-153)+1),gv(tr_,(li-153)%#tr_+1)))
        end
    end
end)('\149N\218\129C\193','\224 \170')],CH[(function(Ml,MC)
    local EK,_m,ht,gi,ka,Ex,um,Es;
    Es,Ex=function(KL,Xa,Lj)
        Ex[Xa]=q(Lj,35262)-q(KL,58829)
        return Ex[Xa]
    end,{};
    ht=Ex[31667]or Es(14623,31667,24915)
    while ht~=45190 do
        if ht>19887 then
            if ht<=30945 then
                if(EK>=0 and um>_m)or((EK<0 or EK~=EK)and um<_m)then
                    ht=Ex[19528]or Es(59473,19528,53503)
                else
                    ht=44323
                end
            else
                ka,ht=ka..vw(ow(gv(Ml,(gi-152)+1),gv(MC,(gi-152)%#MC+1))),Ex[22543]or Es(11637,22543,30970)
            end
        elseif ht>19365 then
            gi=um
            if _m~=_m then
                ht=19365
            else
                ht=30945
            end
        elseif ht<10380 then
            ka='';
            um,_m,ht,EK=152,(#Ml-1)+152,Ex[-11911]or Es(41251,-11911,6947),1
        elseif ht>10380 then
            return ka
        else
            um=um+EK;
            gi=um
            if um~=um then
                ht=19365
            else
                ht=Ex[-4202]or Es(39298,-4202,31886)
            end
        end
    end
end)('\21\248)\15\226<','f\140[')][(function(Pr,vs)
    local Ke,jR,MM,ze,oG,Lc,fL,Nl;
    jR,oG={},function(Vy,rr,lz)
        jR[Vy]=q(lz,62798)-q(rr,3930)
        return jR[Vy]
    end;
    fL=jR[-1809]or oG(-1809,3591,58427)
    while fL~=61852 do
        if fL<40834 then
            if fL<38866 then
                ze='';
                Ke,fL,Nl,MM=(#Pr-1)+71,jR[11212]or oG(11212,49677,104855),71,1
            elseif fL<=38866 then
                return ze
            else
                Nl=Nl+MM;
                Lc=Nl
                if Nl~=Nl then
                    fL=jR[-8069]or oG(-8069,11451,20221)
                else
                    fL=jR[-23990]or oG(-23990,14532,2210)
                end
            end
        elseif fL<=42523 then
            if fL<=40834 then
                Lc=Nl
                if Ke~=Ke then
                    fL=38866
                else
                    fL=jR[995]or oG(995,21399,120405)
                end
            else
                ze,fL=ze..vw(ow(gv(Pr,(Lc-71)+1),gv(vs,(Lc-71)%#vs+1))),jR[-9942]or oG(-9942,41688,113119)
            end
        else
            if(MM>=0 and Nl>Ke)or((MM<0 or MM~=MM)and Nl<Ke)then
                fL=jR[-6307]or oG(-6307,2200,27354)
            else
                fL=42523
            end
        end
    end
end)('\194\196\211','\177')],CH[(function(aO,pC)
    local WM,R,Ss,Gd,ma,S,Uf,DG;
    ma,Gd={},function(fE,On,Sn)
        ma[fE]=q(Sn,24638)-q(On,49263)
        return ma[fE]
    end;
    WM=ma[28034]or Gd(28034,49031,54400)
    repeat
        if WM<59490 then
            if WM<24017 then
                R='';
                DG,S,WM,Uf=1,(#aO-1)+30,27728,30
            elseif WM>24017 then
                Ss=Uf
                if S~=S then
                    WM=59490
                else
                    WM=ma[-2223]or Gd(-2223,45561,69826)
                end
            else
                Uf=Uf+DG;
                Ss=Uf
                if Uf~=Uf then
                    WM=ma[28102]or Gd(28102,23342,123805)
                else
                    WM=65382
                end
            end
        elseif WM<61738 then
            return R
        elseif WM>61738 then
            if(DG>=0 and Uf>S)or((DG<0 or DG~=DG)and Uf<S)then
                WM=59490
            else
                WM=61738
            end
        else
            WM,R=ma[26490]or Gd(26490,3339,84747),R..vw(ow(gv(aO,(Ss-30)+1),gv(pC,(Ss-30)%#pC+1)))
        end
    until WM==38985
end)('E\132p_\158e','6\240\2')][(function(eH,Un)
    local fu_,s_,PH,Km,LB,Hq,vJ,IJ;
    PH,fu_={},function(uC,st,rb)
        PH[st]=q(rb,8731)-q(uC,36106)
        return PH[st]
    end;
    LB=PH[15102]or fu_(23560,15102,81745)
    repeat
        if LB>52206 then
            if LB<=53448 then
                if(Km>=0 and s_>vJ)or((Km<0 or Km~=Km)and s_<vJ)then
                    LB=PH[24668]or fu_(4244,24668,84887)
                else
                    LB=36746
                end
            else
                Hq=s_
                if vJ~=vJ then
                    LB=52206
                else
                    LB=PH[-29877]or fu_(45933,-29877,77108)
                end
            end
        elseif LB>=36746 then
            if LB<=36746 then
                IJ,LB=IJ..vw(ow(gv(eH,(Hq-7)+1),gv(Un,(Hq-7)%#Un+1))),PH[11506]or fu_(64231,11506,62278)
            else
                return IJ
            end
        elseif LB<=19528 then
            IJ='';
            vJ,Km,LB,s_=(#eH-1)+7,1,65078,7
        else
            s_=s_+Km;
            Hq=s_
            if s_~=s_ then
                LB=52206
            else
                LB=PH[1624]or fu_(32230,1624,123823)
            end
        end
    until LB==52180
end)('t\132b\152','\22\253')],CH[(function(Qz,hk)
    local kL,Yb,K,aC,Tp,al,nC,Th;
    K,Th=function(vH,Tj,yt)
        Th[Tj]=q(vH,39420)-q(yt,42054)
        return Th[Tj]
    end,{};
    Tp=Th[26128]or K(24978,26128,15281)
    repeat
        if Tp>38175 then
            if Tp>38463 then
                return aC
            else
                nC=al
                if kL~=kL then
                    Tp=65175
                else
                    Tp=19314
                end
            end
        elseif Tp>22647 then
            al=al+Yb;
            nC=al
            if al~=al then
                Tp=Th[-7249]or K(99522,-7249,47841)
            else
                Tp=19314
            end
        elseif Tp>=19314 then
            if Tp>19314 then
                aC='';
                al,Yb,kL,Tp=139,1,(#Qz-1)+139,Th[19172]or K(9201,19172,34696)
            else
                if(Yb>=0 and al>kL)or((Yb<0 or Yb~=Yb)and al<kL)then
                    Tp=Th[26869]or K(75278,26869,25885)
                else
                    Tp=6730
                end
            end
        else
            Tp,aC=Th[-17349]or K(30906,-17349,59489),aC..vw(ow(gv(Qz,(nC-139)+1),gv(hk,(nC-139)%#hk+1)))
        end
    until Tp==59275
end)('\238d\248>\190','\140\r')][(function(sa,CE)
    local fs,lA,Uy,wh_,Rt,ap,tF,ZP;
    Uy,tF={},function(eb,dQ,OL)
        Uy[OL]=q(dQ,60860)-q(eb,12121)
        return Uy[OL]
    end;
    ZP=Uy[-3046]or tF(50213,127860,-3046)
    while ZP~=42632 do
        if ZP<16241 then
            if ZP>7892 then
                wh_='';
                ap,Rt,lA,ZP=1,(#sa-1)+179,179,7892
            elseif ZP<=2137 then
                return wh_
            else
                fs=lA
                if Rt~=Rt then
                    ZP=2137
                else
                    ZP=16241
                end
            end
        elseif ZP<=42711 then
            if ZP>16241 then
                wh_,ZP=wh_..vw(ow(gv(sa,(fs-179)+1),gv(CE,(fs-179)%#CE+1))),Uy[8541]or tF(55285,67134,8541)
            else
                if(ap>=0 and lA>Rt)or((ap<0 or ap~=ap)and lA<Rt)then
                    ZP=Uy[-25147]or tF(10379,64919,-25147)
                else
                    ZP=Uy[-9815]or tF(27492,1704,-9815)
                end
            end
        else
            lA=lA+ap;
            fs=lA
            if lA~=lA then
                ZP=Uy[27757]or tF(25268,48122,27757)
            else
                ZP=Uy[-32390]or tF(30514,31328,-32390)
            end
        end
    end
end)('F}\14Ch\18','*\14f')],CH[(function(Oc,hw)
    local Fk,GK,cA,UA,lH,RM,Dk,Ga;
    UA,lH={},function(fH,sp,yA)
        UA[yA]=q(sp,5186)-q(fH,57169)
        return UA[yA]
    end;
    RM=UA[-12805]or lH(58208,79325,-12805)
    repeat
        if RM<=46238 then
            if RM>43381 then
                Fk,RM=Fk..vw(ow(gv(Oc,(Ga-83)+1),gv(hw,(Ga-83)%#hw+1))),UA[-30656]or lH(36603,17353,-30656)
            elseif RM<=10364 then
                if RM>1505 then
                    return Fk
                else
                    GK=GK+Dk;
                    Ga=GK
                    if GK~=GK then
                        RM=UA[1378]or lH(5446,59089,1378)
                    else
                        RM=UA[25684]or lH(58995,63189,25684)
                    end
                end
            else
                if(Dk>=0 and GK>cA)or((Dk<0 or Dk~=Dk)and GK<cA)then
                    RM=UA[5541]or lH(37290,25397,5541)
                else
                    RM=UA[-3975]or lH(42839,80102,-3975)
                end
            end
        elseif RM>58597 then
            Fk='';
            cA,RM,GK,Dk=(#Oc-1)+83,UA[6749]or lH(15470,121958,6749),83,1
        else
            Ga=GK
            if cA~=cA then
                RM=UA[31735]or lH(19589,43026,31735)
            else
                RM=43381
            end
        end
    until RM==61896
end)('xLn\22(','\26%')][(function(Eh,jm)
    local bH,qg,td,Wk,ft,Ef,of,bK;
    Wk,of=function(Lt,QM,kQ)
        of[kQ]=q(Lt,19826)-q(QM,40993)
        return of[kQ]
    end,{};
    qg=of[-12726]or Wk(41566,59487,-12726)
    repeat
        if qg<39423 then
            if qg<=23656 then
                if qg>9894 then
                    td=td+Ef;
                    bK=td
                    if td~=td then
                        qg=of[24774]or Wk(122529,23029,24774)
                    else
                        qg=9894
                    end
                else
                    if(Ef>=0 and td>bH)or((Ef<0 or Ef~=Ef)and td<bH)then
                        qg=of[21091]or Wk(85942,51428,21091)
                    else
                        qg=39719
                    end
                end
            else
                bK=td
                if bH~=bH then
                    qg=39423
                else
                    qg=9894
                end
            end
        elseif qg<=39719 then
            if qg<=39423 then
                return ft
            else
                qg,ft=of[-8330]or Wk(66867,19448,-8330),ft..vw(ow(gv(Eh,(bK-102)+1),gv(jm,(bK-102)%#jm+1)))
            end
        else
            ft='';
            bH,qg,Ef,td=(#Eh-1)+102,of[13646]or Wk(91745,3259,13646),1,102
        end
    until qg==58218
end)('\96Gj{Rv','\18\52\2')],CH[(function(Ie,YC)
    local KQ,tl,XE,Mh,GG,xG,lM,wC;
    tl,lM={},function(OD,re_,rg)
        tl[rg]=q(OD,43958)-q(re_,1167)
        return tl[rg]
    end;
    Mh=tl[-9107]or lM(9360,16074,-9107)
    while Mh~=61610 do
        if Mh>54534 then
            if Mh>57597 then
                Mh,GG=tl[23861]or lM(25742,49941,23861),GG..vw(ow(gv(Ie,(XE-244)+1),gv(YC,(XE-244)%#YC+1)))
            else
                return GG
            end
        elseif Mh>=21729 then
            if Mh<=21729 then
                GG='';
                xG,Mh,wC,KQ=1,59,244,(#Ie-1)+244
            else
                if(xG>=0 and wC>KQ)or((xG<0 or xG~=xG)and wC<KQ)then
                    Mh=tl[27454]or lM(117089,34133,27454)
                else
                    Mh=63278
                end
            end
        elseif Mh>59 then
            wC=wC+xG;
            XE=wC
            if wC~=wC then
                Mh=57597
            else
                Mh=tl[-26007]or lM(66846,56621,-26007)
            end
        else
            XE=wC
            if KQ~=KQ then
                Mh=57597
            else
                Mh=54534
            end
        end
    end
end)('\134\189\144\231\214','\228\212')][(function(Zs,kg)
    local aP,do_,Y,DA,Os,NL,DC,NQ;
    Os,Y=function(hD,zs,Fy)
        Y[hD]=q(zs,57523)-q(Fy,60378)
        return Y[hD]
    end,{};
    aP=Y[-32534]or Os(-32534,3905,28187)
    while aP~=4935 do
        if aP<=33616 then
            if aP<=27185 then
                if aP>=14778 then
                    if aP<=14778 then
                        NL=DC
                        if DA~=DA then
                            aP=40295
                        else
                            aP=Y[-15609]or Os(-15609,4667,21813)
                        end
                    else
                        do_='';
                        NQ,aP,DC,DA=1,Y[21223]or Os(21223,31030,46097),204,(#Zs-1)+204
                    end
                else
                    if(NQ>=0 and DC>DA)or((NQ<0 or NQ~=NQ)and DC<DA)then
                        aP=Y[-16843]or Os(-16843,102519,14471)
                    else
                        aP=33616
                    end
                end
            else
                do_,aP=do_..vw(ow(gv(Zs,(NL-204)+1),gv(kg,(NL-204)%#kg+1))),Y[11189]or Os(11189,121256,48336)
            end
        elseif aP<=40295 then
            return do_
        else
            DC=DC+NQ;
            NL=DC
            if DC~=DC then
                aP=40295
            else
                aP=Y[-15175]or Os(-15175,1158,23366)
            end
        end
    end
end)('\4=\b\56','f\\')],CH[(function(eB,cc)
    local Ho,pI,lB,RI,Vk,lj,sE,Sf;
    Vk,lj={},function(yk,tE,_v)
        Vk[tE]=q(_v,39823)-q(yk,43824)
        return Vk[tE]
    end;
    RI=Vk[-15718]or lj(41179,-15718,19381)
    repeat
        if RI>45056 then
            if RI>46819 then
                sE='';
                Ho,RI,Sf,pI=(#eB-1)+60,37020,1,60
            else
                if(Sf>=0 and pI>Ho)or((Sf<0 or Sf~=Sf)and pI<Ho)then
                    RI=2271
                else
                    RI=15283
                end
            end
        elseif RI>=37020 then
            if RI>37020 then
                pI=pI+Sf;
                lB=pI
                if pI~=pI then
                    RI=Vk[-13953]or lj(30847,-13953,18337)
                else
                    RI=Vk[-10141]or lj(24177,-10141,79787)
                end
            else
                lB=pI
                if Ho~=Ho then
                    RI=Vk[-11838]or lj(59403,-11838,55189)
                else
                    RI=46819
                end
            end
        elseif RI<=2271 then
            return sE
        else
            RI,sE=Vk[-30492]or lj(48665,-30492,24230),sE..vw(ow(gv(eB,(lB-60)+1),gv(cc,(lB-60)%#cc+1)))
        end
    until RI==26651
end)('0\195&\206!','D\162')][(function(Kl,Xp)
    local le,Vv,Ji,el_,dP,zK,Rx,Zo;
    Rx,Zo={},function(LD,yD,ne)
        Rx[LD]=q(ne,50650)-q(yD,40098)
        return Rx[LD]
    end;
    zK=Rx[-18901]or Zo(-18901,49723,20357)
    while zK~=59908 do
        if zK>36168 then
            if zK>38438 then
                Ji=Ji+el_;
                Vv=Ji
                if Ji~=Ji then
                    zK=38438
                else
                    zK=35102
                end
            else
                return dP
            end
        elseif zK<=35102 then
            if zK<=14856 then
                if zK<=11206 then
                    dP='';
                    zK,el_,Ji,le=Rx[13401]or Zo(13401,4108,121900),1,62,(#Kl-1)+62
                else
                    dP,zK=dP..vw(ow(gv(Kl,(Vv-62)+1),gv(Xp,(Vv-62)%#Xp+1))),Rx[26039]or Zo(26039,49988,125236)
                end
            else
                if(el_>=0 and Ji>le)or((el_<0 or el_~=el_)and Ji<le)then
                    zK=38438
                else
                    zK=Rx[406]or Zo(406,60756,28196)
                end
            end
        else
            Vv=Ji
            if le~=le then
                zK=Rx[27677]or Zo(27677,51894,10720)
            else
                zK=35102
            end
        end
    end
end)('\6v\29\6x\a','e\25s')],{};
Qc=(function(Ds)
    local Yk=FK[Ds]
    if not(Yk)then
    else
        return Yk
    end
    local ty,IL,kt,eE,pu=QK(-12709- -12710,2506-2495),QK(19119/19119,20692+-20687),8396-8395,{},''
    while kt<=#Ds do
        local Cb=DF(Ds,kt);
        kt=kt+15573/15573
        for vn=0.12395309882747069*1791,(-145288/-18161)+-4870398/-22038 do
            local Eu=nil
            if not(Lo(Cb,-32662+32663)~=0)then
                if kt+5497/5497<=#Ds then
                    local FO=lQ((function(iC,MN)
                        local CF,Ko,CP,Na,ZB,aI,DI,Zn;
                        Zn,ZB={},function(yy,dJ,LH)
                            Zn[yy]