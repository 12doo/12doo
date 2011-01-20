function scrollDoor(){
}
scrollDoor.prototype = {
sd : function(menus,divs,openClass,closeClass){
var _this = this;
if(menus.length != divs.length)
{
alert("˵ݲһ!");
return false;
}
for(var i = 0 ; i < menus.length ; i++)
{
_this.$(menus[i]).value = i;
_this.$(menus[i]).onmouseover = function(){
for(var j = 0 ; j < menus.length ; j++)
{
_this.$(menus[j]).className = closeClass;
_this.$(divs[j]).style.display = "none";
}
_this.$(menus[this.value]).className = openClass;
_this.$(divs[this.value]).style.display = "block";
}
}
},
$ : function(oid){
if(typeof(oid) == "string")
return document.getElementById(oid);
return oid;
}
}
window.onload = function(){
var SDmodel = new scrollDoor();
SDmodel.sd(["n_title01","n_title02","n_title03"],["n_box01","n_box02","n_box03"],"n_menu1a","n_menu1b");
SDmodel.sd(["p_title01","p_title02","p_title03","p_title04"],["p_box01","p_box02","p_box03","p_box04"],"i_tbtn","i_tbtna");
SDmodel.sd(["hot_title01","hot_title02","hot_title03"],["hot_box01","hot_box02","hot_box03"],"snf4","snf5");
}
