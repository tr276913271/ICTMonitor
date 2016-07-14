var agentID = '';
var sttime = 0;
var endtime = 0;

// 获取url中参数的值
function getUrlParam(name) {
	var reg = new RegExp("(^|\\?|&)"+ name +"=([^&]*)(\\s|&|$)", "i");
	if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " ")); return "";
}
// 初始化赋值
function getParams() {
	agentID = getUrlParam('agentID')?getUrlParam('agentID'):'';
	sttime = getUrlParam('sttime')?getUrlParam('sttime'):0;
	endtime = getUrlParam('endtime')?getUrlParam('endtime'):0;
}
function initFormPlugin(){
	if (sttime != 0 && endtime != 0) {
		var d = new Date();
		d.setTime(sttime);
		$('input[name=from]').val(d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate() + d.getHours() + ':' + d.getMinutes());
	    $('input[name=from]').appendDtpicker();
		d.setTime(endtime);
		$('input[name=to]').val(d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate() + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());
	    $('input[name=to]').appendDtpicker();
	} else {
		var d = new Date();
	    //alert(d.getTime());
	    $('input[name=to]').val(d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate() + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());
	    $('input[name=to]').appendDtpicker();
	    sttime = d.getTime();
	    d.setDate(d.getDate() - 1);
	    $('input[name=from]').val(d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate() + d.getHours() + ':' + d.getMinutes());
	    $('input[name=from]').appendDtpicker();
	    endtime = d.getTime();
	}
}

$(document).ready(function(){
	getParams();
	initFormPlugin();
});

function navjump(ind) {
	var jumpurl = "/stewardweb/";
	switch(ind) {
		case 0:
			jumpurl += 'topo.do';
		break;
		case 1:
			jumpurl += 'performance.do';
		break;
		case 2:
			jumpurl += 'appLoad.do';
		break;
		case 3:
			jumpurl += 'slowCall.do';
		break;
		case 4:
			jumpurl += 'wrongCall.do';
		break;
		default:
			jumpurl += 'topo.do';
		break;
	}
	jumpurl = jumpurl + '?agentID=' + agentID;
	if (sttime != 0) {
		jumpurl = jumpurl + '&sttime=' + sttime;
	}
	if (endtime != 0) {
		jumpurl = jumpurl + '&endtime=' + endtime;
	}
	window.location.href = jumpurl;
//	alert(jumpurl);
}
//$("ul.headermenu>li").click(function(){
//	var ind = $("ul.headermenu>li").index(this);
//	var jumpurl = "/stewardweb/";
//	switch(ind) {
//		case 0:
//			jumpurl += 'topo.do';
//		break;
//		case 1:
//			jumpurl += 'performance.do';
//		break;
//		case 2:
//			jumpurl += 'appLoad.do';
//		break;
//		case 3:
//			jumpurl += 'slowCall.do';
//		break;
//		case 4:
//			jumpurl += 'wrongCall.do';
//		break;
//		default:
//			jumpurl += 'topo.do';
//		break;
//	}
//	jumpurl = jumpurl + '?agentID=' + agentID;
//	if (sttime != 0) {
//		jumpurl = jumpurl + '&sttime=' + sttime;
//	}
//	if (endtime != 0) {
//		jumpurl = jumpurl + '&endtime=' + endtime;
//	}
//	alert(jumpurl);
//});
