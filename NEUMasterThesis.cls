%% NEUMasterThesis.cls
%% 东北大学硕士学位论文 LaTeX 模板
%% 依据《东北大学硕士学位论文排版打印格式》(20251230版) 编写
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NEUMasterThesis}[2025/12/30 东北大学硕士学位论文模板]
\LoadClass[UTF8,cs4size,a4paper,twoside,openright]{ctexbook}

%% ============================================================
%% 宏包加载
%% ============================================================
\RequirePackage{pdfpages}        % 插入 PDF 页面
\RequirePackage{setspace}        % 行距控制
\RequirePackage{indentfirst}     % 首段缩进
\RequirePackage{geometry}        % 页面布局
\RequirePackage{fancyhdr}        % 页眉页脚
\RequirePackage{amsmath,amsthm,amssymb,amsfonts} % 数学公式
\RequirePackage{graphicx}        % 插图
\RequirePackage{subfigure}       % 子图
\RequirePackage{float}           % 浮动体控制
\RequirePackage{booktabs}        % 三线表
\RequirePackage{longtable}       % 长表格
\RequirePackage{tabularx}        % 自动宽度表格
\RequirePackage{caption}         % 图表标题
\RequirePackage{tikz}            % 绘图
\RequirePackage{listings}        % 代码排版
\RequirePackage{algorithmicx,algorithm} % 算法排版
\RequirePackage[noend]{algpseudocode}
\RequirePackage{enumitem}        % 列表环境
\RequirePackage{ulem}            % 下划线
\RequirePackage{xcolor}          % 颜色
\RequirePackage[titles,subfigure]{tocloft} % 目录格式
\RequirePackage[numbers,sort&compress,super,square]{natbib} % 参考文献引用
\RequirePackage[draft=false,colorlinks=true,CJKbookmarks=true,
    linkcolor=black,citecolor=black,urlcolor=blue,hyperindex]{hyperref}

%% ============================================================
%% 字体设置
%% ============================================================
\setmainfont{Times New Roman}    % 西文字体
\songti                          % 默认中文宋体

%% ============================================================
%% 页面布局 — 版芯 160mm×247mm（不包括页眉、页脚）
%% A4纸 210×297mm
%% ============================================================
\geometry{
    a4paper,
    left=3cm,
    right=3cm,
    top=2.54cm,
    bottom=2.54cm,
    headheight=14pt,
    headsep=0.55cm,
    footskip=0.79cm
}

%% ============================================================
%% 行距设置 — 正文 22 磅固定行距
%% 重定义 \normalsize：小四号 12bp 字体，基准行距 22bp（= Word 固定值 22 磅）
%% 参考 ustcthesis、thuthesis 的实现方式
%% ============================================================
\newcommand{\neu@bodyfontsize}{12bp}
\newcommand{\neu@bodyleading}{22bp}

% 对外接口：在导言区用 \setbodyleading{30bp} 之类进行调整
\newcommand{\setbodyleading}[1]{\renewcommand{\neu@bodyleading}{#1}}

\renewcommand\normalsize{%
    \@setfontsize\normalsize{\neu@bodyfontsize}{\neu@bodyleading}%
  \abovedisplayskip 6\p@ \@plus2\p@ \@minus2\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 4\p@ \@plus3\p@ \@minus3\p@
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalsize

% 禁止 setspace 对 baselineskip 做二次缩放——
% 行距已由 \@setfontsize 的第三参数精确控制，
% setspace 的 \baselinestretch 只会导致公式、浮动体间距被意外放大
\AtBeginDocument{%
    \linespread{1}\selectfont
}
\setlength{\parskip}{0pt}

% 浮动体（图表）与正文之间的间距
\setlength{\intextsep}{2bp \@plus 2\p@ \@minus 2\p@}
\setlength{\textfloatsep}{2bp \@plus 2\p@ \@minus 2\p@}
\setlength{\floatsep}{2bp \@plus 2\p@ \@minus 2\p@}

%% ============================================================
%% 段落设置 — 首行缩进 2 字符
%% ============================================================
\setlength{\parindent}{2em}

%% ============================================================
%% 章节标题设置
%% 各级标题：单倍行距，段前段后 0.5 行（= 11bp）
%% 第一级(章)：二号黑体，居中
%% 第二级(条)：三号黑体，居左
%% 第三级(款)：四号黑体，居左
%% 第四级(项)：小四号黑体，居左
%% ============================================================

% 第一级：章标题 — 二号黑体，居中，"第1章 XXX"
\ctexset{
    chapter={
        name={第,章},
        number={\arabic{chapter}},
        format={\centering\heiti\zihao{2}},
        aftername={\hspace{0.5em}},
        beforeskip={-5pt},
        afterskip={20bp},
    },
    % 第二级：条标题 — 三号黑体，居左
    section={
        format={\heiti\zihao{3}},
        aftername={\ },
        beforeskip={12bp},
        afterskip={14bp},
    },
    % 第三级：款标题 — 四号黑体，居左
    subsection={
        format={\heiti\zihao{4}},
        aftername={\ },
        beforeskip={10bp},
        afterskip={12bp},
    },
    % 第四级：项标题 — 小四号黑体，居左
    subsubsection={
        format={\heiti\zihao{-4}},
        aftername={\ },
        beforeskip={6bp},
        afterskip={-1bp},
    },
}
\setcounter{secnumdepth}{3}

%% ============================================================
%% 页眉页脚设置
%% 页眉：5号楷体，左端"东北大学硕士学位论文"，右端"章号章题"
%% 页码：阿拉伯数字，页底居中，格式 -N-
%% ============================================================
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\chaptermark}[1]{%
    \ifnum\value{chapter}>0
        \markboth{第\arabic{chapter}章\ #1}{}
    \else
        \markboth{#1}{}
    \fi
}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}{}}

% 默认页面样式
\fancypagestyle{plain}{
    \fancyhf{}
    \fancyfoot[C]{\zihao{-4}-\ \thepage\ -}
    \fancyhead[L]{\kaishu\zihao{5}东北大学硕士学位论文}
    \fancyhead[R]{\kaishu\zihao{5}\leftmark}
}
\pagestyle{plain}

% 摘要页页眉
\fancypagestyle{cabstract}{
    \fancyhf{}
    \fancyfoot[C]{\zihao{-4}-\ \thepage\ -}
    \fancyhead[L]{\kaishu\zihao{5}东北大学硕士学位论文}
    \fancyhead[R]{\kaishu\zihao{5}摘要}
}
\fancypagestyle{eabstract}{
    \fancyhf{}
    \fancyfoot[C]{\zihao{-4}-\ \thepage\ -}
    \fancyhead[L]{\kaishu\zihao{5}东北大学硕士学位论文}
    \fancyhead[R]{\kaishu\zihao{5}Abstract}
}

% 目录页页眉
\fancypagestyle{contents}{
    \fancyhf{}
    \fancyfoot[C]{\zihao{-4}-\ \thepage\ -}
    \fancyhead[L]{\kaishu\zihao{5}东北大学硕士学位论文}
    \fancyhead[R]{\kaishu\zihao{5}目录}
}

% 声明页页眉
\fancypagestyle{declaration}{
    \fancyhf{}
    \fancyfoot[C]{\zihao{-4}-\ \thepage\ -}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

% 空白页（无页眉页脚）
\fancypagestyle{NEUblank}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
}

%% 空白左页的页面样式：
%% 前言部分（扉页、声明、摘要、目录等）：无页眉页脚（NEUblank）
%% 正文及其后各章（致谢、发表论文、简历等）：保留页眉和页码（plain）
\makeatletter
\newif\ifneu@bodymatter
\neu@bodymatterfalse
\let\neu@cleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{%
    \ifneu@bodymatter
        \clearpage{\pagestyle{plain}\neu@cleardoublepage}%
    \else
        \clearpage{\pagestyle{NEUblank}\neu@cleardoublepage}%
    \fi
}

%% ============================================================
%% 扉页信息命令定义
%% ============================================================
\def\ctitle#1{\def\@ctitle{#1}}\def\@ctitle{}
\def\etitle#1{\def\@etitle{#1}}\def\@etitle{}
\def\cauthor#1{\def\@cauthor{#1}}\def\@cauthor{}
\def\eauthor#1{\def\@eauthor{#1}}\def\@eauthor{}
\def\studentid#1{\def\@studentid{#1}}\def\@studentid{}
\def\csupervisor#1{\def\@csupervisor{#1}}\def\@csupervisor{}
\def\esupervisor#1{\def\@esupervisor{#1}}\def\@esupervisor{}
\def\cdepartment#1{\def\@cdepartment{#1}}\def\@cdepartment{}
\def\edepartment#1{\def\@edepartment{#1}}\def\@edepartment{}
\def\cmajor#1{\def\@cmajor{#1}}\def\@cmajor{}
\def\emajor#1{\def\@emajor{#1}}\def\@emajor{}
\def\cdate#1{\def\@cdate{#1}}\def\@cdate{}
\def\edate#1{\def\@edate{#1}}\def\@edate{}
\def\classificationnumber#1{\def\@classificationnumber{#1}}\def\@classificationnumber{}
\def\confidential#1{\def\@confidential{#1}}\def\@confidential{}
\def\udc#1{\def\@udc{#1}}\def\@udc{}
\def\degreelevel#1{\def\@degreelevel{#1}}\def\@degreelevel{硕士}
\def\submitdate#1{\def\@submitdate{#1}}\def\@submitdate{}
\def\defensedate#1{\def\@defensedate{#1}}\def\@defensedate{}
\def\degreedate#1{\def\@degreedate{#1}}\def\@degreedate{}
\def\chairman#1{\def\@chairman{#1}}\def\@chairman{}
\def\reviewers#1{\def\@reviewers{#1}}\def\@reviewers{}

%% ============================================================
%% 中文扉页
%% ============================================================
\newlength{\@info@label@width}
\setlength{\@info@label@width}{7em}  % 第一列标签宽度（最长 6 字 + 1em 分散余量）

\def\maketitlepage{
    \cleardoublepage
    \thispagestyle{empty}
    % 分类号、密级、UDC
    \begin{spacing}{1.5}
        \noindent
        {\heiti\zihao{4}分类号\hspace{1em}\underline{\makebox[6em]{\@classificationnumber}}}
        \hspace{1em}
        {\heiti\zihao{4}密级\hspace{1em}\underline{\makebox[6em]{\@confidential}}}

        \noindent
        {\heiti\zihao{4}UDC\hspace{1em}\underline{\makebox[6em]{\@udc}}}
    \end{spacing}

    {\zihao{5}\vspace{\baselineskip}}
    % 学位论文 标题
    \begin{centering}
        \begin{spacing}{1.0}
            {\songti\zihao{2}学\hspace{1em}位\hspace{1em}论\hspace{1em}文}
        \end{spacing}
    \end{centering}

    {\zihao{-2}\vspace{\baselineskip}}

    % 论文题目
    \begin{centering}
        \begin{spacing}{1.0}
        {\heiti\zihao{-2}\@ctitle}
        \end{spacing}
    \end{centering}

    {\zihao{5}\vspace{2.5\baselineskip}}

    % 信息表格
    \begin{centering}
        \zihao{4}\songti
        \renewcommand{\arraystretch}{1.5}
        \begin{tabular}{@{}r@{\hspace{0.5em}}l@{}}
            \makebox[\@info@label@width][s]{作\hfill 者\hfill 姓\hfill 名}：& \@cauthor \\
            \makebox[\@info@label@width][s]{作\hfill 者\hfill 学\hfill 号}：& \@studentid \\
            \makebox[\@info@label@width][s]{指\hfill 导\hfill 教\hfill 师}：& \@csupervisor \\
            \makebox[\@info@label@width]{}\phantom{：}& \@cdepartment \\
            \makebox[\@info@label@width][s]{申\hfill 请\hfill 学\hfill 位\hfill 级\hfill 别}：& \@degreelevel \\
            \makebox[\@info@label@width][s]{学\hfill 科\hfill 专\hfill 业\hfill 名\hfill 称}：& \@cmajor \\
            \makebox[\@info@label@width][s]{论\hfill 文\hfill 提\hfill 交\hfill 日\hfill 期}：& \@submitdate \hspace{0.5em} \makebox[7em][s]{论\hfill 文\hfill 答\hfill 辩\hfill 日\hfill 期}：\@defensedate \\
            \makebox[\@info@label@width][s]{学\hfill 位\hfill 授\hfill 予\hfill 日\hfill 期}：& \@degreedate \hspace{0.5em} \makebox[7em][s]{答\hfill 辩\hfill 委\hfill 员\hfill 会\hfill 主\hfill 席}：\@chairman \\
            \makebox[\@info@label@width][s]{评\hfill 阅\hfill 人}：& \@reviewers \\
        \end{tabular}
    \end{centering}

    {\zihao{5}\vspace{4.5\baselineskip}}
    \begin{center}
        {\zihao{4}东\hspace{1em}北\hspace{1em}大\hspace{1em}学}\\[6pt]
        {\zihao{4}\@cdate}
    \end{center}
    \clearpage
}

%% ============================================================
%% 英文扉页
%% ============================================================
\def\makeetitlepage{
    \cleardoublepage
    \thispagestyle{empty}

    {\zihao{5}\vspace{\baselineskip}}

    {\noindent\bfseries\zihao{4}A Thesis in \@emajor\par}

    {\zihao{5}\vspace{3\baselineskip}}

    \begin{center}
        {\bfseries\zihao{2}\@etitle}
    \end{center}

    {\zihao{5}\vspace{3\baselineskip}}

    \begin{center}
        {\zihao{4}By \@eauthor}
    \end{center}

    {\zihao{5}\vspace{3\baselineskip}}

    \begin{center}
        {\zihao{4}Supervisor: \@esupervisor}
    \end{center}

    {\zihao{2}\vspace{7\baselineskip}}

    \begin{center}
        {\bfseries\zihao{3}Northeastern University}\\[6pt]
        {\bfseries\zihao{3}\@edate}
    \end{center}
    \clearpage
    
}

%% ============================================================
%% 独创性声明
%% ============================================================
\newcommand{\makedeclaration}{
    \cleardoublepage
    \setcounter{page}{1}
    \pagenumbering{Roman}
    \thispagestyle{declaration}
    \phantomsection

    {\zihao{2}\vspace{1.5\baselineskip}}
    \begin{center}
        {\heiti\zihao{2}独创性声明}
    \end{center}
    {\zihao{2}\vspace{0.4\baselineskip}}

    {\songti\fontsize{14bp}{22bp}\selectfont
        本人声明，所呈交的学位论文是在导师的指导下完成的。论文中取得的研究成果除加以标注和致谢的地方外，不包含其他人已经发表或撰写过的研究成果，也不包括本人为获得其他学位而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示谢意。
    \par}

    {\zihao{4}\vspace{1\baselineskip}}

    \begin{flushright}
        \zihao{4}
        \begin{tabular}{@{}l@{}}
            学位论文作者签名：\hspace{8em}\\[0.5cm]
            日\hspace{2em}期：\hspace{8em}
        \end{tabular}
    \end{flushright}

    {\zihao{4}\vspace{1\baselineskip}}

    \begin{center}
        {\heiti\zihao{2}学位论文版权使用授权书}
    \end{center}
    \vspace{0.5cm}

    {\songti\fontsize{14bp}{22bp}\selectfont
        本学位论文作者和指导教师完全了解东北大学有关保留、使用学位论文的规定：即学校有权保留并向国家有关部门或机构送交论文的复印件和磁盘，允许论文被查阅和借阅。本人同意东北大学可以将学位论文的全部或部分内容编入有关数据库进行检索、交流。
    \par}

    \vspace{1cm}

    {\songti\fontsize{14bp}{22bp}\selectfont
        作者和导师同意网上交流的时间为作者获得学位后：

        \vspace{0.5cm}
        半年 $\square$\hspace{2em}一年 $\square$\hspace{2em}一年半 $\square$\hspace{2em}两年 $\square$
    \par}

    {\zihao{5}\vspace{1\baselineskip}}

    \zihao{4}
    \noindent 学位论文作者签名：\hspace{6em}%
    \hfill 导师签名：\hspace{6em}

    \vspace{0.5cm}

    \noindent 签字日期：\hspace{6em}%
    \hfill 签字日期：\hspace{6em}

}

%% ============================================================
%% 中文摘要环境
%% ============================================================
\newenvironment{cabstract}{
    \chapter*{\centering{\heiti\zihao{2}摘\hspace{1em}要}}
    \thispagestyle{cabstract}
    \songti\normalsize
}{
    \par
}

\newcommand{\ckeywords}[1]{
    \vskip 0.5cm
    \noindent{\heiti\zihao{-4}关键词：}\songti\zihao{-4}#1
}

%% ============================================================
%% 英文摘要环境
%% ============================================================
\newenvironment{eabstract}{
    \chapter*{\centering{\zihao{2}Abstract}}
    \thispagestyle{eabstract}
    \normalsize
}{
    \par
}

\newcommand{\ekeywords}[1]{
    \vskip 0.5cm
    \noindent{\bfseries\zihao{-4}Key words: }\zihao{-4}#1
}

%% ============================================================
%% 目录格式
%% 章标题：小三号黑体（15pt）
%% 节标题：小四号宋体（12pt）
%% 小节标题：小四号宋体（12pt）
%% 1.5 倍行距
%% ============================================================
\renewcommand{\cftdot}{$\cdot$}
\renewcommand{\cftdotsep}{1}
\renewcommand{\cftchapdotsep}{\cftdotsep}

% 目录项字体
\renewcommand{\cftchapfont}{\heiti\zihao{-3}}
\renewcommand{\cftsecfont}{\songti\zihao{-4}}
\renewcommand{\cftsubsecfont}{\songti\zihao{-4}}

% 目录项页码字体
\renewcommand{\cftchappagefont}{\zihao{-4}}
\renewcommand{\cftsecpagefont}{\zihao{-4}}
\renewcommand{\cftsubsecpagefont}{\zihao{-4}}

% 目录项行距
\setlength{\cftbeforechapskip}{6pt}
\setlength{\cftbeforesecskip}{3pt}
\setlength{\cftbeforesubsecskip}{3pt}

% 目录项缩进
\setlength{\cftchapindent}{0em}
\setlength{\cftsecindent}{2em}
\setlength{\cftsubsecindent}{4em}

% 章节目录点线
\renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}

% 目录命令
\newcommand{\makecontents}{
    \cleardoublepage
    \@openrightfalse          % 阻止 \chapter* 内部再次 cleardoublepage
    \chapter*{\centering{\songti\zihao{2}目\hspace{2em}录}}
    \@openrighttrue           % 恢复
    \thispagestyle{empty}
    \@starttoc{toc}
    \cleardoublepage
}

%% ============================================================
%% 图表标题格式
%% 图号：章序号编号（图2.1），5号宋体，置于图下方居中
%% 表号：章序号编号（表2.1），5号宋体，置于表上方居中
%% ============================================================
\captionsetup{font={small,bf},labelsep=space}
\captionsetup[figure]{position=bottom,font={small},labelsep=space,skip=4bp}
\captionsetup[table]{position=top,font={small},labelsep=space,skip=2bp}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}

%% ============================================================
%% 插图路径
%% ============================================================
\graphicspath{{figures/}{images/}}

%% ============================================================
%% 致谢环境
%% ============================================================
\newenvironment{acknowledge}{
    \chapter*{\centering{\heiti\zihao{2}致\hspace{2em}谢}}
    \addcontentsline{toc}{chapter}{致谢}
    \markboth{致谢}{}
    \songti\normalsize
}{
    \clearpage
}

%% ============================================================
%% 攻读学位期间发表的论著环境
%% ============================================================
\newenvironment{publications}{
    \chapter*{\centering{\heiti\zihao{2}攻读硕士学位期间发表的论文}}
    \addcontentsline{toc}{chapter}{攻读硕士学位期间发表的论文}
    \markboth{攻读硕士学位期间发表的论文}{}
    \songti\normalsize
}{
    \clearpage
}

%% ============================================================
%% 个人简历环境
%% ============================================================
\newenvironment{resume}{
    \chapter*{\centering{\heiti\zihao{2}个人简历}}
    \addcontentsline{toc}{chapter}{个人简历}
    \markboth{个人简历}{}
    \songti\normalsize
}{
    \clearpage
}

%% ============================================================
%% 附录设置
%% ============================================================
\renewcommand\appendix{\setcounter{secnumdepth}{-2}}

% 进入正文后：启用 openright，每章从奇数页（右页）开始，前一页为空白页
% 如需关闭双页空白，将下方 \@openrighttrue 改为 \@openrightfalse
% 同时再次确保正文行距生效（避免被局部字号设置覆盖）
\renewcommand{\mainmatter}{
    \clearpage
    \@mainmattertrue
    \neu@bodymattertrue
    \@openrighttrue   %% [双页空白开关] 改为 \@openrightfalse 可关闭
    \pagenumbering{arabic}
    \normalsize
}

%% ============================================================
%% 参考文献格式 — GBT7714 顺序编号
%% ============================================================
\bibliographystyle{unsrt}

%% ============================================================
%% 浮动参数
%% ============================================================
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}

%% ============================================================
%% 脚注使用带圈数字
%% ============================================================
\xeCJKsetcharclass{`①}{`⑩}{1}

\makeatother
\endinput
