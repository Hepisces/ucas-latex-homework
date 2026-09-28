%%
%% SPDX-License-Identifier: MIT
%%
%% 国科大中文平时作业文档类
%%
%% 题目接口改写自：
%%   Jacob Zimmerman, latex-homework-class, 2014.
%%   https://github.com/jez/latex-homework-class
%%   MIT License. 见仓库根目录 LICENSE。
%%
%% 版式（A4、小四、页边距 2.5cm）与校徽取自：
%%   jweihe, 国科大课程论文模板.
%%   https://github.com/jweihe/UCAS_Latex_Template
%%   Creative Commons Attribution 4.0 International.
%%   校徽文件的许可与改动见仓库根目录 NOTICE。
%%
%% 编译：xelatex
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2026/09/28 UCAS Chinese homework class]

% ----- 选项 -----------------------------------------------------------------
% anonymous：姓名、学号只出现在独立扉页，正文页眉不印姓名
% newpage：每道题从新页开始
% largemargins：页边距宽于默认的 2.5cm，便于批注
% nowatermark：关闭水印。页眉改为双面：偶数页外侧为姓名，奇数页外侧为校徽
\newif\ifhw@anonymous
\newif\ifhw@newpage
\newif\ifhw@largemargins
\newif\ifhw@watermark
\newif\ifhw@customsize
\hw@watermarktrue

\DeclareOption{anonymous}{\hw@anonymoustrue}
\DeclareOption{newpage}{\hw@newpagetrue}
\DeclareOption{largemargins}{\hw@largemarginstrue}
\DeclareOption{nowatermark}{\hw@watermarkfalse}
\DeclareOption{10pt}{\hw@customsizetrue\PassOptionsToClass{10pt}{ctexart}}
\DeclareOption{11pt}{\hw@customsizetrue\PassOptionsToClass{11pt}{ctexart}}
\DeclareOption{12pt}{\hw@customsizetrue\PassOptionsToClass{12pt}{ctexart}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

% 关闭水印时启用 twoside，奇偶页页眉才能分开。
\ifhw@watermark
  \ifhw@customsize
    \LoadClass[a4paper,UTF8]{ctexart}
  \else
    \LoadClass[a4paper,UTF8,zihao=-4]{ctexart}
  \fi
\else
  \ifhw@customsize
    \LoadClass[a4paper,twoside,UTF8]{ctexart}
  \else
    \LoadClass[a4paper,twoside,UTF8,zihao=-4]{ctexart}
  \fi
\fi

% ----- 西文字体 -------------------------------------------------------------
% 中文走 ctex 当前字体集（macOS 上为宋体、黑体、楷体、仿宋）。
% 西文按大作业模板的说明使用 Times New Roman，缺失时退回 TeX Gyre Termes。
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}[Ligatures=TeX]%
}{%
  \IfFontExistsTF{TeX Gyre Termes}{%
    \setmainfont{TeX Gyre Termes}[Ligatures=TeX]%
  }{}%
}
\IfFontExistsTF{Menlo}{%
  \setmonofont{Menlo}[Scale=MatchLowercase]%
}{%
  \IfFontExistsTF{DejaVu Sans Mono}{%
    \setmonofont{DejaVu Sans Mono}[Scale=MatchLowercase]%
  }{}%
}
% 新版 macOS 不再提供 PingFang，ctex 会退回没有粗体的 STHeiti。
% 若系统里有宋体-简和黑体-简，改用它们，使 \bfseries\heiti 真正加粗。
\IfFontExistsTF{Songti SC}{%
  \setCJKmainfont{Songti SC}[
    UprightFont=* Regular,
    BoldFont=* Bold,
    ItalicFont=* Regular
  ]%
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont=* Regular,
    BoldFont=* Bold
  ]%
}{}
\IfFontExistsTF{Heiti SC}{%
  \setCJKsansfont{Heiti SC}[
    UprightFont=* Light,
    BoldFont=* Medium
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont=* Light,
    BoldFont=* Medium
  ]%
}{}

% ----- 页面 -----------------------------------------------------------------
% 页眉放校徽时需要更高的页眉框。
\newcommand{\hw@headheight}{18pt}
\ifhw@watermark\else
  \renewcommand{\hw@headheight}{24pt}
\fi
\ifhw@largemargins
  \RequirePackage[
    a4paper,
    left=3.50cm,
    right=3.50cm,
    top=3.20cm,
    bottom=3.20cm,
    headheight=\hw@headheight,
    headsep=14pt,
    footskip=32pt
  ]{geometry}
\else
  \RequirePackage[
    a4paper,
    left=2.50cm,
    right=2.50cm,
    top=2.50cm,
    bottom=2.50cm,
    headheight=\hw@headheight,
    headsep=12pt,
    footskip=30pt
  ]{geometry}
\fi
\raggedbottom

% ----- 宏包 -----------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{ucasblue}{RGB}{10,74,148}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{centernot}
\RequirePackage{mathtools}

\RequirePackage{enumitem}
\RequirePackage{graphicx}
\graphicspath{{figures/}{./}}
\RequirePackage{wrapfig}
\RequirePackage{booktabs}
\RequirePackage{fancyvrb}
\RequirePackage{listings}
\RequirePackage{tcolorbox}
\RequirePackage{eso-pic}
\RequirePackage{tikz}
\RequirePackage{fancyhdr}
\RequirePackage{natbib}
\bibliographystyle{acl_natbib}
\RequirePackage[
  unicode=true,
  colorlinks=true,
  linkcolor=ucasblue,
  urlcolor=ucasblue,
  citecolor=ucasblue,
  bookmarksnumbered=true
]{hyperref}

% ----- 用户信息 -------------------------------------------------------------
% 下列命令都在导言区用 \newcommand 或 \renewcommand 赋值。
% \hwname       姓名。关闭水印时出现在偶数页页眉外侧
% \hwid         学号
% \hwemail      邮箱，留空则不显示
% \hwclass      课程名
% \hwtype       作业类型，如「作业」「测验」
% \hwnum        作业序号
% \hwdate       日期，默认 \today
% \questiontype    编号题目前缀，默认「题目」
% \writtensection  题号前的章节号；0 表示不添加
% \hwlogofile       文首校徽
% \hwwatermarkfile  水印校徽。XeLaTeX 插入图片时不继承绘图透明度，
%                   因此该文件本身已是淡化后的校徽
% \hwmarktext       附加斜向文字，默认空。非空时叠在校徽水印上
% \hwtextopacity    附加文字的不透明度，0 到 1
% \hwtextrotation   水印旋转角度
\newcommand{\hwlogofile}{ucas_logo.pdf}
\newcommand{\hwwatermarkfile}{ucas_watermark.png}
\newcommand{\hwmarktext}{}
\newcommand{\hwtextopacity}{0.08}
\newcommand{\hwtextrotation}{22}
\newcommand{\questiontype}{题目}
\newcommand{\writtensection}{0}

\newcommand{\hw@provide@meta}{%
  \providecommand{\hwname}{姓名}%
  \providecommand{\hwid}{}%
  \providecommand{\hwemail}{}%
  \providecommand{\hwclass}{课程}%
  \providecommand{\hwtype}{作业}%
  \providecommand{\hwnum}{1}%
  \providecommand{\hwdate}{\today}%
}

% ----- 水印 -----------------------------------------------------------------
% 每页背景使用已淡化的校徽。nowatermark 选项关闭。
% \hwmarktext 非空时，再叠一行同角度的斜向文字。
\newcommand{\hw@paintwatermark}{%
  \ifhw@watermark
    \AtPageCenter{%
      \makebox(0,0){%
        \rotatebox{\hwtextrotation}{%
          \includegraphics[width=0.64\paperwidth]{\hwwatermarkfile}%
        }%
      }%
    }%
    \ifx\hwmarktext\@empty\else
      \AtPageCenter{%
        \makebox(0,0){%
          \begin{tikzpicture}[overlay]
            \node[
              text=ucasblue,
              opacity=\hwtextopacity,
              rotate=\hwtextrotation,
              inner sep=0pt
            ] {\fontsize{32}{38}\selectfont\heiti\hwmarktext};
          \end{tikzpicture}%
        }%
      }%
    \fi
  \fi
}
\AddToShipoutPictureBG{\hw@paintwatermark}

% ----- 页眉页脚 -------------------------------------------------------------
% 页眉文字只有「课程 · 作业序号」。
% 水印打开时单面，页眉仅此一项。
% 水印关闭时双面：偶数页外侧为姓名，奇数页外侧为校徽，内侧为上述文字。
\newcommand{\hw@runninghead}{\hwclass\ · \hwtype\ \hwnum}
\newcommand{\hw@headerlogo}{%
  \includegraphics[height=12pt]{\hwlogofile}%
}

\renewcommand{\headrule}{%
  \ifdim\headrulewidth=0pt
  \else
    {\color{ucasblue}\hrule width\headwidth height\headrulewidth\relax}%
  \fi
}

\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}

\newcommand{\hw@install@page}{%
  \pagestyle{fancy}%
  \fancyhf{}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0.55pt}%
  \ifhw@watermark
    \fancyhead[L]{\small\fangsong\hw@runninghead}%
  \else
    \fancyhead[RE]{\small\fangsong\hw@runninghead}%
    \fancyhead[LO]{\small\fangsong\hw@runninghead}%
    \fancyhead[RO]{\hw@headerlogo}%
    \ifhw@anonymous\else
      \fancyhead[LE]{\small\fangsong\hwname}%
    \fi
  \fi
  \ifhw@anonymous
    \hypersetup{pdftitle={\hwclass\ \hwtype\ \hwnum}, pdfauthor={}}%
  \else
    \hypersetup{
      pdftitle={\hwclass\ \hwtype\ \hwnum},
      pdfauthor={\hwname}%
    }%
  \fi
}

% ----- 文首 -----------------------------------------------------------------
% \maketitle 输出校徽、课程、作业序号、姓名、学号和日期。文首校徽不随水印开关变化。
% anonymous 时上述信息单独成页，其后的正文页不再出现姓名。
\renewcommand{\maketitle}{%
  \begin{center}
    \includegraphics[width=0.50\textwidth]{\hwlogofile}\par
    \vspace{1.05em}
    {\LARGE\heiti \hwclass\par}
    \vspace{0.45em}
    {\Large\heiti \hwtype\ \hwnum\par}
    \vspace{0.85em}
    {\large\kaishu
      姓名\quad\hwname\qquad
      学号\quad\hwid%
      \ifx\hwemail\@empty\else\qquad \hwemail\fi
      \par}
    \vspace{0.45em}
    {\normalsize \hwdate\par}
  \end{center}
  \vspace{0.15em}
  \ifhw@anonymous
    \thispagestyle{empty}%
    \clearpage
  \else
    \thispagestyle{plain}%
  \fi
}

% ----- 题目 -----------------------------------------------------------------
% \question           自动编号，形式为「题目 n」或「题目 <writtensection>.n」
% \question*{标题}    带名称的题目，仍占用题号，形式为「n. 标题」
% 题号计数器为 questionCounter。跳号时先 \setcounter{questionCounter}{目标题号-1}。
\newcounter{questionCounter}
\newcounter{partCounter}[questionCounter]

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.45em plus 0.12em minus 0.08em}

\newcommand{\hw@openquestion}[1]{%
  \ifhw@newpage
    \clearpage
  \fi
  \par\addvspace{0.85em}%
  \refstepcounter{questionCounter}%
  \noindent
  \begin{minipage}{\linewidth}%
    {\bfseries\heiti #1}\par
    \vspace{0.28em}%
    {\color{ucasblue}\hrule height 0.7pt}%
  \end{minipage}%
  \par\nobreak
  \vspace{0.42em}%
  \@afterindentfalse
  \@afterheading
}

\newcommand{\hw@numberedquestion}{%
  \hw@openquestion{%
    \questiontype\ %
    \ifnum\writtensection=0
      \arabic{questionCounter}%
    \else
      \writtensection.\arabic{questionCounter}%
    \fi
  }%
}

\NewDocumentCommand{\hw@namedquestion}{m}{%
  \hw@openquestion{\arabic{questionCounter}.\ #1}%
}

\NewDocumentCommand{\question}{s}{%
  \IfBooleanTF{#1}{\hw@namedquestion}{\hw@numberedquestion}%
}

% 与上游类一致：\section 开始一道编号题，\section*{标题} 开始一道命名题。
% \subsection 及以下仍是 ctex 标题，不改作题目。
\newcommand{\hw@install@section}{%
  \RenewDocumentCommand{\section}{s}{%
    \IfBooleanTF{##1}{\hw@namedquestion}{\hw@numberedquestion}%
  }%
}

% ----- 小问 -----------------------------------------------------------------
% \begin{alphaparts} ... \questionpart ... \end{alphaparts}
%   小问标记为 (a) (b) (c)。同一题内多次使用时连续编号。
% \begin{arabicparts} ... \questionpart ... \end{arabicparts}
%   小问标记为「题号.序号」，例如 2.1、2.2。
% \questionpart 后直接写该小问的解答。
\newenvironment{alphaparts}{%
  \begin{enumerate}[
    label=\textbf{(\alph*)},
    ref=(\alph*),
    start=\numexpr\value{partCounter}+1\relax,
    leftmargin=2.5em,
    itemsep=0.35em,
    topsep=0.45em,
    parsep=0pt
  ]%
}{%
  \setcounter{partCounter}{\value{enumi}}%
  \end{enumerate}%
}

\newenvironment{arabicparts}{%
  \begin{enumerate}[
    label=\textbf{\arabic{questionCounter}.\arabic*},
    ref=\arabic{questionCounter}.\arabic*,
    start=\numexpr\value{partCounter}+1\relax,
    leftmargin=2.7em,
    itemsep=0.35em,
    topsep=0.45em,
    parsep=0pt
  ]%
}{%
  \setcounter{partCounter}{\value{enumi}}%
  \end{enumerate}%
}

\newcommand{\questionpart}{\item}

\setlist{itemsep=0.25em, topsep=0.35em, parsep=0pt, partopsep=0pt}

% ----- 归纳证明 -------------------------------------------------------------
% \begin{induction}
%   \basecase  ...
%   \indhyp    ...
%   \indstep   ...
% \end{induction}
\newenvironment{induction}{%
  \begin{description}[
    style=nextline,
    font=\normalfont\bfseries\heiti,
    labelwidth=2.2em,
    leftmargin=3em,
    itemsep=0.5em,
    topsep=0.4em,
    parsep=0pt
  ]%
}{%
  \end{description}%
}
\newcommand{\basecase}{\item[基础情形]}
\newcommand{\indhyp}{\item[归纳假设]}
\newcommand{\indstep}{\item[归纳步骤]}

% ----- 作答区与提示框 -------------------------------------------------------
% \answerbox{高度}  留出给定高度的空白作答框，高度为 TeX 长度，如 4cm
% \tbox{内容}       圆角浅灰提示框，宽度为版心
\newcommand{\answerbox}[1]{%
  \begin{tcolorbox}[
    colback=gray!6,
    colframe=black!55,
    arc=1mm,
    boxrule=0.45pt,
    height=#1,
    valign=center,
    left=1.6mm,
    right=1.6mm,
    top=1mm,
    bottom=1mm,
    before skip=0.55em,
    after skip=0.55em
  ]
  \end{tcolorbox}%
}

\newcommand{\tbox}[1]{%
  \begin{tcolorbox}[
    colback=gray!8,
    colframe=black!65,
    arc=1mm,
    boxrule=0.45pt,
    left=2mm,
    right=2mm,
    top=1.4mm,
    bottom=1.4mm,
    before skip=0.55em,
    after skip=0.55em
  ]
  \raggedright #1
  \end{tcolorbox}%
}

% ----- 三线表 ---------------------------------------------------------------
% 题目中的表用 threetab，不进入浮动体，因此不会漂到别的题。
% 参数是列格式，不要加竖线。表头一行之后写 \midrule。
% \begin{threetab}{lr}
%   词项 & 文档频率 \\
%   \midrule
%   dragon & 66000 \\
% \end{threetab}
\newenvironment{threetab}[1]{%
  \par\addvspace{0.45em}%
  \noindent\begin{minipage}{\linewidth}%
  \centering
  \begin{tabular}{@{}#1@{}}%
    \toprule
}{%
    \bottomrule
  \end{tabular}%
  \end{minipage}%
  \par\addvspace{0.45em}%
}

% ----- 代码 -----------------------------------------------------------------
\lstdefinestyle{hw}{
  basicstyle=\ttfamily\small,
  keywordstyle=\bfseries,
  commentstyle=\itshape\color{black!55},
  stringstyle=\color{ucasblue!80!black},
  numbers=left,
  numberstyle=\scriptsize\color{black!45},
  numbersep=8pt,
  frame=single,
  framerule=0.4pt,
  rulecolor=\color{black!35},
  breaklines=true,
  columns=fullflexible,
  keepspaces=true,
  showstringspaces=false,
  tabsize=4,
  upquote=true,
  xleftmargin=1.7em,
  framexleftmargin=1.5em,
  aboveskip=0.7em,
  belowskip=0.7em
}
\lstset{style=hw}

% ----- 定理 -----------------------------------------------------------------
% 定理类环境按题目编号，例如第 2 题中的第一个定理为「定理 2.1」。
% 环境：theorem、lemma、corollary、proposition、definition、example，以及 proof。
\newtheoremstyle{ucas}
  {0.7em}{0.7em}
  {\normalfont}{0pt}
  {\bfseries\heiti}{}
  {0.65em}{}
\theoremstyle{ucas}
\newtheorem{theorem}{定理}[questionCounter]
\newtheorem{lemma}[theorem]{引理}
\newtheorem{corollary}[theorem]{推论}
\newtheorem{proposition}[theorem]{命题}
\newtheorem{definition}[theorem]{定义}
\newtheorem{example}[theorem]{例}
\renewcommand{\proofname}{证明}

% ----- 交叉引用名称 ---------------------------------------------------------
\def\equationautorefname{式}
\def\figureautorefname{图}
\def\tableautorefname{表}
\def\theoremautorefname{定理}
\def\lemmaautorefname{引理}
\def\definitionautorefname{定义}
\def\sectionautorefname{题目}
\def\subsectionautorefname{小节}

% pandoc 生成的紧凑列表会调用此命令
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}%
}

\AtBeginDocument{%
  \hw@provide@meta
  \hw@install@page
}
\AddToHook{begindocument/end}{\hw@install@section}
\AddToHook{begindocument/end}{\hw@install@bibliography}

% 参考文献标题用中文。本类把 \section 用作题目，因此不能走 \section*。
% 条目版式按 ACL 的 acl_natbib.bst：作者-年，无编号，悬挂缩进。
% 正文用 \citep、\citet；\cite 与 ACL 模板一样等于 \citep。
% 文末写 \bibliography{ref}。没有引用时不必写。
\newcommand{\hw@install@bibliography}{%
  \renewcommand{\refname}{参考文献}%
  \renewcommand{\cite}{\citep}%
  \def\thebibliography##1{%
    \par\addvspace{1.15em}%
    \noindent{\bfseries\heiti\large \refname}\par
    \vspace{0.45em}%
    \list{}{%
      \setlength{\labelwidth}{0pt}%
      \setlength{\leftmargin}{1.6em}%
      \setlength{\itemindent}{-1.6em}%
      \setlength{\itemsep}{0.25em}%
      \setlength{\parsep}{0pt}%
    }%
    \def\newblock{\hskip .11em plus .33em minus -.07em}%
    \sloppy
    \clubpenalty4000\widowpenalty4000
    \sfcode`\.=1000\relax
  }%
  \let\endthebibliography\endlist
}

\endinput
