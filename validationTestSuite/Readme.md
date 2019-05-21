## Schematron tests for WMO Core Metadata Profile

2014-08-01 Eizi TOYODA, Co-chair of WMO/CBS/IPET-MDRD

### What is this

This is an implementation of WMO Core Metadata Profile to ISO 19115:2003 and ISO/TS 19139:2007 in the Schematron language (ISO/IEC 19757-3:2006).

### Files

<dl>

<dt>Pure ISO 19139</dt>

<dd><span>This is Schematron implementation of rule-based requirements in the Table A.1, Annex A of ISO 19115:2003, which is not implemented in ISO/TS 19139:2007, which is required by the WMO Profile.</span>

<dl>

<dt>Source Schematron</dt>

<dd>[iso19139.sch](iso19139.sch)</dd>

<dt>XSLT to generate HTML report from ISO 19139 document</dt>

<dd>[iso19139.xsl](iso19139.xsl)</dd>

<dt>XSLT to visualize Schematron</dt>

<dd>[sch_html.xsl](sch_html.xsl)</dd>

</dl>

</dd>

<dt>WMO Core Metadata Profile v1.3</dt>

<dd><span></span>

<dl>

<dt>Source Schematron (imports iso19139.sch)</dt>

<dd>[wcmp13.sch](wcmp13.sch)</dd>

<dt>XSLT to generate HTML report from ISO 19139 document</dt>

<dd>[wcmp13.xsl](wcmp13.xsl)</dd>

</dl>

</dd>

<dt>Supporting files</dt>

<dd>

<dl>

<dt>Filter to convert SVRL into HTML</dt>

<dd>[svrl2htm.xsl](svrl2htm.xsl)</dd>

</dl>

</dd>

</dl>
