\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ottercv}[OtterCV]

\LoadClass[12pt, a4paper, oneside]{article}
\setlength{\parindent}{0cm}
\pagestyle{empty}

\RequirePackage[T1]{fontenc}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{tabularx}
\RequirePackage{csquotes}
\RequirePackage{fontawesome5}
\RequirePackage{xifthen}

\RequirePackage{tikz}
\usetikzlibrary{calc, fit, positioning}

\RequirePackage{enumitem}
\setlist{nolistsep, noitemsep}
\setlist[itemize]{label=\tiny\raisebox{1ex}+}

\RequirePackage{xcolor}
\definecolor{orange}{rgb}{1,0.5,0}
\definecolor{blue}{rgb}{0.14, 0.27, 0.52}
\definecolor{purple}{rgb}{0.6,0.1,0.4}

\RequirePackage{pdfpages}
\RequirePackage{fancyhdr}
\RequirePackage{tocloft}
    \tocloftpagestyle{empty}
    \renewcommand{\cftdot}{}
    \cftpagenumbersoff{table}
    \renewcommand{\cftlottitlefont}{%
        \par\vfill\hspace{-1cm}
        \vbox to 0pt{\hbox to\dimexpr\textwidth+2cm\relax{\dotfill}\vss}\\[8pt]
        \underline}
    \cftafterlottitleskip8pt
    \cftbeforelottitleskip8pt

\RequirePackage{titlesec}
\RequirePackage{setspace}
\RequirePackage[top=3cm, bottom=3cm, right=3cm, left=3cm]{geometry}
\newlength{\vindent}\vindent0cm
\newlength{\vleft}\vleft2cm
\newlength{\picsize}\picsize45mm

%%%%%%%%%% PICTURE %%%%%%%%%% 
\pgfkeys{
    /picture/.cd,
    xshift/.initial={0cm},
    yshift/.initial={0cm},
    zoom/.initial={1.3},
    size/.code=\picsize#1,
    }

\newcommand*{\pathtopicture}[2][]{%
    \pgfkeys{/picture/.cd,#1}%
    \def\@pathtopicture{#2}}

%%%%%%%%%% INFORMATION %%%%%%%%%% 
\title{Curriculum vitae}
\date{\today}
\newcommand*{\name}[2]{%
	\def\@firstname{#1}\def\@lastname{#2}%
	\author{\@firstname~\@lastname}
    }
\newcommand*{\theme}[1]{\def\@theme{#1}} \def\@theme{blue}
\newcommand*{\adress}[3][]{\def\@careof{#1}\def\@street{#2}\def\@zip{#3}} \let\@street\@empty \let\@zip\@empty\let\@careof\@empty
\newcommand*{\email}[1]{\def\@email{\href{mailto:#1}{#1}}} \let\@email\@empty
\newcommand*{\born}[2][]{\def\@birthday{\DTMdate{#2}}
                         \def\@born{\@birthday\ifthenelse{\isempty{#1}}{}{~in~#1}}} 
                         \let\@born\@empty \let\@birthday\@empty
\newcommand*{\phone}[2]{\def\@phone{\href{tel:+#1#2}{{\tiny\raisebox{1ex}+}#1 #2}}} \let\@phone\@empty
\newcommand*{\website}[1]{\def\@website{\href{#1}{#1}}} \let\@website\@empty
\let\adressfont\textnormal

\def\ADRESS{adress}
\def\EMAIL{e-mail}
\def\PHONE{phone}
\def\BORN{born~}
\def\WEBSITE{website}
\def\@coverletter{Cover letter}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%%%%%%%%%% REDESIGN STRUCTURE %%%%%%%%%% 
\catcode`\@=11
\def\hrulefill{\leavevmode\leaders\hrule height 6pt depth \dimexpr0.4pt-0.7ex\hfill\kern\z@}

\titleformat{\section}[runin]{\Large\bfseries\color{\@theme}}{}{0pt}{}[\hspace{12pt}\hrulefill\newline\vspace{-0.5\baselineskip}]
\titlespacing*{\section}{-\vindent}{1cm}{-6pt}
	
\titleformat{\paragraph}[block]{}{}{0cm}{}[\vspace{-1\baselineskip}]
\titlespacing*{\paragraph}{-\vindent}{12pt}{0cm}

\titleformat{\subsubsection}[block]{}{}{0cm}{\underline}[]
\titlespacing*{\subsubsection}{0cm}{6pt}{0cm}

\titleformat{\subsection}[block]{}{}{0cm}{\bfseries}[]
\titlespacing*{\subsection}{0cm}{6pt}{0cm}

\titleformat{\subparagraph}[block]{}{}{0cm}{}[]
\titlespacing*{\subparagraph}{0cm}{6pt}{0cm}
    
\def\curriculumvitae{}
%%%%%%%%%% POSSIBLE LAYOUTS %%%%%%%%%% 
\DeclareOption{massive}{%
	\let\adressfont\textbf
	\def\curriculumvitae{%
		\vindent5cm\vleft2cm
	    \setstretch{1}\pagestyle{empty}
	    \newgeometry{left=\dimexpr\vleft+\vindent\relax, right=\vleft, top=1cm, bottom=1cm}
	    \begin{tikzpicture}[remember picture, overlay]
	        \coordinate (corner) at  ($(current page.north west) - (0,\picsize+2cm)$);
	        \filldraw[\@theme] (current page.north east) rectangle  (corner);
	        \coordinate (write) at  ($(current page.north west) + (\vleft,-1cm)$);
	        \coordinate (picture) at  ($(current page.north east) - (\vleft,1cm)$);
	        \begin{scope}
	            \clip [rounded corners=.5cm] ($(picture)-(0.75\picsize,\picsize)$) rectangle coordinate (center) (picture); 
	            \node [inner sep=0pt] at ($(center)+(\pgfkeysvalueof{/picture/xshift},\pgfkeysvalueof{/picture/yshift})$) {\includegraphics[height=\pgfkeysvalueof{/picture/zoom}\picsize]{\@pathtopicture}}; 
	        \end{scope}
	        \node[anchor=north west, text width=0.5\paperwidth] (header) at (write)
	            {\color{white} 
	            {\Huge \textbf{\@author} \vspace{0.5cm}}\\ 
	             \begin{tabular}{@{}ll}
	                 \textbf{\ADRESS} & \@street \\ 
	                 				 & \@zip \\
	                 \textbf{\PHONE}& \@phone \\
	                 \textbf{\EMAIL}& {\@email} \\
	               %  \textbf{\WEBSITE}& {\@website} \\
	                 \textbf{\BORN}& \@born
	             \end{tabular}
	             };
	    \end{tikzpicture}\vspace{\dimexpr\picsize+0.5cm\relax}
	}
}

\DeclareOption{fancy}{%
	\let\adressfont\textit
	\def\curriculumvitae{%
		\vindent45mm\vleft25mm
		\newgeometry{left=\dimexpr\vleft+\vindent\relax, right=\vleft, top=2cm, bottom=2cm}
		\setstretch{1}\pagestyle{empty}
		\begin{tikzpicture}[remember picture, overlay]
		\coordinate (right) at ($(current page.north east) - (\vleft,2cm)$);
		\coordinate (left) at ($(current page.north west) + (\vleft,-2cm)$);
		\coordinate (down) at ($(right)-(0.75\picsize,\picsize)$);
		\node [anchor=north east, inner sep=0pt] (picture) at (right) {%
			\begin{tikzpicture}
				\clip[rounded corners=.5cm] (0,0) rectangle coordinate (middle) (-0.75\picsize,-\picsize); 
				\node[anchor=center] at ($(middle)+(\pgfkeysvalueof{/picture/xshift},\pgfkeysvalueof{/picture/yshift})$) {\includegraphics[height=\pgfkeysvalueof{/picture/zoom}\picsize]{\@pathtopicture}};
			\end{tikzpicture}
			};
		\node [draw=\@theme,rounded corners=0.5cm,line width=1pt, inner sep=0pt,outer sep=0pt,fit=(picture)] {};
		\node[anchor=north west, inner sep=0cm] (header) at (left) {\Huge\color{\@theme!60} {\textbf{\@firstname} \color{\@theme} \textbf{\@lastname}}};
		\node (H) at ($(left)-(1mm,9mm)$) [circle,fill, color=\@theme,inner sep=.5mm]{};
		\coordinate (I) at (H-|picture.west);
		\draw[line width=1pt, color=\@theme]  (H) -- (I);
% 		\draw[line width=1pt, color=\@theme]  (H) -- ++(\dimexpr\paperwidth-6.5cm-0.75\picsize\relax, 0);
		\node[anchor=north east, align=left, inner sep=0cm] (contact) at ($(I)-(5mm,2mm)$){%
            \begin{tabular}{l@{\hspace{.5\tabcolsep}}l@{}}
                \ifx\@careof\@empty\else%
                    \multicolumn{2}{l}{\adressfont{\@careof}}\\
                \fi%
                \multicolumn{2}{l}{\adressfont{\@street}}\\
                \multicolumn{2}{l}{\adressfont{\@zip}}\\
				\faUser &\adressfont{\@birthday} \\
				\faPhone* &\adressfont{\@phone} \\
				\faEnvelope[regular] &{\adressfont{\@email}}
            \end{tabular}
			};
		\end{tikzpicture}\vspace{\dimexpr\picsize-5mm\relax}
		}
	\titleformat{\section}[block]{\Large\bfseries\color{\@theme}}{\rule[2pt]{\dimexpr\vindent-0.5cm\relax}{3pt}\hspace{0.5cm}}{0pt}{}[]
	\titlespacing*{\section}{-\vindent}{1cm}{6pt}
}

\DeclareOption{basic}{%
    \theme{gray}
    \def\curriculumvitae{%
        \vindent5cm\setstretch{1}\pagestyle{empty}
        \newgeometry{left=\dimexpr\vleft+\vindent\relax, right=\vleft, top=2cm, bottom=2cm}
        
		{\Huge \color{gray} \textsf{\textbf{\@firstname} \color{black} \textbf{\@lastname} }}\\[12pt]
		\begin{tabular}{@{}ll}
		\textbf{\ADRESS} & \@street \\ 
		& \@zip \\
		\textbf{\PHONE}& \@phone \\
		\textbf{\EMAIL}& {\@email} \\
		\textbf{\BORN}& \@born
		\end{tabular}
	}
}

%%%%%%%%%% add LANGUAGES here: %%%%%%%%%% 
\DeclareOption{german}{%
    \PassOptionsToPackage{main=ngerman}{babel}
    \renewcommand{\ADRESS}{Adresse}
    \renewcommand{\EMAIL}{E-Mail}
    \renewcommand{\PHONE}{Telefon}
    \renewcommand{\BORN}{geboren am~}
    \renewcommand{\WEBSITE}{Webseite}
    \renewcommand{\@coverletter}{Anschreiben}
    \title{Lebenslauf}
    \newcommand{\DTMngermanshortmonthname}[1]{%
                \ifcase#1
                \or Jan%
                \or Feb%
                \or Mär%
                \or Apr%
                \or Mai%
                \or Jun%
                \or Jul%
                \or Aug%
                \or Sep%
                \or Okt%
                \or Nov%
                \or Dez%
                \fi}%
    }

\ProcessOptions\relax

%%%%%%%%%% LANGUAGE UPDATE %%%%%%%%%% 
\RequirePackage{iflang}
\RequirePackage[british]{babel}
\RequirePackage[useregional, calc]{datetime2}
\RequirePackage{translator}

\newcommand{\de}[1]{\IfLanguageName{ngerman}{#1}{}}
\newcommand{\en}[1]{\IfLanguageName{british}{#1}{}}

\addto\captionsbritish{%
    \renewcommand{\listtablename}{Attachments:}
    \renewcommand{\contentsname}{Overview}%
}
\addto\captionsngerman{%
    \renewcommand{\listtablename}{Anhang:}
    \renewcommand{\contentsname}{Übersicht}%
}

\newcommand{\MONTH}[1]{\texorpdfstring{\DTMshortmonthname{#1}}{}}
\newcommand{\DATE}[1]{\DTMdate{#1}}

%%%%%%%%%% SIGNATURE %%%%%%%%%% 
\pgfkeys{
    /signature/.cd,
    xshift/.initial={0cm},
    yshift/.initial={0cm},
    zshift/.initial={5mm},
    size/.initial={2cm},
}
    
\newcommand*{\city}[1]{\def\@city{#1}}
\newcommand*{\pathtosignature}[2][]{%
    \pgfkeys{/signature/.cd,#1}%
    \def\@pathtosignature{#2}}

\newcommand*{\signature}[1][]{%
    \pgfkeys{
        /signature/.cd,
        vspace/.initial={0cm},
        hspace/.initial={0cm},
        date/.initial={true},
        name/.initial={false},
        #1
    }
    \par
    \vspace{\dimexpr\pgfkeysvalueof{/signature/vspace}+1cm\relax}
    \hspace{\dimexpr\pgfkeysvalueof{/signature/hspace}-\vindent-4pt\relax}
	\begin{tikzpicture}[remember picture, overlay]
	\coordinate (center) at (0,0);
	\draw[thick] (center) -- ++(6,0);
	\node[anchor=south west, inner sep=0] (signature) at (\pgfkeysvalueof{/signature/xshift},\pgfkeysvalueof{/signature/yshift}) {\includegraphics[height=\pgfkeysvalueof{/signature/size}]{\@pathtosignature}};
	\ifthenelse{\boolean{\pgfkeysvalueof{/signature/date}}}{%
	    \node[anchor=north west, inner sep=0] (date) at (0,-\pgfkeysvalueof{/signature/zshift}) {\@city,~\IfLanguageName{ngerman}{den~}{}\@date};
	    }{}
	\ifthenelse{\boolean{\pgfkeysvalueof{/signature/name}}}{%
	    \node[anchor=south west,inner sep=0] (name) at (0,0 |- signature.north) {\@author};
	    }{}
	\end{tikzpicture}
}
    
%%%%%%%%%% LETTERS %%%%%%%%%% 
\newcommand{\subject}[1]{\def\@subject{#1}}\let\@subject\@empty
\newcommand{\recepient}[1]{\def\@recepient{#1}}\let\@recepient\@empty

\newlength{\lettersep}\lettersep5mm
\newlength{\letterind}\letterind10mm 

\pgfkeys{
    /letter/.cd,
    vspace/.code=\lettersep#1,
    hspace/.code=\letterind#1,
    sender/.initial={true},
    stretch/.initial=1,
}

\newcommand{\coverletter}[1][]{%
    \pgfkeys{/letter/.cd,#1}\vindent0cm
        \part[attachment=false]{\@coverletter}
    	\newgeometry{vmargin=2cm, hmargin=3cm}
        \hspace{\dimexpr-3pt-\letterind\relax}
    	\begin{tikzpicture}
    	\node[text width=\dimexpr\textwidth+\letterind\relax, anchor=north west, align=right, inner sep=0cm, font=\small] (head) at (0,0){%
    	        \@author \\ 
    	        \ifx\@careof\@empty \else \@careof\\ \fi%
    	        \@street \\ \@zip \\
            	%\PHONE: 
            	\@phone \\
            	%\EMAIL:
                {\@email}
            	};
        \node[anchor=north west, text width=\textwidth,inner sep=0pt] (adress) at ($(-\letterind,0|-head.south)-(0,2\lettersep)$) {%
            \ifthenelse{\boolean{\pgfkeysvalueof{/letter/sender}}}{\textsf{\underline{\@author, \ifx\@careof\@empty \else \@careof, \fi \@street, \@zip}}\\[1.5\lettersep]}{}%
            \@recepient};
        \node[anchor=north west, text width=\textwidth,inner sep=0pt] at (0,0|-adress.south) {\vspace{3\lettersep}\par{\raggedleft\@date\\[2\lettersep]} \par \textbf{\@subject}};
    	\end{tikzpicture}
}

%%%%%%%%%% STRUCTURE %%%%%%%%%%
\newcounter{partpage}
\renewcommand{\part}[2][]{%
    \pgfkeys{/structure/.cd,
        stretch/.initial={1},
        header/.initial={false},
        attachment/.initial={true},
        #1}
    \newpage\phantomsection\restoregeometry
    \ifthenelse{\boolean{\pgfkeysvalueof{/structure/header}}}
	    {% (true) : header 
	        \pagestyle{fancy}
            \setcounter{partpage}{\thepage}
            \setlength{\headheight}{15pt}
            \fancyhf{}
            \chead{#2}
            \cfoot{\expandafter\@slowromancap\romannumeral \the\numexpr\value{page}-\value{partpage}+1@}
	    }{% (false) : no header 
            \pagestyle{empty}
	    }
	\addcontentsline{toc}{part}{#2}
	\ifthenelse{\boolean{\pgfkeysvalueof{/structure/attachment}}}{%
    \addcontentsline{lot}{table}{$\bullet$\hspace{2mm} #2}}{}
    }
\renewcommand{\maketitle}{\part{\@title}\curriculumvitae}
\def\listofattachments{\listoftables}
\let\attachment\part

        


