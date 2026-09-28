# 国科大平时作业模板

中文 LaTeX 作业文档类。A4、小四、页边距 2.5 cm。文首为国科大校徽，页眉为「课程 · 作业序号」。

## 下载

- [Download ZIP](https://github.com/Hepisces/ucas-latex-homework/archive/refs/heads/main.zip)
- 或克隆本仓库：

```bash
git clone https://github.com/Hepisces/ucas-latex-homework.git
```

## 使用

安装 [TeX Live](https://www.tug.org/texlive/)，编译器使用 XeLaTeX。TeX Live 另带一份同名 [`homework`](https://ctan.org/pkg/homework) 文档类，请在本目录中编译，让仓库内的 `homework.cls` 优先生效。

1. 编辑 `main.tex` 中的课程、姓名和学号。`main.tex` 须与 `homework.cls`、`figures/` 放在同一目录。
2. 编译：

```bash
xelatex main.tex
```

`make` 编译示例 `homework.tex`。使用 [LaTeX Workshop](https://github.com/James-Yu/LaTeX-Workshop) 时，将配方设为 XeLaTeX。上传到 [Overleaf](https://www.overleaf.com) 时同样选择 XeLaTeX。

只带走能编译的文件时运行 `python pack_sources.py`。它把 `main.tex`、`*.cls`、`*.bib`、`*.bst` 和 `figures/` 中的校徽打成 `ucas-homework-src.zip`，不包含预览图、示例 PDF 和 `homework.tex`。

## 样例

### 有水印

默认版式。正文页带校徽水印，页眉只有「课程 · 作业序号」。

[homework.pdf](homework.pdf)

<p align="center">
  <img src="figures/preview/watermark-cover.png" width="42%" alt="有水印，文首" />
  <img src="figures/preview/watermark-body.png" width="42%" alt="有水印，正文" />
</p>

### 无水印

```latex
\documentclass[nowatermark]{homework}
```

正文无水印。偶数页页眉外侧为姓名，奇数页页眉外侧为校徽，内侧均为「课程 · 作业序号」。文首校徽保留。

[homework-nowatermark.pdf](homework-nowatermark.pdf)

<p align="center">
  <img src="figures/preview/plain-even.png" width="42%" alt="无水印，偶数页" />
  <img src="figures/preview/plain-odd.png" width="42%" alt="无水印，奇数页" />
</p>

## 导言区

| 命令 | 含义 |
| --- | --- |
| `\hwclass` | 课程名 |
| `\hwtype` `\hwnum` | 作业类型与序号 |
| `\hwname` `\hwid` | 姓名、学号 |
| `\hwemail` | 邮箱，留空则不显示 |
| `\hwdate` | 日期，默认当天 |

## 题目

题目命令沿用 [latex-homework-class](https://github.com/jez/latex-homework-class) 的接口，说明见其 [README](https://github.com/jez/latex-homework-class/blob/master/README.md)。中文示例如下，完整稿见 `homework.tex`。

```latex
\question
解答。

\question*{归纳：等差数列求和}
\begin{induction}
  \basecase ...
  \indhyp   ...
  \indstep  ...
\end{induction}

\begin{alphaparts}
  \questionpart ...
\end{alphaparts}

\begin{arabicparts}
  \questionpart ...
\end{arabicparts}
```

`\question` 生成「题目 1」「题目 2」。题面放进 `problem`，题解从 `\solution` 之后写。`problem` 是浅蓝底、校色边框，表用 `threetab` 写在盒子里。

`\answerbox{4cm}` 留出作答空白。`\tbox{文字}` 为浅灰提示框。定理环境为 `theorem`、`lemma`、`corollary`、`proposition`、`definition`、`example`，证明用 `proof`。

题目中的表用 `threetab`，不要用浮动的 `table`。线只有 `\toprule`、`\midrule`、`\bottomrule`，没有竖线。

```latex
\begin{threetab}{lr}
  词项 & 文档频率 df \\
  \midrule
  dragon & 66{,}000 \\
\end{threetab}
```

参考文献按 [ACL LaTeX 模板](https://github.com/acl-org/acl-style-files) 的 `acl_natbib.bst` 排版，标题为「参考文献」。条目写在 `ref.bib`，文末写 `\bibliography{ref}`。引用用 `\citep` 与 `\citet`。没有引用时不必写这一行。

## 选项

```latex
\documentclass[anonymous,newpage,largemargins,nowatermark]{homework}
```

| 选项 | 作用 |
| --- | --- |
| `nowatermark` | 关闭水印，改用双面页眉 |
| `anonymous` | 姓名、学号只出现在扉页，正文页眉不印姓名 |
| `newpage` | 每题从新页开始 |
| `largemargins` | 加宽页边距 |

图片放在 `figures/`。水印图为 `figures/ucas_watermark.png`。需要在水印上再叠一行校名时：

```latex
\renewcommand{\hwmarktext}{中国科学院大学}
\renewcommand{\hwtextopacity}{0.08}
\renewcommand{\hwtextrotation}{22}
```

## 来源与许可

除 [NOTICE](NOTICE) 所列校徽文件外，本仓库以 [MIT License](LICENSE) 授权。题目接口改写自 Jacob Zimmerman, [*latex-homework-class*](https://github.com/jez/latex-homework-class) (2014)，原许可见该仓库的 [LICENSE](https://github.com/jez/latex-homework-class/blob/master/LICENSE)。

校徽取自 [jweihe, 国科大课程论文模板](https://github.com/jweihe/UCAS_Latex_Template)，按 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) 使用。原文件、衍生文件与改动写在 [NOTICE](NOTICE) 中。

引用信息见 [CITATION.cff](CITATION.cff)。
