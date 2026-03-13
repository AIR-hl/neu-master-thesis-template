# NEUThesis — 东北大学硕士学位论文 LaTeX 模板

基于《东北大学硕士学位论文排版打印格式》(20251230版) 制作的 LaTeX 模板，可在本地 TeX 环境或 [Overleaf](https://www.overleaf.com) 上使用。

## 项目结构

```
NEUThesis/
├── main.tex                 # 主文件（从这里开始编译）
├── NEUMasterThesis.cls      # 模板类文件（一般不需要修改）
├── chapters/                # 论文各章节内容
│   ├── abstract.tex         # 中英文摘要
│   ├── chapter01.tex        # 第1章 绪论
│   ├── chapter02.tex        # 第2章（示例章节，含图表公式算法用法）
│   ├── conclusion.tex       # 结论
│   ├── acknowledgements.tex # 致谢
│   ├── publications.tex     # 攻读硕士学位期间发表的论文
│   ├── resume.tex           # 个人简历
│   └── appendix.tex         # 附录
├── images/                  # 你的论文插图（放在这里）
├── figures/                 # 校标等固定图片（不需要修改）
├── references/              # 参考文献
│   └── refs.bib             # BibTeX 参考文献数据库
└── README.md                # 本文件
```

## 快速开始

### 第一步：填写个人信息

打开 `main.tex`，修改开头的论文基本信息：

```latex
\ctitle{你的论文题目}              % 中文题目
\cauthor{你的姓名}                 % 姓名
\studentid{你的学号}               % 学号
\csupervisor{导师姓名\ 教授}       % 指导教师
\cdepartment{东北大学XX学院}       % 所在院系
\cmajor{XX专业}                    % 学科专业
\cdate{2026年6月}                  % 日期
% ... 其他英文信息和扉页信息
```

### 第二步：撰写各章内容

在 `chapters/` 目录下编辑对应的 `.tex` 文件：

- **摘要**：编辑 `chapters/abstract.tex`
- **正文章节**：编辑 `chapters/chapter01.tex` 等，需要更多章节时复制一份并在 `main.tex` 中添加 `\include`
- **结论**：编辑 `chapters/conclusion.tex`
- **致谢**：编辑 `chapters/acknowledgements.tex`
- **发表论文**：编辑 `chapters/publications.tex`
- **个人简历**：编辑 `chapters/resume.tex`

### 第三步：添加插图

将图片文件（`.png`, `.jpg`, `.pdf` 等）放入 `images/` 目录，然后在正文中引用：

```latex
\begin{figure}[htbp]
    \centering
    \includegraphics[width=0.8\textwidth]{images/your-image.png}
    \caption{图片标题}
    \label{fig:your-label}
\end{figure}
```

引用图片：`如图\ref{fig:your-label}所示`

### 第四步：添加参考文献

在 `references/refs.bib` 中添加 BibTeX 条目，然后在正文中引用：

```latex
这是一段引用示例\cite{citation-key}。
```

> 💡 **提示**：可以从 Google Scholar、知网等直接导出 BibTeX 格式的参考文献条目。

### 第五步：添加更多章节

1. 在 `chapters/` 目录下创建新文件，如 `chapter03.tex`
2. 在 `main.tex` 中添加一行：

```latex
\include{chapters/chapter03}    % 第3章
```

### 第六步：编译

在 Overleaf 上使用时，需要将编译器设置为 **XeLaTeX** 即可

## 常见问题

### Q: 编译报错怎么办？

确保使用 **XeLaTeX** 编译器（不是 pdfLaTeX）。本模板依赖 XeLaTeX 来处理中文字体。

### Q: 如何调整图片大小？

修改 `\includegraphics` 的 `width` 参数：

- `width=0.5\textwidth` — 占页面宽度的50%
- `width=0.8\textwidth` — 占页面宽度的80%
- `width=10cm` — 固定宽度10厘米

### Q: 参考文献格式不对？

本模板默认使用 `unsrt` 格式（按引用顺序排序）。如需 GB/T 7714 国标格式，请安装 `gbt7714` 宏包并在 `NEUMasterThesis.cls` 中将：

```latex
\bibliographystyle{unsrt}
```

替换为：

```latex
\RequirePackage{gbt7714}
\bibliographystyle{gbt7714-numerical}
```

## 许可

本模板免费提供，仅供东北大学研究生撰写学位论文使用。
