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
	var createTag = function(tagName){
		return document.createElement(tagName);
	};
	var getQueryString = function (name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
		var r = window.location.search.substr(1).match(reg);
		if (r != null) {
			return unescape(r[2]); 
		}
		return null;
    };
	var queryAll  = function(ele,param){
	for(var i=0;i<3;i++){
		
	}
		return ele.querySelectorAll(param);
	};
	var query  = function(ele,param){
		return ele.querySelector(param);
	};
	var hide= function(ele){
		ele.style.display = "none";
	};
	var show=function(ele){
		ele.style.display = "block";
	};
	var attr = function(ele,att,value){
		if(value){
			ele.setAttribute(att,value);
		}else{
			return ele.getAttribute(att);
		}
	};
	var getBaseURL = function(){
		return document.URL.split("?")[0];
	};
	return {
		addEvent:addEvent,
		loadXML : loadXML,
		getNode : getNode,
		getEleById:getEleById,
		getAttrValue:getAttrValue,
		createNode:createNode,
		createTag:createTag,
		getQueryString:getQueryString,
		queryAll:queryAll,
		query:query,
		hide:hide,
		show:show,
		attr:attr,
		getBaseURL:getBaseURL,
		cookies:{
			get:get,
			set:set
		}
	};
	
})();

var bookado = (function(){
		
		var selectByType = function(type){
			var books = utils.queryAll(document,".book");
						
			//console.log("type= "+type+",book len= "+books.length);
			
			for(var i=0,len=books.length;i<len;i++){
				var typenode = utils.query(books[i],".type");
				
				console.log("bookNode type "+typenode.innerHTML+" select type= "+type);
				if(typenode && typenode.innerHTML && typenode.innerHTML.indexOf(type) !== -1){
					utils.show(books[i]);
					console.log("show");
				}else{
					utils.hide(books[i]);
					console.log("hide");
				}
			}
		};
		return {
			selectByType:selectByType
		};
	
})();