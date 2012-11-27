var user = (function(){	
	var onLogin= function (ev){
		ev.preventDefault();
		var ele = document.getElementById("password");
		var pwd = ele.value;
		ele = document.getElementById("username");
		var name = ele.value;
		if(utils.cookies.get("loginedName")){			
			window.location.href="index.xml";
		}else if(valid(name,pwd)){
			utils.cookies.set("loginedName",name,1);
			window.location.href="index.xml";
		}else{
			alert("用户名或密码错误");
		}
		
	//	console.log("onLogin called");
		ev.preventDefault();
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
		var tmp = utils.loadXML("data/users.xml");
	//	console.log(users);
		var data = tmp.getElementsByTagName("user");
		for(var i=0;i<data.length;i++)
		{
			//		console.log(utils.getAttrValue(tmp,"username"));
			if(utils.getAttrValue(data[i],"username") === username && pwd && utils.getAttrValue(data[i],"password") === pwd){
				return true;
			}
		}
		return false;
	}
	var xmlhttp; 
	var add = function(username,pwd){
		console.log("xmlhttp");
		xmlhttp= new window.XMLHttpRequest();
		var url = "data/addUser.php?";
		url += "username="+username;
		url+= "&password="+pwd;
		xmlhttp.open("GET", url, false);
		xmlhttp.send(null);
		xmlhttp.onreadystatechange=state_Change;
			
		function state_Change()
		{
			if (xmlhttp.readyState==4)
			{
			
			  if (xmlhttp.status==200)
				{
					alert("已成功注册，登录不成功请稍等再试");
				}
			  else
				{
					alert("注册失败!");
				}
			}
		}
		return false;
	}
	
	return {
		onLogin:onLogin,
		onRegister:onRegister,
		add:add
	};
})();