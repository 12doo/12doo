//检测一个字符串是否全是数字
function checkNum(str) {
	return str.match(/\D/) == null;
} 
//获取选中的值 
function getValueOfSelect(id) {
	var objs = document.getElementById(id);
	if(objs==null){
 		return;
 	}
 	if(objs.selectedIndex>=0){
 		return objs.options[objs.selectedIndex].value;
 	}
 	return "";
	 
}

//设置选中项目 
function setValueOfSelect(id, value) {
	var objs = document.getElementById(id);
	for (var i = 0; i < objs.options.length; i++) {
		if (objs.options[i].value == value) {
			objs.options[i].selected = "selected";
		}
	}
}

//获取选中的单选按钮的值 
function getRadioCheckedValue(radioName) {
	var value = "";
	var objs = document.getElementsByName(radioName);
	for (var i = 0; i < objs.length; i++) {
		if (objs[i].checked) {
			value = objs[i].value;
		}
	}
	return value;
}

///单选框都不选中 
function radioDoNotChecked(radioName) {
	var value = "";
	var objs = document.getElementsByName(radioName);
	for (var i = 0; i < objs.length; i++) {
		objs[i].checked = false;
	}
}

function divContentRoll(topDiv,contentDiv , tempDiv) {
/**topDiv 中包含contentDiv(内容) 和tempDiv (交换数据用)
*/
	  var speed=60;
	var demo=document.getElementById(topDiv);
	var demo1=document.getElementById(contentDiv);
	var demo2=document.getElementById(tempDiv);
	demo2.innerHTML=demo1.innerHTML;
	function Marquee(){
	 if((demo2.offsetTop-demo.scrollTop)<=0){
	  	demo.scrollTop = 0;
	 }else{
	  	demo.scrollTop++;
	 }
	}
	var MyMar=setInterval(Marquee,speed);
	demo.onmouseover = function(){
		clearInterval(MyMar);
	};
	demo.onmouseout = function(){
		MyMar=setInterval(Marquee,speed);
	};
}

//截取字符串 
function countCharacters(str, size) {
	var totalCount = 0;
	var newStr = "";
	for (var i = 0; i < str.length; i++) {
		var c = str.charCodeAt(i);
		if ((c >= 1 && c <= 126) || (65376 <= c && c <= 65439)) {
			totalCount++;
		} else {
			totalCount += 2;
		}
		if (totalCount < size) {
			newStr = str.substring(0, i + 1);
		} else {
			return newStr + "...";
		}
	}
	return newStr;
} 


//验证字符长度 by liuxb 
function validateLength(str, size) {
	var totalCount = 0;
	var newStr = "";
	for (var i = 0; i < str.length; i++) {
		var c = str.charCodeAt(i);
		if ((c >= 1 && c <= 126) || (65376 <= c && c <= 65439)) {
			totalCount++;
		} else {
			totalCount += 2;
		}
		if (totalCount > size) {
			return false;
		}
	}
	return true;
} 

//自动换行 by liuxb 
function autoNewLine(str, size) {
	beginPos = 0;
	var totalCount = 0;
	var newStr = "";
	for (var i = 0; i < str.length; i++) {
		var c = str.charCodeAt(i);
		if ((c >= 1 && c <= 126) || (65376 <= c && c <= 65439)) {
			totalCount++;
		} else {
			totalCount += 2;
		}
		if (totalCount >= size) {
			newStr += str.substring(beginPos , i+1)+"<br/>";
			totalCount = 0;
			beginPos = i+1;
		}
	}
	if(beginPos !=str.length){
		newStr+=str.substr(beginPos);
	}
	return newStr;
} 


//是否是手机号
function isMobile(_str) {
	var tmp_str = _str;
	var pattern = /1\d{10}/;
	if (pattern.test(tmp_str)) {
		if (tmp_str.length != 11) {
			return false;
		} else {
			return true;
		}
	} else {
		return false;
	}
}
//检测Email格式是否正确
function verifyAddress(email) {
	var pattern = /^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
	var flag = pattern.test(email);
	if (flag) {
		return true;
	}
	return false;
}


//login box
var loginDiv = null;
var loginSucBack = null;
//显示loginDIV
function showLoginDiv(loginBack ){
    //document.getElementById("loginDivName").value='';
	//document.getElementById("loginDivPassword").value='';
 	loginSucBack = loginBack;
     loginDiv=new LightBox("loginDiv");
 	 loginDiv.Center=true;
	 loginDiv.Fixed=true;
	 loginDiv.Show();
	//Press Escape event!
	$(document).keypress(function(e){
		if(e.keyCode==27){
			hiddenLoginDiv();
			
		}
	});
}
 
//隐藏loginDIV
function hiddenLoginDiv(){
	  loginDiv.Close();
	  loginSucBack = null;
} 
//提交loginDIV 
 function submitLoginDiv(){
	var loginSelf = document.getElementsByName("flagLoginDivSelf");
	var flag = false;
	for(i=0;i<loginSelf.length;i++) {  
	  if(loginSelf[i].checked) {  
		  flag=true; 
		  break;  
		}   
	}
	if(flag){
		document.getElementById("flagLoginDivSelf").value="1";
	}else{
		document.getElementById("flagLoginDivSelf").value="0";
	}
	var loginNameObj = document.getElementById("loginDivName");
	if($.trim(loginNameObj.value) == ""){
		alert("请输入用户名！");
		loginNameObj.focus();
		return;
	}
	var loginPwdObj = document.getElementById("loginDivPassword");
	if($.trim(loginPwdObj.value) == ""){
		alert("请输入密码！");
		loginPwdObj.focus();
		return;
	}
	$.ajax({
	   type: "POST",
	   url: "/portal/loginjs.jspa",
	   data: "flagLoginSelf="+$("#flagLoginDivSelf").val()+"&loginName="+loginNameObj.value+"&loginPassword="+loginPwdObj.value,
	   dataType:'json',
	   success: function(json){
	   		if(json.flag>0){
	   			loadTop2(); 
	   			try{
	   		    	eval(loginSucBack);
	   		    }catch(e){
	   		        alert(e.message);
	   		    }
	   			hiddenLoginDiv();
	   		}else{
	   			alert(json.msg);
	   		}
	   }
	})
}


//忘记密码
function forgetPwd(){
   hiddenLoginDiv();
   window.location.href= '/portal/login_retrieve_password.jsp';
}

 


function lenReg(str){
    return str.replace(/[^\x00-\xFF]/g,'**').length;
}

function formatDoubleValue(value, symbols ) {//转换成double 类型 ，小数点后symbols位 
 	return parseFloat(value).toFixed(symbols);
}

var baseImg = "http://img05.yesmywine.com/"; 
function getImgsrc_1(goodsId) {
	return baseImg + goodsId + "/60x98.jpg";
}
function getImgsrc_11(num,goodsId) {
	//return baseImg + goodsId + "/60x98.jpg";
	baseUrl = "http://img"+(19-num%5)+".yesmywine.com/";
	return baseUrl + goodsId + "/60x98.jpg";
}
function getImgsrc_2(goodsId) {
	return baseImg + goodsId + "/110x180.jpg";
}
function getImgsrc_22(num,goodsId) {
	//return baseImg + goodsId + "/110x180.jpg";
	baseUrl = "http://img"+(15+num%5)+".yesmywine.com/";
	//alert(baseUrl);
	return baseUrl + goodsId + "/110x180.jpg";
}
function getImgsrc_3(goodsId) {
	return baseImg + goodsId + "/220x360.jpg";
}
function getImgsrc_4(goodsId) {
	return baseImg + goodsId + "/380x620.jpg";
}

