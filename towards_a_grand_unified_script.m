(* ::Package:: *)

(* ::Input::Initialization:: *)
(*Define symmetric quantization rho*)
CleanSlate;
$MinPrecision=MachinePrecision;
  \[Rho]z[z_] := z/(1 + Sqrt[1 - z])^2; 
 \[Rho]zb[z_] := \[Rho]z[Conjugate[z]]; 
 (*error estimates*)
    \[Rho]intErrorEstimateG[d_, DDs_, z_, \[Gamma]_] := (2^(\[Gamma] + 4*d)*\[Beta]^(\[Gamma] - 4*d)*Gamma[1 - \[Gamma] + 4*d, \[Beta]*DDs])/(Gamma[1 - \[Gamma] + 4*d]*(1 - r^2)^\[Gamma])/.  {r -> Abs[\[Rho]z[z]], \[Beta] -> -Log[Abs[\[Rho]z[z]]]}; 
      \[Rho]intErrorEstimateFt[d_, DDs_, z_, \[Gamma]_] := 
     v^d*\[Rho]intErrorEstimateG[d, DDs, z, \[Gamma]] + u^d*\[Rho]intErrorEstimateG[d, DDs, 1 - z, \[Gamma]] /. {u -> z*Conjugate[z], v -> (1 - z)*(1 - Conjugate[z])}; 
     (*coefficients and prefactors*)
    kfunctAna[\[Beta]_, x_] := Exp[(\[Beta]/2)*Log[4*((1 - Sqrt[1 - x])^2/x)]]*(x/(2*(1 - x)^(1/4)*(1 - Sqrt[1 - x]))); 
    ConformalBlockAna[DD_, l_, z_] := ((-1)^l/2^l)*((z*Conjugate[z])/(z - Conjugate[z]))*(kfunctAna[DD + l, z]*kfunctAna[DD - l - 2, Conjugate[z]] - 
       kfunctAna[DD + l, Conjugate[z]]*kfunctAna[DD - l - 2, z]);
       (*derivatives*)
       FAnaDer[DD_, l_, z_] := (1/(z - Conjugate[z]))*(-1)^(2*l)*(1 - z)*z*
      (1 - Conjugate[z])*Conjugate[z]*(-((2^(-5 + 2*DD)*((1 - Sqrt[z])/(1 + Sqrt[z]))^((1/2)*(-2*l + DD))*(1 - z)*
          ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^((1/2)*(-2*l + DD))*(-((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) - 
           Sqrt[z]*(((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) + ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l)) + 
           ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l) + (((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) + 
             Sqrt[z]*(((1 - Sqrt[z])/(1 + Sqrt[z]))^(2*l) - ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l)) + 
             ((1 - Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))^(2*l))*Sqrt[Conjugate[z]])*(1 - Conjugate[z])*
          (Log[16] + Log[-((-1 + Sqrt[z])/(1 + Sqrt[z]))] + Log[-((-1 + Sqrt[Conjugate[z]])/(1 + Sqrt[Conjugate[z]]))]))/
         ((-1 + Sqrt[z])^2*z^(1/4)*(-1 + Sqrt[Conjugate[z]])^2*Conjugate[z]^(1/4))) + (2^(-5 + 2*DD)*((-1 + Sqrt[1 - z])^2/z)^((1/2)*(-2*l + DD))*z*
         ((-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z])^((1/2)*(-2*l + DD))*Conjugate[z]*(-2*z*(-((-2 + 2*Sqrt[1 - z] + z)/z))^(2*l)*
           (-1 + Sqrt[1 - Conjugate[z]]) + Conjugate[z]*(2*(-1 + Sqrt[1 - z])*(-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^(2*l) + 
            z*(-(-((-2 + 2*Sqrt[1 - z] + z)/z))^(2*l) + (-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^(2*l))))*
         (Log[16] + Log[(-1 + Sqrt[1 - z])^2/z] + Log[(-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z]]))/((-1 + Sqrt[1 - z])^3*(1 - z)^(1/4)*
         (-1 + Sqrt[1 - Conjugate[z]])^3*(1 - Conjugate[z])^(1/4))); 
	 ConformalBlockAnaDer[DD_, l_, z_] := 
     -((I*(-1)^l*2^(-6 - l + 2*DD)*((-1 + Sqrt[1 - z])^2/z)^((1/2)*(-l + DD))*Abs[z]^4*((-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z])^
         ((1/2)*(-l + DD))*(2*z*(-1 + Sqrt[1 - Conjugate[z]])*(-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^l + 
         Conjugate[z]*(-2*(-1 + Sqrt[1 - z])*(-((-2 + 2*Sqrt[1 - z] + z)/z))^l + z*(-(-((-2 + 2*Sqrt[1 - z] + z)/z))^l + 
             (-((-2 + 2*Sqrt[1 - Conjugate[z]] + Conjugate[z])/Conjugate[z]))^l)))*(Log[(16*(-1 + Sqrt[1 - z])^2)/z] + 
         Log[(-1 + Sqrt[1 - Conjugate[z]])^2/Conjugate[z]]))/((-1 + Sqrt[1 - z])^3*(1 - z)^(1/4)*(-1 + Sqrt[1 - Conjugate[z]])^3*
        (1 - Conjugate[z])^(1/4)*Im[z])); 
	kfunct[\[Beta]_, x_] := kfunct[\[Beta], x] = x^(\[Beta]/2)*Hypergeometric2F1[\[Beta]/2, \[Beta]/2, \[Beta], x]; 
    ConformalBlock[DD_, l_, z_] := ((-1)^l/2^l)*((z*Conjugate[z])/(z - Conjugate[z]))*(kfunct[DD + l, z]*kfunct[DD - l - 2, Conjugate[z]] - 
       kfunct[DD + l, Conjugate[z]]*kfunct[DD - l - 2, z]); 
      
      (*random sample of z around (1/2+I0)*)
           Sample[nz_,var_,seed_] := Module[{imax}, SeedRandom[seed];Table[Abs[RandomVariate[NormalDistribution[0, var]]]+
           1/2+I Abs[RandomVariate[NormalDistribution[0, var]]],{imax,1,nz}]]; 
qQGen[\[CapitalDelta]\[Phi]_,\[CapitalDelta]_,L_,zsample_]:=(((1 - zsample)*(1 - Conjugate[zsample]))^\[CapitalDelta]\[Phi]    ConformalBlock[\[CapitalDelta], L , zsample]- ((zsample)*( Conjugate[zsample]))^\[CapitalDelta]\[Phi] ConformalBlock[\[CapitalDelta], L,1- zsample])2^(L);qQGenDims[\[CapitalDelta]\[Phi]_,\[CapitalDelta]L_,z_]:=qQGen[1,#1[[1]],#1[[2]], z]&/@\[CapitalDelta]L


(* ::Input::Initialization:: *)
MetroGoFixedSelectiveDir[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,Ndit_,prec_,betad_,seed_,sigmaMC_,dcross_,lmax_,idTag_,initialOps_]:=Block[{itd, DDldata, sigmaz, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, Nz, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    IdsampleEx,zOPE,QQOPE,Calc,coeffTemp,Ident,OPEcoeff,ActionTot,  TotD ,DDldataold,QQold,\[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L,dw,smearedaction}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
    Nz=Length[\[CapitalDelta]LOriginal]+1;
  zsample = Sample[Nz,1/100,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
     
    (*Monte Carlo Iteration*)
TotD =   Reap[ Do[
$MinPrecision=prec;
          \[CapitalDelta]LOld=\[CapitalDelta]L;
          QQold=QQ0;  

(*let every successive run start by varying only the new operator*)
        If[it<Ndit/10&& Nz!=initialOps+1,dimToVary=Nz-1,  dimToVary = RandomInteger[{1,lmax}]];
       (*Shift one dimension by a random amount*)       
          \[CapitalDelta]L[[dimToVary,1]] = \[CapitalDelta]L[[dimToVary,1]]+ RandomVariate[NormalDistribution[0, sigmaMC]];
(*Reevaluate coefficients*)
           QQ0[[dimToVary]] = qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]],\[CapitalDelta]L[[dimToVary]][[2]],zsample];
          
    (*Coefficients for LES and action thence*)
          PP = Join[QQ0, {Idsample}]; 
          Actionnew = Log[Det[PP]^2]; 
QQsave=QQ0;
(*Brot noch schmieren? *)
smearedaction=Reap[Table[
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]+dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];
           QQ0[[dimToVary]] =qQGen[\[CapitalDelta]\[Phi],\[CapitalDelta]L[[dimToVary]][[1]]-dcross,\[CapitalDelta]L[[dimToVary]][[2]],zsample];  PP = Join[QQ0, {Idsample}]; 
          Sow[ Log[Det[PP]^2]];QQ0=QQsave;,{dimToVary,1,lmax}]];

 Actionnew =Actionnew +Total[smearedaction[[2]]//Flatten] ;
         

          metcheck = Exp[(-betad)*(Actionnew - Action)];
          rr = RandomReal[{0, 1}];
          If[metcheck>rr, Action = Actionnew,\[CapitalDelta]L=\[CapitalDelta]LOld;QQ0=QQold];
          
$MinPrecision=10;
   dw=\[CapitalDelta]L[[All,1]];
          Sow[ {it, dw, N[Action,10]}],
     {it, 1, Ndit}]]; 
$MinPrecision=3;
      Export["Res-fixed_Param_Nit="<>ToString[Ndit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[betad,3]]<>"sigmaMC="<>ToString[N[sigmaMC,3]]<>"dcross="<>ToString[N[dcross,3]]<>"seed="<>ToString[seed]<>"id="<>idTag<>".txt", TotD[[2]]];]

weightedLeastSquares[qq0_,id_,w_]:=Block[{rhovec,nu,s,r},
rhovec=Inverse[Transpose[qq0].w.qq0].Transpose[qq0] . w.id;
nu = Dimensions[w][[1]]-Length[rhovec];
r=(qq0.rhovec-id);
s=r.w.r;
Return[{rhovec,(Diagonal[Inverse[Transpose[qq0].w.qq0]])^(-1/2),r, s/nu}]];



(* ::Input::Initialization:: *)
metroReturnAvg[prec_,nit_,\[Beta]_,\[CapitalDelta]L_,seed_,initialOps_]:=Block[{data},
MetroGoFixedSelectiveDir[1,\[CapitalDelta]L,nit,prec,\[Beta],seed,1/10,1/3,Length[\[CapitalDelta]L],ToString[Length[\[CapitalDelta]L]],initialOps];
data= Get["Res-fixed_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[1/10,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"id="<>ToString[Length[\[CapitalDelta]L]]<>".txt"];
Export["Plot-fixed_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[1/10,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"id="<>ToString[Length[\[CapitalDelta]L]]<>".pdf",ListPlot[Table[data[[All,2]][[All,i]],{i,1,Length[\[CapitalDelta]L]}],Joined->True,GridLines->Automatic,PlotStyle->Thin,PlotLabel->ToString[Length[\[CapitalDelta]L]]<>"Nit="<>ToString[nit]<>" prec="<>ToString[prec]<>" beta="<>ToString[N[\[Beta],3]]<>" sigmaMC="<>ToString[N[1/10,3]]<>" dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]]];
Export["zoom-Plot-fixed_Param_Nit="<>ToString[nit]<>"prec="<>ToString[prec]<>"beta="<>ToString[N[\[Beta],3]]<>"sigmaMC="<>ToString[N[1/10,3]]<>"dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]<>"id="<>ToString[Length[\[CapitalDelta]L]]<>".pdf",ListPlot[Table[data[[All,2]][[All,i]]-2i+1,{i,1,Length[\[CapitalDelta]L]}],Joined->True,GridLines->Automatic,PlotStyle->Thin,PlotRange->{{0,nit},{0,2}},PlotLabel->ToString[Length[\[CapitalDelta]L]]<>"Nit="<>ToString[nit]<>" prec="<>ToString[prec]<>" beta="<>ToString[N[\[Beta],3]]<>" sigmaMC="<>ToString[N[1/10,3]]<>" dcross="<>ToString[N[1/3,3]]<>"seed="<>ToString[seed]]];
{Mean[data[[All,2]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]],StandardDeviation[data[[All,2]][[nit-100;;nit,1;;Length[\[CapitalDelta]L]]]]}]



checkMetroWeighted[\[CapitalDelta]\[Phi]_,\[CapitalDelta]LOriginal_,prec_,seed_,Nz_]:=Block[{itd, DDldata, sigmaz, sigmaD, Action=100000000, Actionnew=0, Action0, DDldatafixed, QQ0, QQ1, str, Lmax, Nvmax, rr, metcheck, sigmaDini, 
    zsample, Idsample, PP0, PP1, lr, nr, Errvect, Factor, Factor0, ppm, DDldataEx, PPEx, QQEx, Idsampleold, ip, nvmax, QQFold,  
    \[CapitalDelta]LOld,dimToVary,PP,QQsave,\[CapitalDelta]L=\[CapitalDelta]LOriginal,dw,smearedaction,\[Rho],rhovec,eqs,rhosol,last,check,results,indices,rhopos,meanrho,sigmarho,finalcheck,errSample}, 
    (*precision*)
SetOptions[{RandomReal,RandomVariate,NSolve},WorkingPrecision->prec];
$MaxPrecision=prec;
$MinPrecision=prec;

    SeedRandom[seed];
  zsample = Sample[Nz,1/100,seed]; 
Idsample = SetPrecision[Table[(zsample[[zv]]*Conjugate[zsample[[zv]]])^\[CapitalDelta]\[Phi] -
        ((1 - zsample[[zv]])*(1 - Conjugate[zsample[[zv]]]))^\[CapitalDelta]\[Phi], {zv, 1, Nz}],prec];
    \[CapitalDelta]L = \[CapitalDelta]LOriginal;
  \[CapitalDelta]L[[All,1]] = SetPrecision[\[CapitalDelta]L[[All,1]],prec];
  

    QQ0 = qQGenDims[\[CapitalDelta]\[Phi],\[CapitalDelta]L,zsample];
errSample=Table[ \[Rho]intErrorEstimateFt[\[CapitalDelta]\[Phi],\[CapitalDelta]LOriginal[[-1,1]],zsample[[i]],1],{i,1,Nz}];
results=weightedLeastSquares[(QQ0//Transpose)/errSample,Idsample/errSample,IdentityMatrix[Nz]];
finalcheck=Abs[results[[1]].QQ0-Idsample]<errSample//Thread;
Return[{results,And@@finalcheck}];
]
mcIterator[initialOps_,finalOps_,\[CapitalDelta]Linitial_,\[Beta]_,nz_,prec_,seed_,nits_,runid_]:=Block[{\[CapitalDelta]L=\[CapitalDelta]Linitial,results},
results=Reap[Table[\[CapitalDelta]L[[1;;it,1]]=Sow[metroReturnAvg[prec,nits[[it]],\[Beta][[it]],\[CapitalDelta]L[[1;;it]],seed,initialOps]][[1]];
Sow[checkMetroWeighted[1,\[CapitalDelta]L[[1;;it]],prec,seed,nz]]
,{it,initialOps,finalOps}]];
Export["averages_n_checks"<>"from"<>ToString[initialOps]<>"to"<>ToString[finalOps]<>runid<>"prec="<>ToString[prec]<>"seed="<>ToString[seed]<>".txt", results];
]



(* ::Code:: *)
(**)
(*\[Beta]vec={1/7,1/9,1/10,1/11,1/12,1/13};*)
(*nvec={3000,2000,2000,2000,2000,2000};*)
(*\[CapitalDelta]Linitial={#+1,#-2}&/@Range[2,18,2];*)
(*ParallelTable[mcIterator[4,5,\[CapitalDelta]Linitial,\[Beta]vec,1000,88,seed,nvec,"first_test"],{seed,1,10}];*)


mc=ListPlot[dimensions//Transpose];
ref=Plot[{2,4,6,8},{x,0,5},PlotStyle->Dashed];
Show[mc,ref]


Needs["ErrorBarPlots`"]
opes=Transpose/@{check1[[1,{1,2},1;;2]],check2[[1,{1,2},1;;2]],check3[[1,{1,2},1;;2]],check4[[1,{1,2},1;;2]],check5[[1,{1,2},1;;2]]}
opes[[;;,;;,2]]=4opes[[;;,;;,2]];
mc=ErrorListPlot[opes//Transpose];
ref=Plot[{2,1/3},{x,0,5},PlotStyle->Dashed];
Show[mc,ref]





(* ::Input:: *)
(*prec=88;*)
(*seed=66;*)
(*deltares0={{3,0},{5,2},{7,4}}*)
(*check0=checkMetroWeighted[1,deltares0,prec,seed,1000];*)
(*deltares1=metroReturnAvg[prec,2000,1/8,Join[deltares0,{{9,6}}],seed];*)
(*check1=checkMetroWeighted[1,deltares1,prec,seed,1000];*)
(*deltares2=metroReturnAvg[prec,3000,1/9,Join[deltares1,{{11,8}}],seed];*)
(*check2=checkMetroWeighted[1,deltares2,prec,seed,1000];*)
(*deltares3=metroReturnAvg[prec,4000,1/10,Join[deltares2,{{13,10}}],seed];*)
(*check3=checkMetroWeighted[1,deltares3,prec,seed,1000];*)
(*deltares4=metroReturnAvg[prec,5000,1/11,Join[deltares3,{{15,12}}],seed];*)
(*check4=checkMetroWeighted[1,deltares4,prec,seed,1000];*)
(*deltares5=metroReturnAvg[prec,4000,1/12,Join[deltares4,{{17,14}}],seed];*)
(*check5=checkMetroWeighted[1,deltares5,prec,seed,1000];*)
(**)


Reap[Sow[(Sow[x+2])^2]]
