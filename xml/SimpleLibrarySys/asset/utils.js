var utils = (function(){
	var addEvent = (function () {
	  if (document.addEventListener) {
		return function (el, type, fn) {
		  if (el && el.nodeName || el === window) {
			el.addEventListener(type, fn, false);
		  } else if (el && el.length) {
			for (var i = 0; i < el.length; i++) {
			  addEvent(el[i], type, fn);
			}
		  }
		};
	  } else {
		return function (el, type, fn) {
		  if (el && el.nodeName || el === window) {
			el.attachEvent('on' + type, function () { return fn.call(el, window.event); });
		  } else if (el && el.length) {
			for (var i = 0; i < el.length; i++) {
			  addEvent(el[i], type, fn);
			}
		  }
		};
	  }
	 })();
	var loadXML    = function(xmlFile)
	{
		var xmlDoc;
		if(window.ActiveXObject)
		{
			xmlDoc    = new ActiveXObject('Microsoft.XMLDOM');
			xmlDoc.async    = false;
			xmlDoc.load(xmlFile);
		}
		else if (document.implementation&&document.implementation.createDocument)
		{
			xmlDoc    = document.implementation.createDocument('', '', null);
			
			var xmlhttp = new window.XMLHttpRequest();
			xmlhttp.open("GET", xmlFile, false);
			xmlhttp.send(null);
			xmlDoc = xmlhttp.responseXML;
			
		}
		else
		{ 
			alert('您的浏览器不支持xml文件读取,推荐使用IE5.0以上可以解决此问题!');
 			return null;
		}
		
		return xmlDoc;
	};
	var getEleById = function(id){
		return document.getElementById(id);
	};
	function getAttrValue(ele,attrName){
		return  ele.hasAttribute(attrName) && ele.attributes.getNamedItem(attrName).value;
	}
	var getNode = function(xmlDoc,xPath){
		var nodes = xmlDoc.getElementsByTagName(xPath);
		
		return nodes;
	};
	var createNode  = function(xmlDoc,nodeName){
			return xmlDoc.createElement(nodeName);
	};
	
	var set=function (c_name,value,expiredays)
	{
		var exdate=new Date();
		exdate.setDate(exdate.getDate()+expiredays);
		document.cookie=c_name+ "=" +escape(value)+
		((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
		
	};
	var get = function (c_name){
		if (document.cookie.length>0)
		 {
		  c_start=document.cookie.indexOf(c_name + "=")
		  if (c_start != -1)
			{ 
			c_start=c_start + c_name.length+1 
			c_end=document.cookie.indexOf(";",c_start)
			if (c_end==-1) c_end=document.cookie.length
			return unescape(document.cookie.substring(c_start,c_end))
			} 
		  }
		return "";
	};
	return {
		addEvent:addEvent,
		loadXML : loadXML,
		getNode : getNode,
		getEleById:getEleById,
		getAttrValue:getAttrValue,
		createNode:createNode,
		cookies:{
			get:get,
			set:set
		}
	};
	
})();