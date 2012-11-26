<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">		
<html>
	<xsl:apply-templates />
</html>
</xsl:template>

<!-- head部分模板匹配
以下是匹配格式之一
	<head>
		<title>简易的图书管理系统</title>
		<csslinks>
			<href>../asset/main.css</href>
		</csslinks>
	</head>
-->
<xsl:template name="head" match="head">
	<head>
	<title>
		<xsl:choose>
			<xsl:when test="normalize-space(title)=''">
				未定义标题
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="title" />
			</xsl:otherwise>
		</xsl:choose>
	</title>
	
	<xsl:for-each select="csslinks">	
		<link>		    
			<xsl:attribute name="rel">StyleSheet</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:value-of select="href"/>
			</xsl:attribute>
			<xsl:attribute name="type">text/css</xsl:attribute>	   
		</link>
	</xsl:for-each>
	</head>
</xsl:template>

<xsl:template name="body"  match="body">
	<body>
		<xsl:for-each select="a">
		    <xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:value-of select="@href"/>
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="@title"/>
			</xsl:attribute>			
			<xsl:value-of select="a"/>
		    </xsl:element>
		</xsl:for-each>	
	</body>
	</xsl:template>
</xsl:stylesheet>