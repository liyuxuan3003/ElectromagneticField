#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]

SetDirectory[NotebookDirectory[]];

Needs["MaTeX`"];
SetDirectory[NotebookDirectory[]];
Unprotect[MaTeX`Developer`Texify];
MaTeX`Developer`Texify[TextCell[code_,___]]:=ToString[code]

nbFileName="Chapter06A_03.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


F1=Function[{z,t},Piecewise[{{2Sin[z Pi]Sin[t Pi],z<0},{0,z>0}}]];

fig1=Plot3D[
F1[z,t],
{z,-4,1},{t,0,4},
MeshFunctions->{#2&},Mesh->23,MeshStyle->Black,
ColorFunction->(ColorData["ThermometerColors"][#3 ]&),
PlotPoints->200,
ViewPoint->{80,-100,60},
AxesLabel->{MaTeX["kz/\\pi"],MaTeX["\\omega t/\\pi"],MaTeX["\\dfrac{E_{1x}(z,t)}{E_\\text{im}}"]}
]

fig2=Plot[
Evaluate[Table[F1[z,t],{t,0.0,0.5,+0.125}]],
{z,-4,0},
PlotStyle->ColorData[10],
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{MaTeX["z"],MaTeX["\\dfrac{E_{1x}(z,t)}{E_\\text{im}}"],MaTeX["\\vphantom{\\frac{h}{z}}"]},
PlotLegends->{MaTeX["\\omega t=0.000\\pi"],MaTeX["\\omega t=0.125\\pi"],MaTeX["\\omega t=0.250\\pi"],MaTeX["\\omega t=0.375\\pi"],MaTeX["\\omega t=0.500\\pi"]},
PlotRange->{-2.5,2.5},
Frame->True,
GridLines->Automatic
]
 
F2=Function[{z,t},Piecewise[{{2Cos[z Pi]Cos[t Pi],z<0},{0,z>0}}]];

fig3=Plot3D[
F2[z,t],
{z,-4,1},{t,0,4},
MeshFunctions->{#2&},Mesh->23,MeshStyle->Black,
ColorFunction->(ColorData["ThermometerColors"][#3 ]&),
PlotPoints->200,
ViewPoint->{80,-100,60},
AxesLabel->{MaTeX["kz/\\pi"],MaTeX["\\omega t/\\pi"],MaTeX["\\dfrac{H_{1y}(z,t)}{\\eta^{-1}E_\\text{im}}"]}
]

fig4=Plot[
Evaluate[Table[F2[z,t],{t,0.0,0.5,+0.125}]],
{z,-4,0},
PlotStyle->ColorData[10],
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{MaTeX["z"],MaTeX["\\dfrac{H_{1y}(z,t)}{\\eta^{-1}E_\\text{im}}"],MaTeX["\\vphantom{\\frac{h}{z}}"]},
PlotLegends->{MaTeX["\\omega t=0.000\\pi"],MaTeX["\\omega t=0.125\\pi"],MaTeX["\\omega t=0.250\\pi"],MaTeX["\\omega t=0.375\\pi"],MaTeX["\\omega t=0.500\\pi"]},
PlotRange->{-2.5,2.5},
Frame->True,
GridLines->Automatic
]

R=Function[{e1,e2},(e2-e1)/(e2+e1)];
T=Function[{e1,e2},(2e2)/(e2+e1)];
fig5=Plot[
Evaluate[Table[R[e1,e2],{e2,{0.25,0.5,1.0,2.0,4.0}}]],
{e1,0.00,4.0},
Frame->True,
PlotRange->{-1.2,1.2},
GridLines->Automatic,
PlotStyle->ColorData[24],
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{MaTeX["\\eta_1"],MaTeX["R(\\eta_1)"],MaTeX["\\vphantom{\\frac{h}{z}}"]},
PlotLegends->{MaTeX["\\eta_2=0.25"],MaTeX["\\eta_2=0.50"],MaTeX["\\eta_2=1.00"],MaTeX["\\eta_2=2.00"],MaTeX["\\eta_2=4.00"]}]

fig6=Plot[
Evaluate[Table[R[e1,e2],{e1,{0.25,0.5,1.0,2.0,4.0}}]],
{e2,0.00,4.0},
Frame->True,
PlotRange->{-1.2,1.2},
GridLines->Automatic,
PlotStyle->ColorData[24],
BaseStyle->{FontFamily->"Latin Modern Roman",FontSize->8},
FrameLabel->{MaTeX["\\eta_2"],MaTeX["R(\\eta_2)"],MaTeX["\\vphantom{\\frac{h}{z}}"]},
PlotLegends->{MaTeX["\\eta_1=0.25"],MaTeX["\\eta_1=0.50"],MaTeX["\\eta_1=1.00"],MaTeX["\\eta_1=2.00"],MaTeX["\\eta_1=4.00"]}]

fig={fig1,fig2,fig3,fig4,fig5,fig6}

figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
