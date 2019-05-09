<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
  >
  <!-- xmlns="http://www.w3.org/1999/xhtml"- -->

<xsl:output method="xml"/>

<xsl:template match="/">
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="xsl:output">
  <xsl:copy>
  <xsl:attribute name="method">html</xsl:attribute>
  </xsl:copy>
</xsl:template>

<xsl:template
match="xsl:template[@match='*'][@mode='schematron-get-full-path']">
  <xsl:copy>
    <xsl:attribute name="match">*</xsl:attribute>
    <xsl:attribute name="mode">schematron-get-full-path</xsl:attribute>
    <xsl:element name="xsl:apply-templates">
      <xsl:attribute name="select">parent::*</xsl:attribute>
      <xsl:attribute name="mode">schematron-get-full-path</xsl:attribute>
    </xsl:element>
    <xsl:element name="xsl:text">/ </xsl:element>
    <xsl:element name="xsl:value-of">
      <xsl:attribute name="select">name()</xsl:attribute>
    </xsl:element>
    <xsl:element name="xsl:variable">
      <xsl:attribute name="name">ord</xsl:attribute>
      <xsl:attribute name="select">
      1 + count(preceding-sibling::*[local-name()=local-name(current())])
      </xsl:attribute>
    </xsl:element>
    <xsl:element name="xsl:if">
      <xsl:attribute name="test">
      $ord &gt; 1 or following-sibling::*[local-name()=local-name(current())]
      </xsl:attribute>
      [<xsl:element name="xsl:value-of">
      <xsl:attribute name="select">$ord</xsl:attribute>
      </xsl:element>]
    </xsl:element>
  </xsl:copy>
</xsl:template>

<xsl:template match="svrl:schematron-output">
  <html>
  <head>
  <title><xsl:value-of select="@title"/></title>
  <style type="text/css">
  table { border-collapse: collapse; }
  td, th {
    padding-left: 4px; padding-right: 4px;
    border: 1px solid grey; white-space: normal;
  }
  tr.Error { background-color: #FFCCFF; }
  tr.Cond { background-color: #FFCCCC; }
  tr.Warn { background-color: #FFFFCC; }
  tr.Notice { background-color: #FFFFFF; }
  tr.Info { background-color: #EEEEEE;  color: #666666; }
  td.br { word-break: break-all; }
  </style>
  </head>
  <body>
  <h1>Schematron validation result</h1>
  <dl>
  <dt>Title:</dt>
  <dd><xsl:value-of select="@title"/></dd>
  <dt>Version:</dt>
  <dd><xsl:value-of select="@schemaVersion"/></dd>
  <xsl:element name="xsl:if">
    <xsl:attribute name="test"
    >//processing-instruction('document-uri')</xsl:attribute>
    <dt>Source:</dt>
    <dd>
    <xsl:element name="a">
    <xsl:attribute name="href"
    >{//processing-instruction('document-uri')}</xsl:attribute>
    <xsl:element name="xsl:value-of">
    <xsl:attribute name="select"
    >//processing-instruction('document-uri')</xsl:attribute>
    </xsl:element>
    </xsl:element>
    </dd>
  </xsl:element>
  </dl>
  <p>Levels:<br />
  <table border="1">
  <tbody>
  <tr>
    <th>Level</th>
    <th>Description</th>
  </tr>
  <tr class="Error">
    <td>Error</td>
    <td>Mandatory (<b>shall</b> level): the record will not be compliant until the issue is solved.</td>
  </tr>
  <tr class="Cond">
    <td>Cond</td>
    <td>Conditional: possible error with a condition that cannot be tested automatically.</td>
  </tr>
  <tr class="Warn">
    <td>Warn</td>
    <td>Warning (<b>should</b> level): failed to meet guidance, which may be mandatory in the later version of WMO Core Profile.</td>
  </tr>
  <tr class="Notice">
    <td>Notice</td>
    <td>Notice of a best practice which is optional; record creators <b>may</b> adopt the suggestion.</td>
  </tr>
  <tr class="Info">
    <td>Info</td>
    <td>Information: message does not necessarily mean good or bad.</td>
  </tr>
  </tbody>
  </table>
  </p>
  <p>Result:<br />
  <table border="1">
  <tbody>
    <tr>
      <th>Level</th>
      <th>Source</th>
      <th>Rule id</th>
      <th>Location</th>
      <th>Message</th>
    </tr>
    <xsl:for-each select="xsl:apply-templates">
      <xsl:copy-of select="."/>
    </xsl:for-each>
  </tbody>
  </table>
  </p>
  </body>
  </html>
</xsl:template>

<xsl:template match="svrl:fired-rule">
  <!--
  <tr>
    <td>(rule)</td>
    <td></td>
    <td></td>
    <td><xsl:value-of select="@context"/></td>
    <td></td>
  </tr>
  -->
</xsl:template>

<xsl:template match="svrl:failed-assert|svrl:successful-report">
  <tr>
    <xsl:variable name="level"
    select="substring-before(concat(*[@name='flag'], '-'), '-')"/>
    <xsl:variable name="levelStr">
      <xsl:choose>
      <xsl:when test="$level = 'E'">Error</xsl:when>
      <xsl:when test="$level = 'C'">Cond</xsl:when>
      <xsl:when test="$level = 'W'">Warn</xsl:when>
      <xsl:when test="$level = 'N'">Notice</xsl:when>
      <xsl:when test="$level = 'I'">Info</xsl:when>
      <xsl:otherwise><xsl:value-of select="$level"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:attribute name="class">
      <xsl:value-of select="$levelStr"/>
    </xsl:attribute>
    <td><xsl:value-of select="$levelStr"/></td>
    <td><xsl:value-of select="substring-after(*[@name='flag'],'-')"/></td>
    <td class="br">
      <xsl:variable name="assertid" select="*[@name='id']"/>
      <xsl:choose>
      <xsl:when test="starts-with($assertid, 'WCMP13.')">
        <a href="http://wis.wmo.int/2012/metadata/conf/{substring-after($assertid, 'WCMP13.')}">
        <xsl:value-of select="$assertid"/>
        </a>
      </xsl:when>
      <xsl:when test="starts-with($assertid, 'WCMP')">
        <!--a href="http://toyoda-eizi.net/2013/wcmp/wcmp13.sch#{$assertid}"-->
        <a href="http://wis.wmo.int/2012/metadata/validationTestSuite/wcmp13.sch#{$assertid}">
        <xsl:value-of select="$assertid"/>
        </a>
      </xsl:when>
      <xsl:when test="starts-with($assertid, 'ISO191')">
        <!--a href="http://toyoda-eizi.net/2013/wcmp/iso19139.sch#{$assertid}"-->
        <a href="http://wis.wmo.int/2012/metadata/validationTestSuite/iso19139.sch#{$assertid}">
        <xsl:value-of select="$assertid"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$assertid"/>
      </xsl:otherwise>
      </xsl:choose>
    </td>
    <td>
      <xsl:for-each select="*[@name='location']">
      <xsl:copy-of select="*"/>
      </xsl:for-each>
    </td>
    <td class="br">
      <xsl:for-each select="svrl:text">
      <xsl:copy-of select="*|text()"/>
      </xsl:for-each>
    </td>
  </tr>
</xsl:template>

<xsl:template match="*">
  <xsl:copy>
  <xsl:apply-templates select="*|@*|text()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="@*">
  <xsl:copy-of select="." />
</xsl:template>

</xsl:stylesheet>
