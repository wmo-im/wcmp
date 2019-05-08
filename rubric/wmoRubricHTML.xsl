<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml"
  xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:gmx="http://www.isotc211.org/2005/gmx"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink">
  <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
    <xd:desc>
      <xd:p>
        <xd:b>Created for WMO:</xd:b>
        June 12, 2012
      </xd:p>
      <xd:p>
        <xd:b>Author:</xd:b>
        john.kozimor@noaa.gov
      </xd:p>
      <xd:p />
    </xd:desc>
  </xd:doc>
  <!--<xsl:include href="http://www.ngdc.noaa.gov/metadata/published/xsl/isoRubricStars.xsl"/> -->
  <xsl:variable name="title"
    select="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />
  <xsl:variable name="keywordTypeCodeTheme" select="//gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode[@codeListValue='theme']" />
  <xsl:variable name="wmoCatCodeRef"
    select="//gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href='http://www.wmo.int/wmo_categoryCodelist'" />
  <xsl:variable name="wmoCatCodeName"
    select="//gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString[text()='WMO_CategoryCode']"></xsl:variable>
  <xsl:variable name="wmoCatCodes"
    select="//gmd:MD_Keywords/gmd:keyword/gco:CharacterString[text()='weatherObservations' or text()='weatherForecasts' or text()='meteorology' or text()='hydrology' or text()='climatology' or text()='landMeteorologyClimate' or text()='synopticMeteorology' or text()='marineMeteorology' or text()='agriculturalMeteorology' or text()='aerology' or text()='marineAerology' or text()='oceanography' or text()='landHydrology' or text()='rocketSounding' or text()='pollution' or text()='waterPollution' or text()='landWaterPollution' or text()='seaPollution' or text()='landPollution' or text()='airPollution' or text()='glaciology' or text()='actinometry' or text()='satelliteObservation' or text()='airplaneObservation' or text()='observationPlatform']" />
  <xsl:template match="/">

    <!--Spiral Variables - ISO Encoding -->
    <xsl:variable name="isoEncodeValidate"></xsl:variable>
    <xsl:variable name="isoRulesValidate"></xsl:variable>
    <xsl:variable name="namespaceCheck"></xsl:variable>
    <xsl:variable name="gmlNamespaceCheck"></xsl:variable>
    <!--<xsl:variable name="encodingTotal" select="$isoEncodeValidate + $isoRulesValidate + $namespaceCheck + $gmlNamespaceCheck"></xsl:variable> -->
    <xsl:variable name="encodingTotal">
      0
    </xsl:variable>
    <xsl:variable name="encodingMax">
      4
    </xsl:variable>

    <!--Spiral Variables - Table 1 Mandatory ISO Elements -->
    <xsl:variable name="root">
      <xsl:choose>
        <xsl:when test="/gmd:MD_Metadata">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="fileIDCheck">
      <xsl:choose>
        <xsl:when test="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString != ''">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="hierarchyLevelCheck">
      <xsl:choose>
        <xsl:when test="/gmd:MD_Metadata/gmd:hierarchyLevel/gmd:MD_ScopeCode !=''">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="metadataContactCheck">
      <xsl:choose>
        <xsl:when test="/gmd:MD_Metadata/gmd:contact/gmd:CI_ResponsibleParty">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="dateStampCheck">
      <xsl:choose>
        <xsl:when test="(/gmd:MD_Metadata/gmd:dateStamp/gco:DateTime !='') or (/gmd:MD_Metadata/gmd:dateStamp/gco:Date !='')">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--<xsl:variable name="metadataStandardNameCheck">
      <xsl:choose>
      <xsl:when test="/gmd:MD_Metadata/gmd:metadataStandardName/gco:CharacterString[text()='ISO 19115:2003/19139']">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
      </xsl:variable> -->
    <xsl:variable name="metadataStandardNameCheck">
      <xsl:choose>
        <xsl:when test="/gmd:MD_Metadata/gmd:metadataStandardName/gco:CharacterString !=''">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="metadataStandardVersionCheck">
      <xsl:choose>
        <xsl:when test="/gmd:MD_Metadata/gmd:metadataStandardVersion/gco:CharacterString[text()='1.3']">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="resourceRoleCode">
      <xsl:choose>
        <xsl:when
          test="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode !=''">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="mandatoryTotal"
      select="$root + $fileIDCheck + $hierarchyLevelCheck + $metadataContactCheck + $dateStampCheck + $metadataStandardNameCheck + $metadataStandardVersionCheck + $resourceRoleCode" />
    <xsl:variable name="mandatoryMax">
      8
    </xsl:variable>

    <!--Spiral Variables - Discovery Compliance -->
    <xsl:variable name="fileIdentifierOccur">
      <xsl:choose>
        <xsl:when test="count(//gmd:fileIdentifier/gco:CharacterString)=1">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="fileIdentifierUnique">
      <xsl:value-of select="1" />
    </xsl:variable>
    <xsl:variable name="wmoKeywordCheck">
      <xsl:choose>
        <xsl:when test="($wmoCatCodeName and $wmoCatCodes)">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="wmoThemeKeywordCheck">
      <xsl:choose>
        <xsl:when test="($keywordTypeCodeTheme and $wmoCatCodeName)">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="keywordThesaurusGroupCheck"></xsl:variable>
    <xsl:variable name="boundingExtentsExist">
      <xsl:choose>
        <xsl:when
          test="(//gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:westBoundLongitude/gco:Decimal != '')       
					and (//gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:eastBoundLongitude/gco:Decimal != '')       
					and (//gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:northBoundLatitude/gco:Decimal != '')       
					and (//gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:southBoundLatitude/gco:Decimal != '')">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="engLangCheck">
      <xsl:choose>
        <xsl:when test="/gmd:MD_Metadata/gmd:language/gmd:LanguageCode[text()='eng']">
          1
        </xsl:when>
        <xsl:otherwise>
          0
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="discoveryTotal"
      select="$fileIdentifierOccur + $fileIdentifierUnique + $wmoKeywordCheck + $wmoThemeKeywordCheck + $boundingExtentsExist + $engLangCheck"></xsl:variable>
    <xsl:variable name="discoveryMax">
      6
    </xsl:variable>

    <!--Spiral Variables - Global Exchange Compliance -->
    <xsl:variable name="dataCentreKeywordCheck"></xsl:variable>
    <xsl:variable name="fileIdentifierFormat"></xsl:variable>
    <xsl:variable name="legalConstraintLicenseCodeCheck"></xsl:variable>
    <xsl:variable name="legalConstraintGTSProductCategoryCodeCheck"></xsl:variable>
    <xsl:variable name="gecTotal">
      0
    </xsl:variable>
    <xsl:variable name="gecMax">
      4
    </xsl:variable>

    <!--Spiral Variables - Total Score -->
    <xsl:variable name="WMOProfileTotal" select="$encodingTotal + $mandatoryTotal + $discoveryTotal + $gecTotal" />
    <xsl:variable name="WMOProfileMax">
      22
    </xsl:variable>

    <!--Spiral Variables - INSPIRE -->
    <!--<xsl:variable name="resourceUseLimitationExist">
      <xsl:choose>
      <xsl:when test="(/*/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_Constraints/gmd:useLimitation/gco:CharacterString 
      !='')">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
      </xsl:variable>
      <xsl:variable name="qualityReportExist">
      <xsl:choose>
      <xsl:when test="(/*/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report)">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
      </xsl:variable>
      <xsl:variable name="InspireComplianceTotal" select="$resourceUseLimitationExist + $qualityReportExist"/>
      <xsl:variable name="InspireComplianceTotalMax">2</xsl:variable> -->

    <!-- *************** -->
    <html>
      <head>
        <link rel="stylesheet" type="text/css" href="http://ngdc.noaa.gov/metadata/published/views/ngdcBasicStyleTOC.css"
          title="default"></link>
      </head>
      <style type="text/css">
        h1{
        padding-left:2.5%;
        color:black;
        }
        h2.title{
        color:black;
        padding-left:2.5%;
        }
        h2{
        padding-left:2.5%;
        }
        p{
        padding-left:2.5%;
        padding-right:2.5%;
        }
      </style>
      <body>
        <h1>ISO Rubric Report for WMO Profile 1.3</h1>
        <p>
          The
          <a href="https://geo-ide.noaa.gov/wiki/index.php?title=WMO_Metadata_Validation#WMO_Rubric">WMO Rubric</a>
          report identifies ISO metadata elements recommended for creating discovery type metadata.
          The elements defined in this report are based upon the WMO Profile version 1.3. The goal of this report is to assist
          WMO metadata authors with creating and improving metadata
          documentation. The rubric tests for WMO Profile constraints and provides authors with a conformance score along with a metadata
          improvement recommendations. In the future WMO may include
          rubrics categories for additional metadata types, such as data quality and station history.
        </p>
        <P>The rubric report groups validation tests into the following four categories (spirals): Encoding Compliance,
          Mandatory Element Compliance, Discovery Compliance, and Global Exchange Compliance.
          The categories and profile tests are defined in the WMO Core Metadata profile version 1.3 Specification.
        </P>
        <p>The table at the top of the report summarizes the results. Each spiral is represented by a row in the rubric.
          The color coded cell in each row indicates the percent of validation tests passed for the spiral.
          This report is a prototype. The tests for the Encoding Compliance and Global Exchange Compliance spirals have not been
          implented yet. These spirals have a score value of 'n/a'.</p>
        <p> The Mandatory Element Compliance and Discovery Compliance spirals are functioning. The score field is color
          coded green for pass and red for fail. If a test does not pass validation, the recommendation
          field provides metadata authors with improvement guidance. The maximum score for this rubric will be 22 when Encoding
          Compliance and Global Exchange Compliance validation tests are implemented.
          As presently constitued the maximum score is 14</p>
        <p>
          This report is produced using this
          <a href="http://www.ngdc.noaa.gov/metadata/published/xsl/wmoRubricHTML.xsl">stylesheet</a>
          . Please contact
          <a href="mailto:john.kozimor@noaa.gov">John
            Kozimor</a>
          if you have questions or suggestions.
        </p>
        <h2 class="title">
          Title:
          <xsl:value-of select="$title" />
        </h2>
        <!--Profile Score -->
        <a name="Total Spiral" />
        <h2>
          WMO Profile 1.3 Score:
          <xsl:value-of select="$WMOProfileTotal" />
          /
          <xsl:value-of select="$WMOProfileMax" />
        </h2>
        <style>
          table {
          empty-cells : show;
        </style>
        <table width="95%" border="1" cellpadding="2" cellspacing="2" align="center" bgcolor="ECECEE">
          <tr>
            <th>Spiral</th>
            <th>None</th>
            <th>1-33%</th>
            <th>34-66%</th>
            <th>67-99%</th>
            <th>All</th>
          </tr>
          <xsl:call-template name="showColumn">
            <xsl:with-param name="name" select="'Encoding Compliance'" />
            <xsl:with-param name="total" select="$encodingTotal" />
            <xsl:with-param name="max" select="$encodingMax" />
          </xsl:call-template>
          <xsl:call-template name="showColumn">
            <xsl:with-param name="name" select="'Mandatory Element Compliance'" />
            <xsl:with-param name="total" select="$mandatoryTotal" />
            <xsl:with-param name="max" select="$mandatoryMax" />
          </xsl:call-template>
          <xsl:call-template name="showColumn">
            <xsl:with-param name="name" select="'Discovery Compliance'" />
            <xsl:with-param name="total" select="$discoveryTotal" />
            <xsl:with-param name="max" select="$discoveryMax" />
          </xsl:call-template>
          <xsl:call-template name="showColumn">
            <xsl:with-param name="name" select="'Global Exchange Compliance'" />
            <xsl:with-param name="total" select="$gecTotal" />
            <xsl:with-param name="max" select="$gecMax" />
          </xsl:call-template>
        </table>

        <a name="Encoding Compliance" />
        <h2>
          Encoding Compliance:
          <xsl:value-of select="$encodingTotal" />
          /
          <xsl:value-of select="$encodingMax" />
        </h2>
        <table width="95%" align="center" border="1" cellpadding="2" cellspacing="2" bgcolor="ECECEE">
          <tr>
            <th valign="top">Score</th>
            <th valign="top">Profile Test</th>
            <th valign="top">Requirement</th>
            <th valign="top">Recommendation</th>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$isoEncodeValidate" />
            </xsl:call-template>
            <td>6.1.1</td>
            <td valign="top">Metadata record shall validate without error against the XML schemas defined in ISO/TC
              19139:2007.</td>
            <td valign="top">
              Validate the metadata record with the
              <a href="http://wis.wmo.int/2011/schemata/iso19139_2007/schema/gmd/gmd.xsd">ISO 19139:2007</a>
              schema.
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$isoRulesValidate" />
            </xsl:call-template>
            <td>6.1.2</td>
            <td valign="top">Metadata record shall validate without error against the rule-based constraints listed in
              ISO/TS 19139:2007 Annex A (Table A.1).</td>
            <td valign="top">Correct any errors displayed below in the 'Mandatory Element Compliance' section.</td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$namespaceCheck" />
            </xsl:call-template>
            <td>6.2.1</td>
            <td valign="top">Metadata record shall name explicitly all namespaces used within the record; use of default
              namespaces is prohibited.</td>
            <td valign="top">Add a namespace prefix to all metadata elements.</td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$gmlNamespaceCheck" />
            </xsl:call-template>
            <td>6.3.1</td>
            <td valign="top">Metadata record shall declare the following XML namespace for GML:
              http://www.opengis.net/gml/3.2.</td>
            <td valign="top">
              Define the gml namespace as follows:
              <br />
              xmlns:gml="http://www.opengis.net/gml/3.2"
            </td>
          </tr>
        </table>

        <a name="Mandatory Element Compliance" />
        <h2>
          Mandatory Element Compliance:
          <xsl:value-of select="$mandatoryTotal" />
          /
          <xsl:value-of select="$mandatoryMax" />
        </h2>
        <table width="95%" align="center" border="1" cellpadding="2" cellspacing="2" bgcolor="ECECEE">
          <tr>
            <th valign="top">Score</th>
            <th valign="top">Table A.1 Rownum</th>
            <th valign="top">Element</th>
            <th valign="top">Definition</th>
            <th valign="top">Recommendation</th>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$root" />
            </xsl:call-template>
            <td>1</td>
            <td valign="top">MD_Metadata</td>
            <td valign="top">Root entity which defines metadata about a resource or resources</td>
            <td valign="top">Change the root element to: gmd:MD_Metadata</td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$fileIDCheck" />
            </xsl:call-template>
            <td>2</td>
            <td valign="top">fileIdentifier</td>
            <td valign="top">Unique identifier for this metadata file</td>
            <td valign="top">
              Add a unique metadata identifier:
              <br />
              /gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$hierarchyLevelCheck" />
            </xsl:call-template>
            <td>6</td>
            <td valign="top">hierarchyLevel</td>
            <td valign="top">Scope to which the metadata applies</td>
            <td valign="top">
              Add a hierarchyLevel scope code:
              <br />
              /gmd:MD_Metadata/gmd:hierarchyLevel/gmd:MD_ScopeCode
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$metadataContactCheck" />
            </xsl:call-template>
            <td>8</td>
            <td valign="top">contact</td>
            <td valign="top">Party responsible for the metadata</td>
            <td valign="top">
              Add a metadata contact:
              <br />
              /gmd:MD_Metadata/gmd:contact/gmd:CI_ResponsibleParty
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$dateStampCheck" />
            </xsl:call-template>
            <td>9</td>
            <td valign="top">datestamp</td>
            <td valign="top">Date that the metadata was created or revised</td>
            <td valign="top">
              Add a metadata dateStamp
              <br />
              /gmd:MD_Metadata/gmd:dateStamp/gco:Date or
              <br />
              /gmd:MD_Metadata/gmd:dateStamp/gco:DateTime
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$metadataStandardNameCheck" />
            </xsl:call-template>
            <td>10</td>
            <td valign="top">metadataStandardName</td>
            <td valign="top">name of the metadata standard (including profile name) used</td>
            <td valign="top">
              Add value 'ISO 19115:2003/19139' to metadataStandardName element:
              <br />
              /gmd:MD_Metadata/gmd:metadataStandardName/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$metadataStandardVersionCheck" />
            </xsl:call-template>
            <td>11</td>
            <td valign="top">metadataStandardVersion</td>
            <td valign="top">Version of the metadata standard (version of the profile) used</td>
            <td valign="top">
              Add value '1.3' to metadataStandardVersion element:
              <br />
              /gmd:MD_Metadata/gmd:metadataStandardVersion/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$resourceRoleCode" />
            </xsl:call-template>
            <td>15</td>
            <td valign="top">identificationInfo (role)</td>
            <td valign="top">Basic information about the resource(s) to which the metadata applies</td>
            <td valign="top">
              Add a resource identification role code
              <br />
              /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode
            </td>
          </tr>
        </table>

        <a name="Discovery Compliance" />
        <h2>
          Discovery Compliance:
          <xsl:value-of select="$discoveryTotal" />
          /
          <xsl:value-of select="$discoveryMax" />
        </h2>
        <table width="95%" align="center" border="1" cellpadding="2" cellspacing="2" bgcolor="ECECEE">
          <tr>
            <th valign="top">Score</th>
            <th valign="top">Profile Test</th>
            <th valign="top">Requirement</th>
            <th valign="top">Recommendation</th>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$fileIdentifierOccur" />
            </xsl:call-template>
            <td>8.1.1</td>
            <td valign="top">The metadata record shall include one gmd:MD_Metadata/gmd:fileIdentifier attribute.
            </td>
            <td valign="top">
              Include just one fileIdentifier element
              <br />
              /gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$fileIdentifierUnique" />
            </xsl:call-template>
            <td>8.1.2</td>
            <td valign="top">The gmd:MD_Metadata/gmd:fileIdentifier element for each Metadata record shall be unique within
              the WIS.</td>
            <td valign="top">Update the fileIdentifier uuid value</td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$wmoKeywordCheck" />
            </xsl:call-template>
            <td>8.2.1</td>
            <td valign="top">The metadata record shall include at least one keyword from the WMO_CategoryCode codelist and
              the keyword thesaurus shall be set to WMO_CategoryCode.</td>
            <td valign="top">
              Set a keyword thesaurus value to 'WMO_CategoryCode'
              <br />
              //gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString
              <br />
              Set at least one keyword value to a WMO_Category Code
              <br />
              //gmd:MD_Keywords/gmd:keyword/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$wmoThemeKeywordCheck" />
            </xsl:call-template>
            <td>8.2.2</td>
            <td valign="top">Keywords from WMO_CategoryCode code list shall be defined as keyword type “theme”.</td>
            <td valign="top">
              Set keyword type to 'theme' when keyword thesaurus is WMO_CategoryCode
              <br />
              //gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode='theme'
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$keywordThesaurusGroupCheck" />
            </xsl:call-template>
            <td>8.2.3</td>
            <td valign="top">All keywords sourced from a particular keyword thesaurus shall be grouped into a single
              instance of the MD_Keywords class.</td>
            <td valign="top">
              Consolodate all WMO Category Keywords into a single MD_Keywords object where the thesaurus name is
              WMO_CategoryCode
              <br />
              //gmd:MD_Keywords/gmd:keyword/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$boundingExtentsExist" />
            </xsl:call-template>
            <td>8.2.4</td>
            <td valign="top">Metadata record describing geographic data shall include the description of at least one
              geographic bounding box defining the spatial extent of the data.</td>
            <td valign="top">
              Add a bounding box to define the spatial extent of the data
              <br />
              /gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox/gmd:westBoundLongitude/gco:Decimal
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="$engLangCheck" />
            </xsl:call-template>
            <td>8.2.5</td>
            <td valign="top">All information contained within a metadata record shall, as a minimum, be provided in English
              within the metadata record.</td>
            <td valign="top">
              Document the metadata record in English and define the language code as english
              <br />
              /gmd:MD_Metadata/gmd:language/gco:LanguageCode='en'
            </td>
          </tr>
        </table>

        <a name="Global Exchange Compliance" />
        <h2>
          Global Exchange Compliance:
          <xsl:value-of select="$gecTotal" />
          /
          <xsl:value-of select="$gecMax" />
        </h2>
        <table width="95%" align="center" border="1" cellpadding="2" cellspacing="2" bgcolor="ECECEE">
          <tr>
            <th valign="top">Score</th>
            <th valign="top">Profile Test</th>
            <th valign="top">Requirement</th>
            <th valign="top">Recommendation</th>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="not" />
            </xsl:call-template>
            <td>9.1.1</td>
            <td valign="top">Metadata record shall indicate the scope of distribution using the keyword “GlobalExchange” of
              type “dataCentre” from thesaurus WMO_DistributionScopeCode.</td>
            <td valign="top">
              Add a MD_Keywords object where thesaurusName is 'WMO_DistributionScopeCode', keywordTypeCode is
              'dataCentre' and keyword is 'GlobalExchange'
              <br />
              //gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString
              <br />
              //gmd:MD_Keywords/gmd:type/gmd:MD_KeywordTypeCode
              <br />
              //gmd:MD_Keywords/gmd:keyword/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="not" />
            </xsl:call-template>
            <td>9.2.1</td>
            <td valign="top">"Metadata record shall have a gmd:MD_Metadata/gmd:fileIdentifier attribute formatted as
              follows (where {uid} is a unique identifier derived from the GTS bulletin or file name): urn:xwmo:
              md:int.wmo.wis::{uid}."
            </td>
            <td valign="top">
              Format the metadata fileIdentifier with this pattern 'urn:xwmo: md:int.wmo.wis::{uid}'
              <br />
              /gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="not" />
            </xsl:call-template>
            <td>9.3.1</td>
            <td valign="top">Metadata record shall indicate the WMO Data License as Legal Constraint (type:
              “otherConstraints”) using one and only one term from the WMO_DataLicenseCode code list.</td>
            <td valign="top">
              Populate the otherConstraints element with one of the following values; WMOEssential, WMOAdditional, 
              WMOOther or NoLimitation
              <br />
              //gmd:resourceConstraints/gmd:MD_LegalConstraints//gmd:otherConstraints/gco:CharacterString
            </td>
          </tr>
          <tr>
            <xsl:call-template name="showScore">
              <xsl:with-param name="score" select="not" />
            </xsl:call-template>
            <td>9.3.2</td>
            <td valign="top">Metadata record shall indicate the GTS Priority as Legal Constraint (type: “otherConstraints”)
              using one and only one term from the WMO_GTSProductCategoryCode code list.</td>
            <td valign="top">
              Populate a second otherConstraints element with one of the following values; GTSPriority1, GTSPriority2,
              GTSPriority3 or GTSPriority4
              <br />
              //gmd:resourceConstraints/gmd:MD_LegalConstraints//gmd:otherConstraints/gco:CharacterString
            </td>
          </tr>
        </table>

      </body>
    </html>
  </xsl:template>
  <xsl:template name="showColumn">
    <xsl:param name="name" />
    <xsl:param name="total" />
    <xsl:param name="max" />
    <xsl:variable name="column">
      <xsl:choose>
        <xsl:when test="$total=0">
          0
        </xsl:when>
        <xsl:when test="$total=$max">
          4
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="floor(number(number($total) * 3 div number($max)))+1" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr border="1">
      <td width="20%">
        <a href="#{$name}">
          <xsl:value-of select="$name" />
        </a>
      </td>
      <xsl:choose>
        <xsl:when test="$column=0">
          <td align="center" bgcolor="CC00CC" />
        </xsl:when>
        <xsl:otherwise>
          <td />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$column=1">
          <td align="center" bgcolor="CC00CC" />
        </xsl:when>
        <xsl:otherwise>
          <td />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$column=2">
          <td align="center" bgcolor="CC00CC" />
        </xsl:when>
        <xsl:otherwise>
          <td />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$column=3">
          <td align="center" bgcolor="CC00CC" />
        </xsl:when>
        <xsl:otherwise>
          <td />
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$column=4">
          <td align="center" bgcolor="CC00CC" />
        </xsl:when>
        <xsl:otherwise>
          <td />
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>
  <xsl:template name="showScore">
    <xsl:param name="score" />
    <xsl:choose>
      <xsl:when test="$score=1">
        <td align="center" bgcolor="66CC66">
          <xsl:value-of select="$score" />
        </td>
      </xsl:when>
      <xsl:when test="$score=0">
        <td align="center" bgcolor="FF0033">
          <xsl:value-of select="$score" />
        </td>
      </xsl:when>
      <xsl:otherwise>
        <td align="center">
          <xsl:value-of select="'n/a'" />
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>