# Key Performance Indicators (KPI)

## Overview

This directory manages the WCMP KPI framework.  This document provides
instructions for adding KPIs and managing the documentation.

### Dependencies

KPI documentation is managed with [Asciidoctor](https://asciidoctor.org).

Link checking is managed with [asciidoc-link-check](https://www.npmjs.com/package/asciidoc-link-check).

### Building

```bash
# create HTML (single page)
asciidoctor --trace -o wcmp-1.3-kpi.html index.adoc
# create PDF
asciidoctor --trace -r asciidoctor-pdf --trace -b pdf -o wcmp-1.3-kpi.pdf index.adoc
```

# check links
```bash
find . -name "???.adoc" -exec asciidoc-link-check -p -c asciidoc-link-check-config.json {} \;
```

**Note**: `Makefile` provides shortcuts to these commands if you are able to run `make`.

## How to add a KPI

- copy the `template.adoc` file to a new file (i.e. `cp template.adoc 013.adoc`)
- update accordingly
- add the file to the end of `index.adoc` with `include::013.adoc[]`
- check that build works
- ensure links in documents are functional
- commit the updates (`git add 013.adoc && git commit -m 'add KPI-013' 013.adoc index.adoc`)

## Conventions

- Fixed values to always use:
  - WMO codelists URL: https://wis.wmo.int/2012/codelists/WMOCodeLists.xml
  - ISO codelists URL: https://standards.iso.org/iso/19139/resources/gmxCodelists.xml
- always leave an empty line at the end of the file.  This is required for
  proper formatting by tools like asciidoctor
- always fence XML snippets, single element names as code

## Releasing

See https://github.com/wmo-im/wcmp/wiki/ReleaseManagement for more information.
