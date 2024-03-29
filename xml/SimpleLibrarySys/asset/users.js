var user = (function(){	
	var onLogin= function (ev){
		ev.preventDefault();
		var ele = document.getElementById("password");
		var pwd = ele.value;
		ele = document.getElementById("username");
		var name = ele.value;
		console.log(name+pwd);
		
		if(!!!pwd || !!!name){			
			alert("用户名或密码不能为空");
		}
		else if(utils.cookies.get("loginedName") || valid(name,pwd)){	
			utils.cookies.set("loginedName",utils.cookies.get("loginedName") || name,1);
			window.location.reload();
		}else{
			alert("用户名或密码错误");
		}
		
	//	console.log("onLogin called");
		ev.preventDefault();
	};
	var onLogout = function(ev){
	//	alert("logout");
		if(utils.cookies.get("loginedName")){
			utils.cookies.set("loginedName","",-1);
		}
		window.location.reload();
	};
	var onRegister= function (ev){
//		console.log("onRegister called");		
		ev.preventDefault();
		
		var ele = document.getElementById("password");
		var pwd = ele.value;
		ele = document.getElementById("username");
		var name = ele.value;
		
		if(valid(name)){
			alert("已存在用户名");
		}else{
			add(name,pwd);
		}
	};
	
	var valid = function(username,pwd){
		var tmp = utils.loadXML("data/users.xml?"+(new Date()));
		var data = tmp.getElementsByTagName("user");
		console.log(data.length);
		for(var i=0;i<data.length;i++)
		{
			console.log(utils.getAttrValue(data[i],"username"));
			if(utils.getAttrValue(data[i],"username") === username &&(!pwd ||  (pwd && utils.getAttrValue(data[i],"password") === pwd)) ){
				return true;
			}
		}
		return false;
	}
	var xmlhttp; 
	var add = function(username,pwd){
		console.log("xmlhttp");
		xmlhttp= new  window.XMLHttpRequest();
		var url = "data/addUser.php?";
		url += "username="+username;
		url+= "&password="+pwd;
		xmlhttp.open("GET", url, true);
		xmlhttp.send(null);
		xmlhttp.onreadystatechange=state_Change;
			
		function state_Change()
		{
			if (xmlhttp.readyState==4)
			{
				
			  if (xmlhttp.status==200)
				{
					alert("已成功注册，若登录不成功请稍等再试");
				}
			  else
				{
					alert("注册失败!");
				}
			}
		}
	}
	
	return {
		onLogin:onLogin,
		onRegister:onRegister,
		onLogout:onLogout,
		add:add
	};
})();