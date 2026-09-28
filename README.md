# 国科大平时作业模板

中文作业文档类。页面为 A4、小四、页边距 2.5 cm。文首放置国科大校徽。默认每页有校徽水印；页眉文字为「课程 · 作业序号」。

## 来源与许可

本仓库包含两项彼此独立的授权。

代码（`homework.cls` 及其余 TeX 源文件）以 [MIT License](LICENSE) 发布。题目接口改写自 Jacob Zimmerman, *latex-homework-class* (2014), <https://github.com/jez/latex-homework-class>，原作为 MIT License。本仓库保留上游版权声明：Copyright (c) 2014 Jacob Zimmerman; Copyright (c) 2026 Jiawei He.

版式与校徽引自 jweihe, 国科大课程论文模板, <https://github.com/jweihe/UCAS_Latex_Template>，该作品以 [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) 授权。下列文件沿用 CC BY 4.0，不纳入上述 MIT 授权：

| 文件 | 关系 |
| --- | --- |
| `figures/ucas_logo.pdf` | 原样收录 |
| `figures/ucas_logo.png` | 原样收录 |
| `figures/ucas_watermark.png` | 由 `ucas_logo.png` 降低不透明度得到，图样未改 |

引用本模板时，请同时注明上述两个来源。机器可读的引用信息见 [CITATION.cff](CITATION.cff)。

在本目录编译。TeX Live 另有同名 `homework.cls`，同目录文件优先。

## 编译

```bash
make
```

或 `xelatex homework.tex`。日常写作复制 `template.tex`。

## 导言区

| 命令 | 含义 |
| --- | --- |
| `\hwclass` | 课程名 |
| `\hwtype` `\hwnum` | 作业类型与序号 |
| `\hwname` `\hwid` | 姓名、学号 |
| `\hwemail` | 邮箱，空则不显示 |
| `\hwdate` | 日期，默认当天 |

## 题目

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
  \questionpart (a)
  \questionpart (b)
\end{alphaparts}

\begin{arabicparts}
  \questionpart 题号.1
\end{arabicparts}
```

`\renewcommand{\questiontype}{练习}` 改变编号题前缀。`\setcounter{questionCounter}{9}` 使下一题为第 10 题。`\renewcommand{\writtensection}{5}` 后题号变为 5.1、5.2。`\section` 与 `\question` 等价，`\section*{标题}` 与 `\question*{标题}` 等价。

`\answerbox{4cm}` 留出作答空白。`\tbox{文字}` 为浅灰提示框。定理环境 `theorem`、`lemma`、`corollary`、`proposition`、`definition`、`example` 按题目编号，证明用 `proof`。

## 选项

```latex
\documentclass[anonymous,newpage,largemargins,nowatermark]{homework}
```

`anonymous` 把姓名印在单独扉页，正文页眉不印姓名。`newpage` 每题新页。`largemargins` 加宽页边距。

`nowatermark` 关闭水印。此时文档改为双面页眉：偶数页外侧是姓名，奇数页外侧是校徽，内侧是「课程 · 作业序号」。文首校徽不变。

水印图是淡化后的校徽 `figures/ucas_watermark.png`。需要再叠一行斜向校名时：

```latex
\renewcommand{\hwmarktext}{中国科学院大学}
\renewcommand{\hwtextopacity}{0.08}
\renewcommand{\hwtextrotation}{22}
```

图片放在 `figures/`。
