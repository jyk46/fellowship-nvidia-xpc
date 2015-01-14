%=========================================================================
% CBX Document Class
%=========================================================================
% This class file is for generic documents such as reports, problem sets,
% and laboratory assignments. It uses the Palatino font which is a nice
% sans serif font, and at least a little more modern than the ironically
% named Computer Modern default. The class file puts the title and
% subtitle at the top of each page and page numbers are centered at the
% bottom.
%
% Author : Christopher Batten
% Date   : September 6, 2010
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cbxdoc}[2010/09/06 ver 0.1]
\LoadClass[10pt]{article}

%-------------------------------------------------------------------------
% Packages
%-------------------------------------------------------------------------

\RequirePackage[T1]{fontenc}  % Make sure we use T1 font encoding
\RequirePackage{mathpazo}     % Use palatino for serif font
\linespread{1.05}             % http://www.tug.dk/FontCatalogue/palatino

\RequirePackage{geometry}     % Page layout
\RequirePackage{caption}      % Flexibly configure captions
\RequirePackage{subcaption}   % Subfigure captions
\RequirePackage{graphicx}     % To include graphics
\RequirePackage{textcomp}     % For non-math characters (eg. mu)
\RequirePackage{cite}         % Sort cite lists [1,2,3]
\RequirePackage{fancyhdr}     % For headers and footers
\RequirePackage{booktabs}     % Very nice table formatting
\RequirePackage{xcolor}       % Colored text
\RequirePackage{datetime}     % Date/time formatting
\RequirePackage{url}          % Format URLs
\RequirePackage{pdfpages}
\RequirePackage{fancyvrb}     % Pretty code formatting
\RequirePackage{array}
\RequirePackage{multicol}
\RequirePackage{etoolbox}
\RequirePackage{wrapfig}

\RequirePackage{calc}         % Basic math operations
\RequirePackage{xifthen}      % Conditional code

%-------------------------------------------------------------------------
% Document Parameters
%-------------------------------------------------------------------------

\renewcommand{\title}[1]      {\gdef\cbx@title{#1}}
\newcommand{\subtitle}[1]     {\gdef\cbx@subtitle{#1}}
\renewcommand{\author}[1]     {\gdef\cbx@author{#1}}
\newcommand{\institution}[1]  {\gdef\cbx@institution{#1}}

%-------------------------------------------------------------------------
% Misc Setup
%-------------------------------------------------------------------------

% Setup date/time formats suitable for revision numbers

\newdateformat{revdate}{\THEYEAR-\twodigit{\THEMONTH}-\twodigit{\THEDAY}}
\newtimeformat{revtime}{\twodigit{\THEHOUR}-\twodigit{\THEMINUTE}}

%\RequirePackage[firstpage]{draftwatermark}
%\SetWatermarkLightness{0.9}

%\fancypagestyle{descriptionpagestyle}
%{%
%  \fancyhead{}
%  \fancyfoot{}
%  \fancyhead[C]{\itshape --- Draft Copy: Please Do Not Redistribute ---}
%  \fancyfoot[C]{\thepage}
%}
%
%\pagestyle{descriptionpagestyle}

%-------------------------------------------------------------------------
% Code block formatting
%-------------------------------------------------------------------------

\renewcommand{\FancyVerbFormatLine}[1]
{%
  \parbox{1.5ex}{\raggedleft\theFancyVerbLine} #1%
}

%-------------------------------------------------------------------------
% \cbxproposal@setfontsize{pts} Macro
%-------------------------------------------------------------------------
% We explicitly set the font sizes in points so that we know exactly how
% big each font. Subsection headers are supposed to be 11pt, but there
% is no equivalent built-in LaTeX font size which corresponds to 11pt%
% (normalsize is 10pt and large is 12pt). Notice we always calculate the
% the line spacing to be 1.2 times the font size.

\newlength{\cbxproposal@Templen}
\newcommand{\cbxproposal@setfontsize}[1]
{%
  \setlength{\cbxproposal@Templen}{#1 * \real{1.2}}%
  \fontsize{#1}{\the\cbxproposal@Templen}\selectfont%
}

\newcommand{\cbxsetfontsize}[1]
{%
  \setlength{\cbxproposal@Templen}{#1 * \real{1.2}}%
  \fontsize{#1}{\the\cbxproposal@Templen}\selectfont%
}

%-------------------------------------------------------------------------
% Caption Fontsizes
%-------------------------------------------------------------------------
% We make the caption font slightly smaller than 11pt to make it
% separate from the text a bit more (smaller caption sizes are allowed
% in the GPG). We also bold the caption label, anticipating that each
% caption will include a short bold title.

\DeclareCaptionFont{slightlysmaller}{\cbxproposal@setfontsize{9pt}}
\captionsetup{font={slightlysmaller},labelfont={bf},skip=8pt}
\captionsetup[sub]{justification=centering,font={slightlysmaller},labelfont={},skip=6pt}
\newcommand{\cbxcaptionsize}{\cbxproposal@setfontsize{9pt}}

% Sometimes we want to manually create subfigure labels. For example we
% might have three subfigures but they are really subplots in a single
% pdf. We can use the following macro to create the subfigure captions.
% It takes two arguments: the first is the width of the subfigure
% caption and the second is the subfigure text. Put your label in the
% subfigure text.

\newcommand{\cbxsubfigcaption}[2]{\subfloat[#2]{\rule{#1}{0pt}}}

%-------------------------------------------------------------------------
% Page Layout
%-------------------------------------------------------------------------
% A margin of 1.2in seems to be a good compromise between number of
% characters per line vs. compactness.

\geometry
{%
  margin=0.5in,
  tmargin=0.4in,
  bmargin=0.6in,
  footskip=0.3in,
}

%-------------------------------------------------------------------------
% Header/Footers
%-------------------------------------------------------------------------
% We put the title and subtitle in the header and the page numbers are
% centered in the footer.

\fancypagestyle{mainpagestyle}%
{%
  \fancyhead{}%
  \fancyfoot{}%
  %
  % Header Left
  %
  \fancyhead[L]
  {%
    \ifthenelse{ \NOT\isundefined{\cbx@subtitle} }%
    {%
      \textit{\cbx@title}%
    }{}%
  }%
  %
  % Header Center
  %
  \fancyhead[C]
  {%
    %\ifthenelse{ \isundefined{\cbx@subtitle} }%
    %x{%
    %  \textit{\cbx@title}%
    %}{}%
  }%
  %
  % Header Right
  %
  \fancyhead[R]
  {%
    \ifthenelse{ \NOT\isundefined{\cbx@subtitle} }%
    {%
      \textit{\cbx@subtitle}%
    }{}%
  }%
  %
  % Footer
  %
  \fancyfoot[C]{\thepage}%
}%

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

%\pagestyle{mainpagestyle}

%-------------------------------------------------------------------------
% Title Block
%-------------------------------------------------------------------------

\renewcommand{\@maketitle}
{%
  \centering%
  %\vspace*{-0.7in}
  %\itshape --- Draft Copy: Please Do Not Redistribute ---\par
  %\vspace{0.2in}
  %
  % Title
  %
  {\Large\textbf{\cbx@title}\par}%
  %
  % Subtitle
  %
  \ifthenelse{ \NOT\isundefined{\cbx@subtitle} }%
  {%
    {\Large\textbf{\cbx@subtitle}\par}%
  }{}%
  %
  % Author
  %
  \ifthenelse{ \NOT\isundefined{\cbx@author} }%
  {%
    \vspace{0.1in}%
    {\large\cbx@author\par}%
  }{}%
  %
  % Institution
  %
  \ifthenelse{ \NOT\isundefined{\cbx@institution} }%
  {%
    \vspace{0.1in}%
    {\cbx@institution\par}%
  }{}%
  %
  %\pagestyle{descriptionpagestyle}
  \thispagestyle{empty}%
  \vspace{0.1in}
}

%-------------------------------------------------------------------------
% Section headers
%-------------------------------------------------------------------------
% We change the spacing around the section headers and we tighten up the
% spacing between the number and the title.

\renewcommand{\section}
{%
  \@startsection{section}{1}{\z@}%
                {6pt plus 2pt minus 2pt}%
                {6pt plus 2pt minus 2pt}%
                {\large\bf}%
}

\renewcommand{\subsection}
{%
  \@startsection{subsection}{2}{\z@}%
                {6pt plus 2pt minus 2pt}%
                {6pt plus 2pt minus 2pt}%
                {\bf}%
}

\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\hspace{0.5em}}

%-------------------------------------------------------------------------
% Bibliography
%-------------------------------------------------------------------------

\let\cbx@oldthebibliography\thebibliography
\renewcommand{\thebibliography}[1]
{%
  \raggedright
  \cbx@oldthebibliography{#1}%
  \setlength{\itemsep}{0.5ex}%
}

% \patchcmd{\thebibliography}
% {\list}
% {\vspace{-0.15in}\begin{multicols}{2}\raggedright\footnotesize\list}
% {}
% {}
% \appto{\endthebibliography}{\vfill\mbox{}\end{multicols}}

% \let\cbx@oldthebibliography\thebibliography
% \renewcommand{\thebibliography}[1]
% {%
%   \cbx@oldthebibliography{#1}%
%   \setlength{\itemsep}{-0.1ex}%
% }

%-------------------------------------------------------------------------
% New Paragraph Format
%-------------------------------------------------------------------------

\renewcommand{\paragraph}[1]
{%
  \medskip\textbf{#1} --%
}

%-------------------------------------------------------------------------
% Float spacings
%-------------------------------------------------------------------------

\renewcommand{\topfraction}{0.95}
\renewcommand{\bottomfraction}{0.95}
\renewcommand{\textfraction}{0.05}
\renewcommand{\floatpagefraction}{0.7}

\newcommand{\bsk}{\baselineskip}
\setlength{\floatsep}{1\bsk plus 0.5\bsk minus 0.2\bsk}
\setlength{\textfloatsep}{1\bsk plus 0.5\bsk minus 0.2\bsk}

%-------------------------------------------------------------------------
% Compact formatting
%-------------------------------------------------------------------------

\newcommand{\TT}[1]{\texttt{#1}}
\newcommand{\BF}[1]{\textbf{#1}}
\newcommand{\IT}[1]{\textit{#1}}
\newcommand{\RM}[1]{\textrm{#1}}
\newcommand{\RD}[1]{\textcolor{red}{#1}}

%-------------------------------------------------------------------------
% Lists
%-------------------------------------------------------------------------

\newenvironment{cbxlist}[4][\textbullet]
{%
  \begin{list}{#1}
  {%
    \setlength{\leftmargin}{#2}
    \setlength{\rightmargin}{#3}
    \setlength{\topsep}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\listparindent}{0pt}
    \setlength{\itemsep}{#4}
  }
}{%
  \end{list}
}

%-------------------------------------------------------------------------
% Simple Macros
%-------------------------------------------------------------------------

\newcommand{\fixme}[1]{{\color{red}\bfseries [ FIXME: #1 ]}}
\newcommand{\wu}[2]{\mbox{#1\,#2}}
\newcommand{\um}{\mbox{\textmu m}}
\newcommand{\X}{$\times$}
\newcommand{\x}{\thinspace$\times$\thinspace}
\newcommand{\by}{$\times$}
\newcommand{\tw}{\textwidth}
\newcommand{\cw}{\columnwidth}

%-------------------------------------------------------------------------
% Table row formatting
%-------------------------------------------------------------------------

\newcolumntype{+}
{%
  >{\global\let\currentrowstyle\relax}%
}

\newcolumntype{^}
{%
  >{\currentrowstyle}%
}

\newcommand{\rs}
{%
  \gdef\currentrowstyle{\lastrowstyle}%
  \lastrowstyle\ignorespaces%
}

\newcommand{\rowstyle}[1]
{%
  \gdef\lastrowstyle{#1}%
  \gdef\currentrowstyle{#1}%
  #1\ignorespaces%
}

\newlength{\cbx@rowheight}
\newcommand{\rowheight}[1]
{%
  \setlength{\cbx@rowheight}{(#1 - 0.7em) * \real{0.5}}%
  \rule[-\cbx@rowheight]{0pt}{#1}%
}


