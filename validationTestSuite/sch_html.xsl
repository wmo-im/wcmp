<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  >

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="sch:schema">
  <html>
    <head>
      <title><xsl:value-of select="concat(sch:title, ' (version ', @schemaVersion, ')')"/></title>
      <style type="text/css">
      div.pattern {
        padding-left: 1em;
	border-left: 2px solid #ee9999;
	}
      div.rule {
        padding-left: 1em;
	border-left: 2px solid #9999ee;
	}
      td { line-break: break-all; }
      </style>
    </head>
    <body>
      <h1><xsl:value-of select="concat(sch:title, ' (version ', @schemaVersion, ')')"/></h1>
      <h2>Definitions</h2>
      <ul>
        <xsl:for-each select="sch:ns">
        <li>
	namespace
	<b><xsl:value-of select="@prefix"/></b>
	<xsl:value-of select="concat(' = &quot;', @uri, '&quot;')"/>
	</li>
	</xsl:for-each>
        <xsl:for-each select="sch:include">
        <li>
	include
	<xsl:element name="a">
	  <xsl:attribute name="href">
	    <xsl:value-of select="@href"/>
	  </xsl:attribute>
	  <b>
	  <xsl:value-of select="@href"/>
	  </b>
	</xsl:element>
	</li>
	</xsl:for-each>
      </ul>
      <xsl:apply-templates select="sch:pattern"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="sch:pattern">
  <h2>
    <xsl:element name="a">
      <xsl:attribute name="name">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:value-of select="concat('Pattern ', @id)"/>
    </xsl:element>
  </h2>
  <div class="pattern">
  <xsl:apply-templates select="sch:let"/>
  <xsl:apply-templates select="sch:rule"/>
  </div>
</xsl:template>

<xsl:template match="sch:rule">
  <h3><xsl:value-of select="concat('Context ', @context)"/></h3>
  <div class="rule">
  <xsl:apply-templates select="sch:let"/>
  <xsl:apply-templates select="sch:assert|sch:report"/>
  </div>
</xsl:template>

<xsl:template match="sch:let">
  <p />
  <table border="1" id="let.{@name}">
  <tbody>
  <tr><th>instruction</th><td>let</td></tr>
  <tr><th>name</th><td><xsl:value-of select="@name"/></td></tr>
  <tr><th>value</th><td><xsl:value-of select="@value"/></td></tr>
  </tbody>
  </table>
</xsl:template>

<xsl:template match="sch:assert|sch:report">
  <p></p>
  <table border="1" id="{@id}">
  <tbody>
  <tr><th>instruction</th><td><xsl:value-of select="local-name(.)"/></td></tr>
  <tr><th>fpi</th><td><xsl:value-of select="@fpi"/></td></tr>
  <tr><th>flag</th><td><xsl:value-of select="@flag"/></td></tr>
  <tr><th>test</th><td><xsl:value-of select="@test"/></td></tr>
  <tr><th>message</th><td>
    <xsl:for-each select="text()|sch:value-of">
    <xsl:choose>
    <xsl:when test="@select">
      <xsl:value-of select="concat('{', @select, '}')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="."/>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
  </td></tr>
  </tbody>
  </table>
</xsl:template>

</xsl:stylesheet>
