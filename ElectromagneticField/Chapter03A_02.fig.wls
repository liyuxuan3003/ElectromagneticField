#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]

Needs["MaTeX`"];
SetDirectory[NotebookDirectory[]];

nbFileName="Chapter03A_02.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]

EFieldPhi[q_,p_,r_] :=Sum[ q[[i]]/Norm[r-p[[i]]], {i,Length[q]}]
EField[q_,p_,r_] :=Sum[ (q[[i]] (r-p[[i]]))/Norm[r-p[[i]]]^3, {i,Length[q]}]

Phi1[x_,y_]:=Evaluate[EFieldPhi[{-1,1},{{-1,0},{1,0}},{x,y}]]
E1[x_,y_]:=Evaluate[EField[{-1,1},{{-1,0},{1,0}},{x,y}]]
fig1=Show[
ContourPlot[Phi1[x,y],{x,-4,4},{y,-4,4},
Contours->Table[i,{i,-1,1,0.1}],
ClippingStyle->Automatic,
PlotRange->{-1,1},
ColorFunction->ColorData[{"RedBlueTones","Reverse"}]],
StreamPlot[E1[x,y],{x,-4,4},{y,-4,4},
StreamStyle->White,StreamColorFunction->None],
Graphics[{Blue,Disk[{-1,0},{0.4,0.4}]}],
Graphics[{White,Circle[{-1,0},{0.4,0.4}],Text[MaTeX["{\\color{white} -}", "Preamble"->{"\\usepackage{color}"}],{-1,0}]}],
Graphics[{Red,Disk[{+1,0},{0.4,0.4}]}],
Graphics[{White,Circle[{+1,0},{0.4,0.4}],Text[MaTeX["{\\color{white} +}", "Preamble"->{"\\usepackage{color}"}],{+1,0}]}]
]

Phi2[x_,y_]:=Evaluate[EFieldPhi[{1,1},{{-1,0},{1,0}},{x,y}]]
E2[x_,y_]:=Evaluate[EField[{1,1},{{-1,0},{1,0}},{x,y}]]
fig2=Show[
ContourPlot[Phi2[x,y],{x,-4,4},{y,-4,4},
Contours->Table[i,{i,0,4,0.1}],
PlotRange->{-4,4},
ClippingStyle->Automatic,
ColorFunction->Function[{x},ColorData[{"RedBlueTones","Reverse"}][x/2+0.4]],
ColorFunctionScaling->False],
StreamPlot[E2[x,y],{x,-4,4},{y,-4,4},
StreamStyle->White,StreamColorFunction->None],
Graphics[{Red,Disk[{-1,0},{0.4,0.4}]}],
Graphics[{White,Circle[{-1,0},{0.4,0.4}],Text[MaTeX["{\\color{white} +}", "Preamble"->{"\\usepackage{color}"}],{-1,0}]}],
Graphics[{Red,Disk[{+1,0},{0.4,0.4}]}],
Graphics[{White,Circle[{+1,0},{0.4,0.4}],Text[MaTeX["{\\color{white} +}", "Preamble"->{"\\usepackage{color}"}],{+1,0}]}]
]

fig={fig1,fig2}

figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
