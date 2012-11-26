var http_mod = require("http");
var url_mod = require("url");
var config = {
		port:8090
	};
function start(route,handle){
	function onRequest(request,response){
	var sPathname = url_mod.parse(request.url).pathname;
	console.log("Request for "+sPathname+"received.");
	
	route(handle,sPathname,response);
	}
	http_mod.createServer(onRequest).listen(config.port);
	console.log("Server has started and listened on  port "+config.port);
}

exports.start = start;
exports.config = config;