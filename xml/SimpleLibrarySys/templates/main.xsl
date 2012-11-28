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
		<div class="logo">
			<xsl:value-of select="@logo" />
		</div>		
		<div  class="left-side">
		<xsl:call-template name="A"  >
		</xsl:call-template>		
		
		<xsl:call-template name="Login"  >
		</xsl:call-template>
		<div style="font-size:16px;color:#77aa88;position:absolute;left:10px;top:10px;">在IE6.0，FireFox下本地测试通过
		</div>
		<!-- search ,type-->
		
		
		<xsl:call-template name="Panel"  >
		</xsl:call-template>
		
		</div>
		
		
		
		<div class="right-side">
		<xsl:call-template name="Shoppingcart"  />
		
		<xsl:call-template name="BooksNav"  >
		</xsl:call-template>
		
		<xsl:call-template name="Books"  >
		</xsl:call-template>
		</div>
		<div style="clear:both;"></div>
		<div id="footer"></div>
	</body>	
	</xsl:template>	
	
	<!-- shoppingcart -->
	<xsl:template name="Shoppingcart">
		<xsl:for-each select="shoppingcart">
		<div class="shoppingcart">
		<table id="shoppingcart">
			<tr>
				<th>书名</th>
				<th>价格</th>
				<th>数量</th>
			</tr>
			<xsl:for-each select="item">
				<tr>
					<td><xsl:value-of select="@name" /></td>
					<td><xsl:value-of select="@price" /></td>
					<td><xsl:value-of select="@count" /></td>
				</tr>
			</xsl:for-each>
		</table>
		<p>总价:<span class="total-price">77</span></p>
		</div>
		</xsl:for-each>
	</xsl:template>

	<!-- Panel -->
	<xsl:template name="Panel">
		<xsl:for-each select="panel">
		<div class="panel">
		<xsl:choose>
			<xsl:when test="@title!=''">
			<span><xsl:value-of select="@title"/></span>
			</xsl:when>
			<xsl:otherwise>
				
			</xsl:otherwise>
		</xsl:choose>
		<ul>
		<xsl:for-each select="item">
			<li>
				<xsl:choose>
					<xsl:when test="@type='a'">
						<a title="点击" class="buy">
							<xsl:attribute name="href">
								<xsl:value-of select="@href" />
							</xsl:attribute>
							<xsl:attribute name="target">
								<xsl:value-of select="@target" />
							</xsl:attribute>
							<xsl:value-of select="." />
						</a>
					</xsl:when>	
					<xsl:when test="@type='search'">
						<p>
						<input id="search_words" title="书的类别作为关键字" type="text" value="科幻"  style="width:60%;"/>
						<input title="搜索即可" id="search_btn" type="button" value="搜索" />
						</p>
					</xsl:when>	
					<xsl:otherwise>
							<xsl:value-of select="." />						
					</xsl:otherwise>				
				</xsl:choose>
			</li>
		</xsl:for-each>
		</ul>
		<div class="clear-left"></div>
		</div>
		</xsl:for-each>
	</xsl:template>
	
	<!-- BooksNav -->
	<xsl:template name="BooksNav">
	<xsl:for-each select="booksNav">				
		<div class="books-nav">
			<ul>
				<li><span>热门分类: </span></li>	
				<xsl:for-each select="item">
				<li>	
					<a  >
					<xsl:attribute name="href">
						<xsl:value-of select="@href" />
					</xsl:attribute>
					<xsl:attribute name="title">
						<xsl:value-of select="." />
					</xsl:attribute>
					<xsl:value-of select="." />
					</a>
				</li>
				</xsl:for-each>
			</ul>
		</div>
		</xsl:for-each>
	</xsl:template>
		
	<!-- books -->
	
	<xsl:template name="Books">
		<xsl:for-each select="books/book">
		<div class="book">
			<div class="bookimg">
			<xsl:element name="img">
				<xsl:attribute name="src">
					<xsl:value-of  select="img/@href" />
				</xsl:attribute>
				<xsl:attribute name="alt">
					<xsl:value-of  select="@name" />
				</xsl:attribute>
				<xsl:attribute name="title">
					<xsl:value-of  select="@name" />
				</xsl:attribute>
			</xsl:element>
			</div>
			<div class="bookinfo">
			<p>
			<a href="#" title="放入购物车" class="buy" id="buy_link">	
			放入购物车 
			</a>		
			</p>
			<p>
			<span>	作者： </span>		
			<xsl:value-of  select="@author" />
			</p>
			<p>
			<span>	类别： </span>		
			<span class="type">
				<xsl:value-of  select="@type" />
			</span>
			</p>
			<p><span>	简介： </span>			
			<xsl:value-of  select="desc" />
			</p>
			</div>
		</div>
		</xsl:for-each>	
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
				<a  id="register_link" title="输入信息点击即可注册，可能有1分钟延迟">		
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