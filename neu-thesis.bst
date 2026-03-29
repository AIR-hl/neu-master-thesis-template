%% neu-thesis.bst
%% Numeric BibTeX style for NEU master thesis references.
%% Derived conceptually from the standard unsrt family, but rewritten
%% to match thesis-specific entry layouts.

ENTRY
  { address
    archiveprefix
    author
    booktitle
    chapter
    edition
    editor
    eprint
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    primaryclass
    publisher
    school
    series
    title
    type
    url
    version
    volume
    year
  }
  {}
  {}

INTEGERS { number.label nameptr namesleft numnames }

STRINGS  { s t }

FUNCTION {initialize.entry.count}
{ #0 'number.label := }

FUNCTION {count.entries}
{ number.label #1 + 'number.label := }

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {write.if.nonempty}
{ 's :=
  s empty$
    'skip$
    { s write$ }
  if$
}

FUNCTION {add.period.if.nonempty}
{ 's :=
  s empty$
    { "" }
    { s add.period$ }
  if$
}

FUNCTION {join.with.space}
{ 't :=
  's :=
  s empty$
    { t }
    { t empty$
        { s }
        { s " " * t * }
      if$
    }
  if$
}

FUNCTION {join.with.comma}
{ 't :=
  's :=
  s empty$
    { t }
    { t empty$
        { s }
        { s ", " * t * }
      if$
    }
  if$
}

FUNCTION {join.with.colon}
{ 't :=
  's :=
  s empty$
    { t }
    { t empty$
        { s }
        { s ":" * t * }
      if$
    }
  if$
}

FUNCTION {join.with.colon.space}
{ 't :=
  's :=
  s empty$
    { t }
    { t empty$
        { s }
        { s ": " * t * }
      if$
    }
  if$
}

FUNCTION {append.marker}
{ 't :=
  's :=
  s empty$
    { "" }
    { s t * }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            { { t #1 #1 substring$ "-" = }
              { "-" *
                t #2 global.max$ substring$ 't :=
              }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    {
      s nameptr "{vv~}{ll}{~f.}{, jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { t "others" =
                { ", et~al." * }
                { ", " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { key field.or.null }
    { author format.names }
  if$
}

FUNCTION {format.author.or.editor}
{ author empty$
    { editor empty$
        { key field.or.null }
        { editor format.names }
      if$
    }
    { author format.names }
  if$
}

FUNCTION {format.author.or.organization}
{ author empty$
    { organization empty$
        { key field.or.null }
        { organization }
      if$
    }
    { author format.names }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages n.dashify }
  if$
}

FUNCTION {format.publisher.or.organization}
{ publisher empty$
    { organization field.or.null }
    { publisher }
  if$
}

FUNCTION {format.institution.or.organization}
{ institution empty$
    { organization field.or.null }
    { institution }
  if$
}

FUNCTION {format.address.publisher}
{ address field.or.null
  format.publisher.or.organization join.with.colon.space
}

FUNCTION {format.address.school}
{ address field.or.null
  school field.or.null join.with.colon.space
}

FUNCTION {format.address.institution}
{ address field.or.null
  format.institution.or.organization join.with.colon.space
}

FUNCTION {format.article.journal}
{ journal empty$
    { publisher field.or.null }
    { journal }
  if$
}

FUNCTION {format.preprint.source}
{ journal empty$
    { archiveprefix empty$
        { note field.or.null }
        { archiveprefix "arXiv" =
            { note empty$
                { "arXiv preprint" }
                { "arXiv preprint arXiv:" note * }
              if$
            }
            { note empty$
                { archiveprefix }
                { archiveprefix " " * note * }
              if$
            }
          if$
        }
      if$
    }
    { journal }
  if$
}

FUNCTION {format.web.source}
{ url empty$
    { howpublished empty$
        { note empty$
            { publisher field.or.null }
            { note }
          if$
        }
        { howpublished }
      if$
    }
    { "\url{" url * "}" * }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  format.pages join.with.colon
}

FUNCTION {format.year.pages}
{ year field.or.null
  format.pages join.with.colon
}

FUNCTION {format.article.title}
{ title field.or.null "[J]" append.marker }

FUNCTION {format.book.title}
{ title field.or.null "[M]" append.marker }

FUNCTION {format.chapter.title}
{ title field.or.null "[A]" append.marker }

FUNCTION {format.thesis.title}
{ title field.or.null "[D]" append.marker }

FUNCTION {format.conference.title}
{ title field.or.null "[C]" append.marker }

FUNCTION {format.electronic.title}
{ title field.or.null "[EB/OL]" append.marker }

FUNCTION {format.report.title}
{ title field.or.null "[R]" append.marker }

FUNCTION {format.article.tail}
{ format.article.journal
  year field.or.null join.with.comma
  format.vol.num.pages join.with.comma
}

FUNCTION {format.book.tail}
{ format.address.publisher
  year field.or.null join.with.comma
  format.pages join.with.comma
}

FUNCTION {format.thesis.tail}
{ format.address.school
  year field.or.null join.with.comma
}

FUNCTION {format.inproceedings.tail}
{ booktitle field.or.null
  format.year.pages join.with.comma
}

FUNCTION {format.manual.tail}
{ format.address.publisher
  year field.or.null join.with.comma
}

FUNCTION {format.techreport.tail}
{ format.address.institution
  year field.or.null join.with.comma
}

FUNCTION {format.web.tail}
{ format.web.source
  year field.or.null join.with.comma
}

FUNCTION {format.preprint.tail}
{ format.preprint.source
  year field.or.null join.with.comma
}

FUNCTION {format.unpublished.tail}
{ note field.or.null
  year field.or.null join.with.comma
}

FUNCTION {begin.bib}
{ "\providecommand{\url}[1]{#1}" write$ newline$
  "\begin{thebibliography}{" write$
  number.label int.to.str$ write$
  "}" write$
  newline$
}

FUNCTION {end.bib}
{ "\end{thebibliography}" write$ newline$ }

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
}

FUNCTION {fin.entry}
{ newline$ }

FUNCTION {article}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.article.title add.period.if.nonempty join.with.space
  format.article.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  format.author.or.editor add.period.if.nonempty
  format.book.title add.period.if.nonempty join.with.space
  format.book.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.author.or.organization add.period.if.nonempty
  format.book.title add.period.if.nonempty join.with.space
  format.manual.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  format.author.or.editor add.period.if.nonempty
  format.book.title add.period.if.nonempty join.with.space
  format.book.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.chapter.title add.period.if.nonempty join.with.space
  booktitle field.or.null "[M]" append.marker add.period.if.nonempty join.with.space
  format.book.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.conference.title add.period.if.nonempty join.with.space
  format.inproceedings.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {conference}
{ inproceedings }

FUNCTION {manual}
{ output.bibitem
  format.author.or.organization add.period.if.nonempty
  format.book.title add.period.if.nonempty join.with.space
  format.manual.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.thesis.title add.period.if.nonempty join.with.space
  format.thesis.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {misc.web}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.electronic.title add.period.if.nonempty join.with.space
  format.web.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {misc.preprint}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.article.title add.period.if.nonempty join.with.space
  format.preprint.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {misc.generic}
{ output.bibitem
  format.author.or.organization add.period.if.nonempty
  title field.or.null add.period.if.nonempty join.with.space
  format.unpublished.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {misc}
{ archiveprefix empty$
    { url empty$ howpublished empty$ and
        { journal empty$
            { misc.generic }
            { output.bibitem
              format.authors add.period.if.nonempty
              format.article.title add.period.if.nonempty join.with.space
              format.article.tail add.period.if.nonempty join.with.space
              write.if.nonempty
              fin.entry
            }
          if$
        }
        { misc.web }
      if$
    }
    { misc.preprint }
  if$
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.thesis.title add.period.if.nonempty join.with.space
  format.thesis.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  format.author.or.organization add.period.if.nonempty
  format.conference.title add.period.if.nonempty join.with.space
  format.manual.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors add.period.if.nonempty
  format.report.title add.period.if.nonempty join.with.space
  format.techreport.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors add.period.if.nonempty
  title field.or.null add.period.if.nonempty join.with.space
  format.unpublished.tail add.period.if.nonempty join.with.space
  write.if.nonempty
  fin.entry
}

FUNCTION {default.type}
{ misc.generic }

MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}

READ

EXECUTE {initialize.entry.count}
ITERATE {count.entries}
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
