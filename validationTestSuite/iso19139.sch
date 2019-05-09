<?xml-stylesheet type="text/xsl" href="sch_html.xsl"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
 schemaVersion="2014-03-06">
<title>Requirements not enforceable with XML Schema of ISO/TS 19139:2006</title> <ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
<ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
<ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>

<pattern xml:id="iso19139rules" id="iso19139rules">
  <rule context="gmd:*[contains('abcdefghijklmnopqrstuvwxyz',
  substring(local-name(),1,1))]">
    <assert
    id="ISO19139.A21.nilReason"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:ISO19139.nilReason"
    flag="I-ISO"
    test="(string-length(*)&gt;0) or @xlink:href or @uuidref or @gco:nilReason"
    >This element is empty and has no attribute @xlink:href nor @uuidref; it is possible to use @gco.nilReason to describe why this element is left empty.</assert>
  </rule>
  <!--<ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>-->
  <!-- when evaluating a codeList, @codeListValue has precedence if present;
  if it is missing, text node is used.  -->
  <let name="hierarchyLevel" value="substring-before(normalize-space(concat(
//gmd:MD_Metadata/gmd:hierarchyLevel/*/@codeListValue, ' ',
translate(normalize-space(//gmd:MD_Metadata/gmd:hierarchyLevel/*), ' ', '_'),
' ', 'dataset --dummy--')), ' ')" />
  <rule context="gmd:MD_Metadata">
    <report
    id="print.fileIdentifier"
    flag="I-NONE"
    test="true()"
    ><value-of select="gmd:fileIdentifier"/></report>
    <report
    id="ISO19139.TA1.language"
    flag="C-ISO"
    test="not(gmd:language)"
    >MD_Metadata.language MUST be documented unless defined by the encoding standard.</report>
    <report
    id="ISO19139.TA1.mdCharset"
    flag="C-ISO"
    test="not(gmd:characterSet)"
>MD_Metadata.characterSet MUST be documented if ISO/IEC 10646 not used and not defined by the encoding standard.</report>
  </rule>
  <rule context="gmd:MD_DataIdentification">
    <report
    id="ISO19139.TA1.dsCharset"
    flag="C-ISO"
    test="not(gmd:characterSet)"
>MD_DataIdentification.characterSet MUST be documented if ISO/IEC 10646 not used.</report>
    <assert
    id="ISO19139.TA1.geographic"
    flag="E-ISO"
    test="($hierarchyLevel != 'dataset') or (count(
gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox) +
count(
gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicDescription)
&gt; 0)"
>When hierarchyLevel is dataset, either EX_GeographicBoundingBox or EX_GeographicDescription MUST be documented.</assert>
    <assert
    id="ISO19139.TA1.topicCategory"
    flag="E-ISO"
    test="($hierarchyLevel != 'dataset') or gmd:topicCategory"
>topicCategory is mandatory unless hierarchyLevel is dataset</assert>
  </rule>
  <rule context="gmd:MD_AggregateInformation">
    <assert
    id="ISO19139.TA1.aggregateDatasetName"
    flag="E-ISO"
    test="gmd:aggregateDataSetName or gmd:aggregateDataSetIdentifier"
    >Either aggregateDataSetName or aggregateDataSetIdentifier must be
documented</assert>
  </rule>
  <rule context="gmd:MD_LegalConstraints">
    <assert
    id="ISO19139.TA1.otherConstraints"
    flag="E-ISO"
    test="gmd:otherConstraints or not(
      gmd:accessConstraints/*/@codeListValue='otherRestrictions' or
      gmd:accessConstraints/*/text()='otherRestrictions' or
      gmd:useConstraints/*/@codeListValue='otherRestrictions' or
      gmd:useConstraints/*/text()='otherRestrictions'
    )">otherConstraints must be documented if accessConstraints or useConstraints = "otherRestrictions"</assert>
  </rule>
  <rule context="gmd:DQ_DataQuality">
    <let name="level" value="substring-before(normalize-space(concat(
      gmd:scope/gmd:DQ_Scope/gmd:level/*/@codeListValue, ' ',
      translate(normalize-space(gmd:scope/gmd:DQ_Scope/gmd:level/*), ' ', '_'),
      ' --dummy--'
    )), ' ')" />
    <assert
    id="ISO19139.TA1.dqReportLineage"
    flag="E-ISO"
    test="($level != 'dataset') or (gmd:report or gmd:lineage)">"report" or "lineage" role is mandatory if scope.DQ_Scope.level = 'dataset'</assert>
  </rule>
  <rule context="gmd:DQ_Scope">
    <let name="level" value="substring-before(normalize-space(concat(
      gmd:level/*/@codeListValue, ' ',
      translate(normalize-space(gmd:level/*), ' ', '_'),
      ' --dummy--'
    )), ' ')" />
    <assert
    id="ISO19139.TA1.levelDescription"
    flag="E-ISO"
    test="gmd:levelDescription or ($level = 'dataset' or $level = 'series')"
>"levelDescription" is mandatory if "level" notEqual 'dataset' or 'series'</assert>
  </rule>
  <rule context="gmd:LI_Lineage">
    <let name="level" value="substring-before(normalize-space(concat(
      ../../gmd:scope/gmd:DQ_Scope/gmd:level/*/@codeListValue, ' ',
      translate(normalize-space(../../gmd:scope/gmd:DQ_Scope/gmd:level/*),
      ' ', '_'),
      ' --dummy--'
    )), ' ')" />
    <assert
    id="ISO19139.TA1.lineageStatement"
    flag="E-ISO"
    test="($level != 'dataset' and $level != 'series') or
      (gmd:source or gmd:processStep) or gmd:statement"
>If(count(source) + count(processStep) =0) and (DQ_DataQuality.scope.level = 'dataset' or 'series') then statement is mandatory</assert>
    <assert
    id="ISO19139.TA1.lineageContent"
    flag="E-ISO"
    test="gmd:source or gmd:processStep or gmd:statement">At least one of gmd:source, gmd:processStep or gmd:statement must be documented.</assert>
  </rule>
  <rule context="gmd:LI_Source">
    <assert
    id="ISO19139.TA1.LI_Source"
    flag="E-ISO"
    test="gmd:description or gmd:sourceExtent">Either description or sourceExtent must be documented</assert>
  </rule>
  <rule context="gmd:MD_Georectified">
    <assert
    id="ISO19139.TA1.MD_Georectified"
    flag="E-ISO"
    test="(gmd:checkPointAvailability = '0' or gmd:checkPointAvailability = 'false') or gmd:checkPointDescription">"checkPointDescription" is mandatory if "checkPointAvailability" = 1</assert>
  </rule>
  <rule context="gmd:MD_Band">
    <assert
    id="ISO19139.TA1.bandUnits"
    flag="E-ISO"
    test="not(gmd:maxValue or gmd:minValue) or gmd:units">"units" is mandatory if "maxValue" or "minValue" are provided</assert>
  </rule>
  <rule context="gmd:MD_Distribution">
    <assert
    id="ISO19139.TA1.distributionFormat"
    flag="E-ISO"
    test="gmd:distributionFormat or gmd:distributor/*/gmd:distributorFormat">count (distributionFormat + distributorFormat) &gt; 0</assert>
  </rule>
  <rule context="gmd:MD_ExtendedElementInformation">
    <let name="dataType" value="substring-before(normalize-space(concat(
      gmd:dataType/*/@codeListValue, ' ',
      translate(normalize-space(gmd:dataType/*), ' ', '_'),
      ' --dummy--'
    )), ' ')" />
    <let name="obligation" value="substring-before(normalize-space(concat(
      gmd:obligation/*/@codeListValue, ' ',
      translate(normalize-space(gmd:obligation/*), ' ', '_'),
      ' --dummy--'
    )), ' ')" />
    <assert
    id="ISO19139.TA1.extObligation"
    flag="E-ISO"
    test="$dataType = 'codelist' or $dataType = 'enumeration' or
      $dataType = 'codelistElement' or (gmd:obligation and
      gmd:maximumOccurence and gmd:domainValue)">if "dataType" notEqual 'codelist', 'enumeration' or 'codelistElement' then "obligation", "maximumOccurence" and "domainValue" are mandatory</assert>
    <assert
    id="ISO19139.TA1.extCondition"
    flag="E-ISO"
    test="$obligation != 'conditional' or gmd:condition">if "obligation" = 'conditional' then "condition" is mandatory</assert>
    <assert
    id="ISO19139.TA1.extDomainCode"
    flag="E-ISO"
    test="$dataType != 'codeListElement' or gmd:domainCode">if "dataType" = 'codelistElement' then "domainCode" is mandatory</assert>
    <assert
    id="ISO19139.TA1.extShortName"
    flag="E-ISO"
    test="$dataType = 'codelistElement' or gmd:shortName">if "dataType" notEqual 'codelistElement' then "shortName" is mandatory</assert>
  </rule>
  <rule context="gmd:EX_Extent">
    <assert
    id="ISO19139.TA1.extent"
    flag="E-ISO"
    test="gmd:description or gmd:geographicElement
or gmd:temporalElement or gmd:verticalElement">count(description + geographicElement + temporalElement + verticalElement) &gt; 0</assert>
  </rule>
  <rule context="gmd:CI_ResponsibleParty">
    <assert
    id="ISO19139.TA1.responsibleParty:"
    flag="E-ISO"
    test="gmd:individualName or gmd:organisationName or gmd:positionName">count of (individualName + organisationName + positionName) &gt; 0</assert>
  </rule>
  <rule context="gmd:EX_GeographicBoundingBox">
    <assert
    id="ISO19115.B.R344"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:ISO19139.westBoundLongitude"
    flag="E-ISO"
    test="(-180.0 &lt;= number(gmd:westBoundLongitude)) and
    (number(gmd:westBoundLongitude) &lt;= 180.0)"
    >-180,0 &lt;= West Bounding Longitude value &lt;= 180,0</assert>
    <assert
    id="ISO19115.B.R345"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:ISO19139.eastBoundLongitude"
    flag="E-ISO"
    test="(-180.0 &lt;= number(gmd:eastBoundLongitude)) and
    (number(gmd:eastBoundLongitude) &lt;= 180.0)"
    >-180,0 &lt;= East Bounding Longitude value &lt;= 180,0</assert>
    <assert
    id="ISO19115.B.R346"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:ISO19139.southBoundLatitude"
    flag="E-ISO"
    test="(-90.0 &lt;= number(gmd:southBoundLatitude)) and
    (number(gmd:southBoundLatitude) &lt;= 90.0)"
    >-90,0 &lt;= South Bounding Latitude value {<value-of select="number(gmd:southBoundLatitude)"/>} &lt;= 90,0</assert>
    <assert
    id="ISO19115.B.R347a"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:ISO19139.northBoundLatitude"
    flag="E-ISO"
    test="(-90.0 &lt;= number(gmd:northBoundLatitude)) and
    (number(gmd:northBoundLatitude) &lt;= 90.0)"
    >-90,0 &lt;= North Bounding Latitude value {<value-of select="number(gmd:northBoundLatitude)"/>} &lt;= 90,0</assert>
    <assert
    id="ISO19115.B.R347b"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:ISO19139.boundLatitudes"
    flag="E-ISO"
    test="number(gmd:southBoundLatitude) &lt;= number(gmd:northBoundLatitude)"
    >South Bounding Latitude value {<value-of select="number(gmd:southBoundLatitude)"/>} &lt;= North Bounding Latitude value {<value-of select="number(gmd:northBoundLatitude)"/>}</assert>
  </rule>
</pattern>

</schema>
