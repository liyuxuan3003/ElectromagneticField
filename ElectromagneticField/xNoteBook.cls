\ProvidesClass{xNoteBook}

\let\xtitle=\@title
\let\xauthor=\@author
\let\xdate=\@date

%基于ctexbook改造的文档类型
\LoadClass[a4paper,openany,oneside,sub4section,heading=true,draft]{ctexbook}
\RequirePackage{xeCJKfntef}

%引入超链接
\PassOptionsToPackage{hyphens}{url}
\RequirePackage[hidelinks]{hyperref}
\hypersetup{bookmarksnumbered=true}
\hypersetup{pdftitle=\xtitle}
\hypersetup{pdfauthor=\xauthor}

\RequirePackage{tocbibind}

%设置文档页面布局
\RequirePackage{geometry}

%设置文档页眉页脚
\RequirePackage{fancyhdr}

%定制文档字体
\RequirePackage{fontspec}

%定制文档标题
\RequirePackage{titlesec}

%处理附录事宜
\RequirePackage{apptools}

%定制文档脚注
\RequirePackage[multiple,perpage]{footmisc}

%--------------------------------%

%设定页面边距
\geometry{left=3cm,right=3cm,top=3cm,bottom=3cm}

%设定西文字体
\setmonofont{Consolas}

%设定中文字体
\setCJKmainfont[AutoFakeSlant=0.25]{Noto Serif CJK SC}      %谷歌衬线字体
\setCJKsansfont[AutoFakeSlant=0.25]{Noto Sans CJK SC}       %谷歌无衬线字体
\setCJKmonofont[AutoFakeBold,AutoFakeSlant=0.25]{FangSong}  %仿宋字体

%设定页眉页脚格式
\pagestyle{fancy}
\fancyhf{}
\lhead{\sffamily\leftmark}      %页眉左侧显示章名
\rhead{\sffamily\rightmark}     %页眉右侧显示节名
\lfoot{\small\LaTeXnotebook}    %页脚左侧显示徽标
\rfoot{--\thepage--}            %页脚右侧显示页码
\renewcommand{\headrulewidth}{0.4pt}    %设定页眉横线的粗细
\setlength{\headheight}{13pt}           %设定页眉区域的高度

\fancypagestyle{plain}          %特殊页面的页眉页脚设置
{                               %适用于目录和章首第一页等位置
    \fancyhf{}
    \renewcommand{\headrulewidth}{0.0pt}
    \cfoot{--\thepage--}
}

%设定取消段落缩进
\setlength{\parindent}{0em}

%设定取消脚注缩进
\setlength{\footnotemargin}{0em}

%设定页面底部对齐
\flushbottom

%设定前言部分格式
\let\frontmatterold=\frontmatter
\renewcommand\frontmatter
{
    \frontmatterold
    \setlength{\parskip}{1pt}   %段落间距为1pt
    \pagenumbering{Roman}       %使用罗马数字表示页码
}

\let\mainmatterold=\mainmatter
\renewcommand\mainmatter
{
    \mainmatterold
    \setlength{\parskip}{6pt}   %段落间距为6pt
    \pagenumbering{arabic}      %使用阿拉伯数字表示页码
}

%设定标题编号至subparagraph
\setcounter{secnumdepth}{5}

%设定目录读取至subsubsection
\setcounter{tocdepth}{3}

%设定part格式
\titleformat{\part}[display]
{\raggedright\bfseries\fontsize{40}{60}}
{\Huge 第\chinese{part}部分\mdseries\hfill\dag\arabic{part}}
{0em}{\vspace{1ex}\titlerule\vspace{2ex}}
\let\partold=\part
\renewcommand{\part}[1]{\partold{#1}\label{part:#1}}

%设定chapter格式
%这里需要使用宏包apptools的IfAppendix特殊处理附录的情况
\titleformat{\chapter}[block]
{\centering\bfseries\Huge}
{\IfAppendix{\appendixname\thechapter}{第\chinese{chapter}章}}
{1em}{}
\let\chapterold=\chapter
\RenewDocumentCommand{\chapter}{sO{#3}m}%
{%
    \IfBooleanTF{#1}%
    {\chapterold*{#3}}%
    {\chapterold[#2]{#3}}%
    \label{chap:#2}%
}%

%设定section格式
\titleformat{\section}[block]
{\centering\bfseries\LARGE}
{\thesection}
{1em}{}
\let\sectionold=\section
\RenewDocumentCommand{\section}{sO{#3}m}%
{%
    \IfBooleanTF{#1}%
    {\sectionold*{#3}}%
    {\sectionold[#2]{#3}}%
    \label{sec:#2}%
}%

%设定subsection格式
\titleformat{\subsection}[hang]
{\bfseries\Large}
{\thesubsection}
{1em}{}
\let\subsectionold=\subsection
\RenewDocumentCommand{\subsection}{sO{#3}m}%
{%
    \IfBooleanTF{#1}%
    {\subsectionold*{#3}}%
    {\subsectionold[#2]{#3}}%
    \label{subsec:#2}%
}%

%设定subsubsection格式
\titleformat{\subsubsection}[hang]
{\bfseries\large}
{\thesubsubsection}
{1em}{}

%设定paragraph格式
\renewcommand\theparagraph{\arabic{paragraph}}
\titleformat{\paragraph}[hang]
{\bfseries}
{\large\theparagraph.\normalsize}
{0.2em}{}

%设定subparagraph格式
\renewcommand\thesubparagraph{\theparagraph.\arabic{subparagraph}}
\titleformat{\subparagraph}[runin]
{\bfseries}
{}
{0.0em}{}[]
\titlespacing*{\subparagraph}{0pt}{0pt}{1em}

%预先重定义章节层次标签在引用时的格式
\newcommand{\xreftextpart}[1]{第\ref*{part:#1}部分}
\newcommand{\xreftextchap}[1]{第\ref*{chap:#1}章}
\newcommand{\xreftextsec}[1]{第\CJKsetecglue{}\ref*{sec:#1}节}
\newcommand{\xreftextsubsec}[1]{第\CJKsetecglue{}\ref*{subsec:#1}小节}

%预先重定义页码引用的格式
\newcommand{\xreftextpage}[1]{第\CJKsetecglue{}\pageref*{#1}页}

%定义"LaTeX NoteBook"的徽标和显示徽标页的命令
\newcommand{\LaTeXnotebook}{\LaTeX~\textsc{NoteBook}}
\newcommand{\makesymb}
{
    \thispagestyle{empty}
    \vspace*{\stretch{0.6}}
    \begin{center}
        \Huge
        \LaTeXnotebook
    \end{center}
    \vspace*{\stretch{1.0}}
    \newpage
    \addtocounter{page}{-1}
}