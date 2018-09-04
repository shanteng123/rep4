<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" doctype-system="about:legacy-compat"/>
  <xsl:template match="*"/>

  <xsl:template match="svn">
    <xsl:variable name="repo" select="/svn/index/@base"/>
    <xsl:variable name="path" select="/svn/index/@path"/>
    <html>
      <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <link rel="icon" href="/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
        <title>
          <xsl:if test="string-length(index/@base) != 0">
            <xsl:value-of select="index/@base"/>
            <xsl:text>: </xsl:text>
          </xsl:if>
          <xsl:value-of select="index/@path"/>
          - VisualSVN Server
        </title>
        <script>
          <![CDATA[
          function getWebInterfaceUrl(repo, path) {
            if (repo && path && path == "/")
            place = encodeURI("#" + repo);
            else if (repo && path)
            place = encodeURI("#" + repo + "/view/head" + path);
            else
            place = "#";

            return "/!/" + place;
          }
          ]]>
        </script>

        <style>
          body{
          font-family:Verdana, Arial, Helvetica, sans-serif;
          font-size:9pt;
          background: #ffffff;
          margin: 0;
          padding: 0;
          }

          img { border: none; }

          a {
          color: navy;
          }

          .header
          {
          text-align: right;
          margin-right: 0.5em;
          clear: both;
          margin-left: 0.5em;
          background: url(/!/assets/img/header.png?v=1) top left no-repeat;
          height: 48px;
          padding: 6px;
          }

          .footer {
          text-align: right;
          margin-top: 1em;
          padding: 0.5em 1em 0.5em;
          font-size: 80%;
          }

          .svn {
          margin-left: 0.5em;
          margin-right: 0.5em;
          }

          .rev {
          margin-right: 3px;
          padding-left: 3px;
          text-align: left;
          font-size: 120%;
          }

          .dir a {
          text-decoration: none;
          color: black;
          display: block;
          }

          .dir img { vertical-align: middle }

          .file a {
          text-decoration: none;
          color: black;
          display: block;
          }

          .file {
          margin: 3px;
          padding: 3px;
          background: rgb(95%,95%,95%);
          }

          .file img { vertical-align: middle }

          .file:hover {
          margin: 3px;
          padding: 3px;
          background: rgb(90%,100%,90%);
          }

          .dir {
          margin: 3px;
          padding: 3px;
          background: rgb(90%,90%,90%);
          }

          .dir:hover {
          margin: 3px;
          padding: 3px;
          background: rgb(80%,100%,80%);
          }

          #top-warning {
          width: 100%;
          padding: 8px;
          font-weight: bold;
          font-size: 13px;
          text-align: center;
          background: #fff9d7;
          border-bottom: 1px solid #CCC;
          }
        </style>
      </head>
      <body>
        <noscript><div id="top-warning">For a better experience enable JavaScript in your browser.</div></noscript>
        <a id="link" />
        <script>
          (function() {
            var url = getWebInterfaceUrl("<xsl:value-of select='$repo'/>", "<xsl:value-of select='$path'/>");

            if (/(MSIE \d+\.\d+;)|(Trident\/\d+\.\d+;)/.test(navigator.userAgent)) {
              var elem = document.getElementById("link");
              elem.href = url;
              elem.click();
            } else {
              window.location.replace(url);
            }
          })();
        </script>
        <div class="header">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:text>http://www.visualsvn.com/server/doc/</xsl:text>
            </xsl:attribute>
            <xsl:text>Help</xsl:text>
          </xsl:element>
        </div>
        <div class="svn">
          <xsl:apply-templates/>
        </div>
        <div class="footer">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:text>http://www.visualsvn.com/server/</xsl:text>
            </xsl:attribute>
            <xsl:text>VisualSVN Server</xsl:text>
          </xsl:element>
          <xsl:text> powered by </xsl:text>
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:text>Subversion</xsl:text>
          </xsl:element>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="index">
    <div class="rev">
      <xsl:value-of select="@name"/>
      <xsl:if test="@base">
        <xsl:if test="@name">
          <xsl:text>:&#xA0; </xsl:text>
        </xsl:if>
        <xsl:value-of select="@base" />
      </xsl:if>
      <xsl:if test="@rev">
        <xsl:if test="@base | @name">
          <xsl:text> &#x2014; </xsl:text>
        </xsl:if>
        <xsl:text>Revision </xsl:text>
        <xsl:value-of select="@rev"/>
      </xsl:if>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="@path"/>
    </div>
    <xsl:apply-templates select="updir"/>
    <xsl:apply-templates select="dir"/>
    <xsl:apply-templates select="file"/>
  </xsl:template>

  <xsl:template match="updir">
    <div class="dir">
      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>

        <img src="/!/assets/img/dir.png?v=1"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:text>..</xsl:text>

      </xsl:element>
    </div>
  </xsl:template>

  <xsl:template match="dir">
    <div class="dir">
      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>

        <img src="/!/assets/img/dir.png?v=1"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="@name"/>

        <xsl:text>/</xsl:text>
      </xsl:element>
    </div>
  </xsl:template>

  <xsl:template match="file">
    <div class="file">
      <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>

        <img src="/!/assets/img/file.png"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="@name"/>

      </xsl:element>
    </div>
  </xsl:template>

</xsl:stylesheet>
