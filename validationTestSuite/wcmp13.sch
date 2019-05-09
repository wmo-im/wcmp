<?xml-stylesheet type="text/xsl" href="sch_html.xsl"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
 schemaVersion="2014-03-06">
<title>Requirements by WMO Core Metadata Profile v1.3</title>
<ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
<ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
<ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
<ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
<ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>

<include href="iso19139.sch#iso19139rules" />

<pattern id="wcmpbase" xml:id="wcmpbase">
  <rule context="gmd:MD_Metadata">
    <assert
    id="WCMP13.ISO-TS-19139-2007-xml-schema-validation"
    fpi="http://wis.wmo.int/2012/metadata/conf/ISO-TS-19139-2007-xml-schema-validation"
    flag="E-WCMP"
    test="true()"
>6.1.1 Each WIS Discovery Metadata record shall validate without error against the XML schemas defined in ISO/TS 19139:2007.</assert>
    <assert
    id="WCMP13.ISO-TS-19139-2007-rule-based-validation"
    fpi="http://wis.wmo.int/2012/metadata/conf/ISO-TS-19139-2007-rule-based-validation"
    flag="E-WCMP"
    test="true()"
>6.1.2 Each WIS Discovery Metadata record shall validate without error against the rule-based constraints listed in ISO/TS 19139:2007 Annex A (Table A.1).</assert>
    <assert
    id="WCMP13.explicit-xml-namespace-identification"
    fpi="http://wis.wmo.int/2012/metadata/conf/explicit-xml-namespace-identification"
    flag="E-WCMP"
    test="not(.//*[name()=local-name()])"
>6.2.1 Each WIS Discovery Metadata record shall name explicitly all namespaces used within the record; use of default namespaces is prohibited.</assert>
    <assert
    id="WCMP13.gml-namespace-specification"
    fpi="http://wis.wmo.int/2012/metadata/conf/gml-namespace-specification"
    flag="E-WCMP"
    test="not(.//*[namespace-uri() = 'http://www.opengis.net/gml'])"
>6.3.1 Each WIS Discovery Metadata record shall declare the following XML namespace for GML: http://www.opengis.net/gml/3.2.</assert>
    <report
    id="WCMP.metadataStandard"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.metadataStandard"
    flag="N-WCMP"
    test="(string(gmd:metadataStandardName/*) != 'WMO Core Metadata Profile of ISO 19115 (WMO Core), 2003/Cor.1:2006 (ISO 19115), 2007 (ISO/TS 19139)') or
(string(gmd:metadataStandardVersion/*) != '1.3') "
>a WIS Discovery Metadata record may declare compliance with WCMP by
metadataStandardName = &quot;WMO Core Metadata Profile of ISO 19115 (WMO Core), 2003/Cor.1:2006 (ISO 19115), 2007 (ISO/TS 19139)&quot; (currently &quot;<value-of select="string(gmd:metadataStandardName/*)"/>&quot;) and
metadataStandardVersion = &quot;1.3&quot; (currently &quot;<value-of select="string(gmd:metadataStandardVersion/*)"/>&quot;).</report>
    <assert
    id="WCMP13.fileIdentifier-cardinality"
    fpi="http://wis.wmo.int/2012/metadata/conf/fileIdentifier-cardinality"
    flag="E-WCMP"
    test="count(gmd:fileIdentifier) = 1"
>8.1.1 Each WIS Discovery Metadata record shall include one gmd:MD_Metadata/gmd:fileIdentifier attribute</assert>
    <!-- Note: there is no abstract test for
    Requirement 8.1.2: The gmd:MD_Metadata/gmd:fileIdentifier attribute for each WIS Discovery Metadata record shall be unique within the WIS. -->
    <assert
    id="WCMP.fileIdentifier-style"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.fileIdentifier-style"
    flag="W-WCMP"
    test="starts-with(gmd:fileIdentifier/*/text(), 'urn:x-wmo:md:')"
>[&#167;8.1 &#182;5] WMO Core Metadata Profile recommends the use of a URI structure for gmd:fileIdentifier attributes.</assert>
    <assert
    id="WCMP13.WMO_CategoryCode-keyword-cardinality"
    fpi="http://wis.wmo.int/2012/metadata/conf/WMO_CategoryCode-keyword-cardinality"
    flag="E-WCMP"
    test="gmd:identificationInfo/*/gmd:descriptiveKeywords[
      (*/gmd:thesaurusName/*/gmd:title/* = 'WMO_CategoryCode') or
      (*/gmd:thesaurusName/*/gmd:title/*/@xlink:href =
        'http://wis.wmo.int/2012/codelists/WMOCodeLists.xml#WMO_CategoryCode')
      ]
    "
>Requirement 8.2.1: Each WIS Discovery Metadata record shall include at least one keyword from the WMO_CategoryCode code list. [such descriptiveKeywords must be present]</assert>
  </rule>
  <rule context="gmd:descriptiveKeywords[
    (*/gmd:thesaurusName/*/gmd:title/* = 'WMO_CategoryCode') or
    (*/gmd:thesaurusName/*/gmd:title/*/@xlink:href =
      'http://wis.wmo.int/2012/codelists/WMOCodeLists.xml#WMO_CategoryCode')
  ]">
    <let name="kwlist" value="'!weatherObservations!weatherForecasts!meteorology!hydrology!climatology!landMeteorologyClimate!synopticMeteorology!marineMeteorology!agriculturalMeteorology!aerology!marineAerology!oceanography!landHydrology!rocketSounding!pollution!waterPollution!landWaterPollution!seaPollution!landPollution!airPollution!glaciology!actinometry!satelliteObservation!airplaneObservation!observationPlatform!atmosphericComposition!spaceWeather!'" />
    <assert
    id="WCMP13.WMO_CategoryCode-keyword-cardinality"
    fpi="http://wis.wmo.int/2012/metadata/conf/WMO_CategoryCode-keyword-cardinality"
    flag="E-WCMP"
    test="*/gmd:keyword[contains($kwlist,
      concat('!',normalize-space(*/text()),'!'))]"
>Requirement 8.2.1: Each WIS Discovery Metadata record shall include at least one keyword from the WMO_CategoryCode code list. [keyword must be chosen from the list]</assert>
    <assert
    id="WCMP13.WMO_CategoryCode-keyword-theme"
    fpi="http://wis.wmo.int/2012/metadata/conf/WMO_CategoryCode-keyword-theme"
    test="*/gmd:type/gmd:MD_KeywordTypeCode = 'theme'"
    flag="E-WCMP"
>Requirement 8.2.2: Keywords from WMO_CategoryCode code list shall be defined as keyword type “theme”.</assert>
  </rule>
  <rule context="gmd:descriptiveKeywords">
    <!--
    following assert will not fail since XSD defines that
    gmd:thesaurusName and gmd:title are both unrepeatable
    -->
    <assert
    id="WCMP13.keyword-grouping"
    fpi="http://wis.wmo.int/2012/metadata/conf/keyword-grouping"
    test="count(../gmd:descriptiveKeywords/*/gmd:thesaurusName[
      */gmd:title/* = current()/*/gmd:thesaurusName/*/gmd:title/*]) &lt;= 1"
    flag="E-WCMP"
>Requirement 8.2.3: All keywords sourced from a particular keyword thesaurus shall be grouped into a single instance of the MD_Keywords class. [<value-of
select="count(../gmd:descriptiveKeywords/*/gmd:thesaurusName[
      */gmd:title/* = current()/*/gmd:thesaurusName/*/gmd:title/*])"
      /> duplicate gmd:descriptiveKeywords instances with the same thesaurus name]</assert>
    <report
    id="WCMP.keyword-grouping-without-thesaurus"
    fpi="http://wis.wmo.int/2012/metadata/conf/keyword-grouping"
    test="not(*/gmd:thesaurusName[*/gmd:title or @gco:nilReason])"
    flag="N-WCMP"
>It is beneficial to identify and document gmd:thesaurus for gmd:desciptiveKeywords.</report>
  </rule>
  <rule context="gmd:MD_Metadata">
    <assert
    id="WCMP13.geographic-bounding-box"
    fpi="http://wis.wmo.int/2012/metadata/conf/geographic-bounding-box"
    flag="E-WCMP"
    test="(gmd:hierarchyLevel/* = 'nonGeographicDataset') or
    (gmd:identificationInfo/*/gmd:extent/*/gmd:geographicElement/
     gmd:EX_GeographicBoundingBox)"
>Requirement 8.2.4: Each WIS Discovery Metadata record describing geographic
data shall include the description of at least one geographic bounding box defining the spatial extent of the data.</assert>
    <assert
    id="WCMP.atLeastEnglish"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.atLeastEnglish"
    flag="E-WCMP"
    test="(gmd:language/*/@codeListValue = 'en') or
    (gmd:language/*/@codeListValue = 'eng') or 
    (gmd:locale/*/gmd:languageCode/*/@codeListValue = 'en') or 
    (gmd:locale/*/gmd:languageCode/*/@codeListValue = 'eng') "
>Requirement 8.2.5: All information within a metadata record shall, as a minimum, be provided in English within the metadata record.</assert>
    <let name="global_exchange_data"
      value="starts-with(gmd:fileIdentifier/*/text(),
        'urn:x-wmo:md:int.wmo.wis::')"
    />
    <report
    id="WCMP13.fileIdentifier-for-globally-exchanged-data"
    fpi="http://wis.wmo.int/2012/metadata/conf/fileIdentifier-for-globally-exchanged-data"
    flag="N-WCMP"
    test="$global_exchange_data"
    >fileIdentifier (<value-of select="gmd:fileIdentifier"/>) is considered as global distribution.
Requirement 9.2.1: A WIS Discovery Metadata record describing data for global exchange via the WIS shall have a gmd:MD_Metadata/gmd:fileIdentifier attribute formatted as follows (where {uid} is a unique identifier derived from the GTS bulletin or file name): urn:x-wmo:md:int.wmo.wis::{uid}.</report>
    <assert
    id="WCMP13.identification-of-globally-exchanged-data"
    fpi="http://wis.wmo.int/2012/metadata/conf/identification-of-globally-exchanged-data"
    flag="E-WCMP"
    test="not($global_exchange_data) or
    (gmd:identificationInfo/*/gmd:descriptiveKeywords/*[
        ((gmd:thesaurusName/*/gmd:title/* = 'WMO_DistributionScopeCode') or
	(gmd:thesairusName/*/gmd:title/*/@xlink:href =
'http://wis.wmo.int/2012/codelists/WMOCodeLists.xml#WMO_DistributionScopeCode')
        )
        and (gmd:type/* = 'dataCentre')
	and (gmd:keyword = 'GlobalExchange')
      ]
    )"
>Requirement 9.1.1: A WIS Discovery Metadata record describing data for global exchange via the WIS shall indicate the scope of distribution using the keyword “GlobalExchange” of type “dataCenterdataCentre” from thesaurus WMO_DistributionScopeCode.</assert>
    <assert
    id="WCMP13.WMO-data-policy-for-globally-exchangeddata"
    fpi="http://wis.wmo.int/2012/metadata/conf/WMO-data-policy-for-globally-exchangeddata"
    flag="E-WCMP"
    test="not($global_exchange_data) or
    gmd:identificationInfo/*/gmd:resourceConstraints/*/gmd:otherConstraints/*[
      contains('!WMOEssential!WMOAdditional!WMOOther!', concat('!', ., '!'))
    ]"
>Requirement 9.3.1: A WIS Discovery Metadata record describing data for global exchange via the WIS shall indicate the WMO Data License as Legal Constraint (type: “otherConstraints”) using one and only one term from the WMO_DataLicenseCode code list.</assert>
    <assert
    id="WCMP.WMO-data-policy-disambiguity"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:wcmp.WMO-data-policy-disambiguity"
    flag="E-WCMP"
    test="count(
    gmd:identificationInfo/*/gmd:resourceConstraints/*/gmd:otherConstraints/*[
      contains('!WMOEssential!WMOAdditional!WMOOther!', concat('!', ., '!'))
    ]) &lt;= 1"
>[&#167;9.3 &#182;5] The presence of more than one WMO Data Policy statement in a single metadata record yields an ambiguous state; a WIS Discovery Metadata record describing data for global exchange shall declare only a single WMO Data Policy.</assert>
    <assert
    id="WCMP13.GTS-priority-for-globally-exchanged-data"
    fpi="http://wis.wmo.int/2012/metadata/conf/GTS-priority-for-globally-exchanged-data"
    flag="E-WCMP"
    test="not($global_exchange_data) or
    (contains('!GTSPriority1!GTSPriority2!GTSPriority3!GTSPriority4!',
     concat('!', gmd:identificationInfo/*/gmd:resourceConstraints/*/
     gmd:otherConstraints/*, '!'))
    or (gmd:identificationInfo/*/gmd:resourceConstraints/*/
     gmd:otherConstraints/*/@xlink:href
     = 'http://wis.wmo.int/2012/codelists/WMOCodeLists.xml#WMO_GTSProductCategoryCode'
    ))"
>Requirement 9.3.2: A WIS Discovery Metadata record describing data for global exchange via the WIS shall indicate the GTS Priority as Legal Constraint (type: “otherConstraints”) using one and only one term from the WMO_GTSProductCategoryCode code list.</assert>

  </rule>
  <rule context="gmd:dateStamp">
    <assert
    id="WCMP.dateStamp"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.dateStamp"
    flag="E-WCMP"
    test="
    starts-with(translate(*, '0123456789', '9999999999'),'9999-99-99') or
    starts-with(translate(*, '0123456789', '9999999999'),'9999-99-99T99:99:99')
    "
>[&#167;8.1 &#182;9] WMO Core Metadata Profile mandates dateStamp in format YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS.</assert>
  </rule>
  <rule context="gmd:citationDate">
    <assert
    id="WCMP.citationDate"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.citationDate"
    flag="W-WCMP"
    test="
    starts-with(translate(*, '0123456789', '9999999999'),'9999-99-99') or
    starts-with(translate(*, '0123456789', '9999999999'),'9999-99-99T99:99:99')
    "
>[&#167;8.1 &#182;11] WMO Core Metadata Profile recommends citation date in format YYYY-MM-DD or YYYY-MM-DDTHH:MM:SS.</assert>
  </rule>
  <rule context="gmd:contact">
    <assert
    id="WCMP.mdContRole"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.mdContRole"
    flag="W-WCMP"
    test="*/gmd:role/*/@codeListValue = 'pointOfContact'"
>[&#167;8.2 &#182;3] WMO Core Metadata Profile recommends gmd:contact should use role = pointOfContact.</assert>
  </rule>
  <rule context="gmd:identificationInfo/*/gmd:pointOfContact">
    <assert
    id="WCMP.idPocEmail"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.idPocEmail"
    flag="W-WCMP"
    test="*/gmd:contactInfo/*/gmd:address/*/gmd:electronicMailAddress[
    contains(*,'@') or @gco:nilReason or @xlink:href or @uuidref ]"
>[&#167;8.2 &#182;5] WMO Core Metadata Profile recommends email addres described in gmd:pointOfContact.</assert>
  </rule>
  <rule context="gmd:descriptiveKeywords/*[
    (gmd:thesaurusName/*/gmd:title/* = 'WMO_DistributionScopeCode') or
    (gmd:thesairusName/*/gmd:title/*/@xlink:href =
'http://wis.wmo.int/2012/codelists/WMOCodeLists.xml#WMO_DistributionScopeCode')
  ]">
    <assert
    id="WCMP.scope-distribution"
    fpi="tag:cbs-ipet-mdrd@wmo.int,2013-04-19:WCMP.scope-distribution"
    flag="E-WCMP"
    test="gmd:keyword[
      (*/text() = 'GlobalExchange') or
      (*/text() = 'RegionalExchange') or
      (*/text() = 'OriginatingCentre')
    ]"
>[&#167;9.1 &#182;1] The scope of distribution for data within WIS shall be expressed using the following controlled vocabulary: "GlobalExchange", “RegionalExchange” and “OriginatingCentre” (if the scope of distribution is documented).</assert>
  </rule>
</pattern>
</schema>
