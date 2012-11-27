<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


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
	
	<xsl:for-each select="csslinks/href">	
		<xsl:element name="link">	    
			<xsl:attribute name="rel">StyleSheet</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:value-of select="."/>
			</xsl:attribute>
			<xsl:attribute name="type">text/css</xsl:attribute>	   
		</xsl:element>	    
	</xsl:for-each>
	<xsl:for-each select="scriptlinks/script">	
		<xsl:element name="script">	    
			<xsl:attribute name="type">text/javascript</xsl:attribute>
			<xsl:choose>
				<xsl:when test="normalize-space(@href)=''">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="src">
						<xsl:value-of select="@href"/>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
	   
		</xsl:element>	    
	</xsl:for-each>
	
	</head>
</xsl:template>

<xsl:template match="body" >
	<body >
		<xsl:attribute name="class" >		
			<xsl:value-of select="@class"/>
		</xsl:attribute>		
		<xsl:call-template name="A"  >
			<xsl:param name="a" select="a"/>
		</xsl:call-template>		
		
		<xsl:call-template name="Login"  >
			<xsl:param name="login" select="login"/>
		</xsl:call-template>
		
		
	</body>	
	</xsl:template>	
	
	
	
	
	<!-- a -->
	<xsl:template name="A">
	<xsl:param name="a"/>
		<xsl:for-each select="a">
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:value-of select="@href"/>
				</xsl:attribute>
				<xsl:attribute name="title">
					<xsl:value-of select="@title"/>
				</xsl:attribute>			
				<xsl:value-of select="."/>
		    </xsl:element>
		</xsl:for-each>	
	</xsl:template>
	
	<!-- Login -->
	<xsl:template name="Login">
		<xsl:param name="login"/>
		<xsl:for-each select="login">
		<div id="login">
			<xsl:attribute name="class">
				<xsl:value-of select="@class" />
			</xsl:attribute>
		<form>
			<ul >
				<li>
				<label for="username">用户名:</label>
				<input id="username" type="text" title="输入用户名" />
				</li>
				<li>
				<label for="password">密码: </label>
				<input id="password" type="password" title="请输入密码" />
				</li>
				<li >
				<a  id="login_link" title="登录">
				<xsl:attribute name="href">
					<xsl:value-of select="login_href" />
				</xsl:attribute>登录</a>
				<a  id="register_link" title="输入信息点击即可注册">		
				<xsl:attribute name="href">
					<xsl:value-of select="register_href" />
				</xsl:attribute>注册</a>
				</li>
			<div style="clear:both;"></div>
			</ul>
		</form>
		</div>
		</xsl:for-each>
		</xsl:template>
</xsl:stylesheet>