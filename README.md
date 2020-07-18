# ResXML

## What is ResXML?

ResXML is an XML application for the presentation-oriented markup of
resumes or curricula vitae. The aim is for ResXML to support a set of
features which make it a very functional tool for generating resumes
for actual use from an XML source.

## Does it work?

ResXML is currently in an alpha state, primarily because the amount of
documentation and supporting infrastructure is minimal. That's not to
say it doesn't work—the authors are already using it to produce
printed resumes for actual job applications. The problem is that you
need to know what you're doing. If you have the following:

* a working knowledge of XML;
* an XSLT processor; and (if you want PDF or PostScript output)
* an XSLFO formatter,

then you will be able to use ResXML to produce a resume.

## Producing a "targeted" resume

ResXML can help you produce multiple different "targeted" resumes from
a single source. Say you want to produce a "tech" and a "retail"
resume containing different content.

1. Elements common to all of your targets can be added in the usual
   way.

2. Annotate any elements that should appear only in one of the targets
   with the `targets` attribute. e.g., `<employer targets="retail">`.

3. Use the `common/targets.xsl` stylesheet to make an initial pass
   over your source, supplying it with one or more desired targets
   e.g.:

   `$ xsltproc --stringparam targets "retail" common/targets.xsl resume.xml > retail.xml`

4. You can add multiple targets (comma separated), and any element
   matching one or more of the targets will be passed through.

5. Finally, process the intermediate XML in the usual way.

## History

We originally developed ResXML in about 2003, and it was hosted on
SourceForge. This is _not_ a bit-for-bit copy of that repository, as
it contained quite a bit of Subversion- and SourceForge-related
detritus. We've moved the latest version of the important parts of
that repository over to GitHub, and left behind what wasn't required
or was no longer relevant.
