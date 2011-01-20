var indexGoods = {//物品列表 

    red : 1,//红葡萄酒
	white:6,//白葡萄酒
	pink: 13 , //桃红葡萄酒
	fizz: 17 , //起泡酒
	fortified:23, //加强葡萄酒
	strong:  28, //烈酒
	
     allTypeWineJson:null,//推荐酒 
     newWineJson:null,//新酒
     memberAskJson:null,//酒评价
     day_hotSaleJson:null,//天热卖
     week_hotSaleJson:null,//周热卖
     month_hotSaleJson:null,//月热卖
     init:function(){
       //indexGoods.init_allTypeWine();
       //indexGoods.init_newWine();
       indexGoods.init_MemberAsk();
       //indexGoods.init_XinPin();//新品
       indexGoods.init_HotSale("day");//热卖
     },
	 init_allTypeWine:function(){
		 $.ajax({
		   type: "POST",
		   url: "/index/rg.jspa",
		   dataType : 'json',
		   success: function(json){
			    indexGoods.onInit_allTypeWine(json);
		   }
		})
	 },
	 onInit_allTypeWine:function(json){//获取推送酒(所有类型的)
	 	if(json.goodsLst.length>0){
	 		indexGoods.allTypeWineJson = json.goodsLst;
	 		indexGoods.showTypeWine( indexGoods.changeType_toPage(indexGoods.red));
	 	}
	 },
	 showTypeWine:function(typeInpage){//显示推送酒(所有类型的)
	 	for(var i = 1; i<=6 ; i++){//修改样式
			if(typeInpage == ("0"+i)){
				 document.getElementById('p_title'+("0"+i)).className = 'i_tbtn';
			}else{
		        document.getElementById('p_title'+("0"+i)).className = 'i_tbtna';
		    } 
		 }
		var result = '';
		var list = indexGoods.allTypeWineJson;
		for(var i = 0 ;i< list.length;i++){
		   if( list[i].wineType == indexGoods.changeType_fromPage(typeInpage)){
		     result+=  indexGoods.showTypeWine_single(list[i]) ;
		   }
		}
		document.getElementById('p_box').innerHTML = result;
	 },
	 
	 changeType_toPage:function(sourceType){//转换成页面 酒类型
	 	if(sourceType == indexGoods.red ){return "01";}
	 	if(sourceType == indexGoods.white ){return "02";}
	 	if(sourceType == indexGoods.pink ){return "03";}
	 	if(sourceType == indexGoods.fizz ){return "04";}
	 	if(sourceType == indexGoods.fortified ){return "05";}
	 	if(sourceType == indexGoods.strong ){return "06";}
	 	
	 },
	 
	 changeType_fromPage:function(sourceType){//转换成页面 酒类型
	 	if(sourceType == "01" ){return  indexGoods.red;}
	 	if(sourceType =="02" ){return indexGoods.white;}
	 	if(sourceType == "03" ){return indexGoods.pink;}
	 	if(sourceType == "04" ){return indexGoods.fizz;}
	 	if(sourceType == "05" ){return indexGoods.fortified;}
	 	if(sourceType ==  "06" ){return  indexGoods.strong ;}
	 	
	 },
	 
	 showTypeWine_single:function(i,goods){//显示单一酒 
		var str ="";
		str+=' <dl class="product">'
			+'	<dt><a href="/goods/'+goods.goodsId+'.html"><img src="'+getImgsrc_22(i,goods.goodsId)+'" /></a></dt>'
			+'	<dd><a href="/goods/'+goods.goodsId+'.html">'+goods.name+'</a></dd>'
			+'	<dd>'+goods.capacity+'</dd>'
			+'	<dd class="delline snf8">市场价：'+goods.marketPrice+'元</dd>'
			+'	<dd>会员价：<span class="snf4">'+goods.memberPrice+'元</span></dd>'
			+'</dl>';
	   return str;
		 
	 },
	 
	 init_newWine:function(){//初始化新酒  
		  $.ajax({
			   type: "POST",
			   url: "/index/ng.jspa",
			   dataType : 'json',
			   success: function(json){
				    indexGoods.onInit_newWine(json);
			   }
			})
	 
	 },
	 
	  onInit_newWine:function(json){//获取新酒  
	 	if(json.goodsLst.length>0){
	 		indexGoods.newWineJson = json.goodsLst;
	 		indexGoods.shownewWineList();
	 	}
	 },
	 shownewWineList:function(){//显示新酒  
		var result = '';
		var list = indexGoods.newWineJson;
		for(var i = 0 ;i< list.length;i++){
			var goods = indexGoods.newWineJson[i];
		    result+= indexGoods.showTypeWine_single(i,goods);
		}
		document.getElementById('newGoods').innerHTML = result;
	 } ,
	  init_HotSale:function(type){//初始化热卖
		  $.ajax({
			   type: "POST",
			   url: "/index/hs.jspa",
			   dataType : 'json',
			   data: "hotSaleType="+type,
			   success: function(json){
				   indexGoods.show_hotSale(json,type);
			   }
			});
	 },
	  show_hotSale:function(json,type){//显示热卖
	  		if(json.list.length>0){
	  				var result = '<div class="i_boxleft" id="hot_box01" style="display:block">';
					var list1 = json.list;
					for(var t = 0 ;t< list1.length;t++){
					var ls=list1[t].list;
					if(t==1){
						result+='<div class="i_boxleft" id="hot_box02" style="display:none">';
					}
					if(t==2){
						result+='<div class="i_boxleft" id="hot_box03" style="display:none">';
					}
					 for(var i = 0 ;i< ls.length;i++){
					  var goods = ls[i];
					  result+='<div class="ileft_box">'
							 +'<div class="ileft_img">'
					         +'<a href="/goods/'+goods.goodsId+'.html" target="_blank"><img src="'+getImgsrc_22(i,goods.goodsId)+'" border="0" align="absmiddle"></a>'
					         +'<div class="index_hotbg">售出<strong>'+goods.saleQuantity+'</strong> 瓶</div>'
				             +'</div>'
				             +'<p>'
							 +'<a href="/goods/'+goods.goodsId+'.html" target="_blank">'+goods.goodsName.substring(0,8)+'...</a><br>'
							 +'<span class="delline snf8">市场价：'+goods.marketPrice+'元</span><br>'
							 +'会员价：<span class="snf4">'+goods.memberPrice+'元</span>'			
			                 +'</p></div>';
			                 }
			                 result+='</div>';
					}
	 					document.getElementById('hot_box').innerHTML = result;
	 				}
	  },
	  init_XinPin:function(){//初始化新品
		  $.ajax({
			   type: "POST",
			   url: "/index/xp.jspa",
			   dataType : 'json',
			   success: function(json){
				   if(json.list.length>0){
	 				var result = '';
					var list1 = json.list;
					for(var i = 0 ;i< list1.length;i++){
					  var goods = list1[i];
					  result+=' <dl class="product">'
							+'	<dt><a href="/goods/'+goods.goodsId+'.html"><img src="'+getImgsrc_22(i,goods.goodsId)+'" /></a></dt>'
							+'	<dd><a href="/goods/'+goods.goodsId+'.html">'+goods.goodsName+'</a></dd>'
							+'	<dd class="delline snf8">市场价：'+goods.marketPrice+'元</dd>'
							+'	<dd>会员价：<span class="snf4">'+goods.memberPrice+'元</span></dd>'
							+'</dl>';
					 
					}
					document.getElementById('xinpin').innerHTML = result;
	 				}
			   }
			})
			
	 },
	  init_MemberAsk:function(){//初始化 酒评价
		 divContentRoll("memberAskTop","memberAskContent","memberAskTemp");
	 },
	 onInit_MemberAsk:function(json){//  
	 	if(json.list.length>0){
	 		indexGoods.memberAskJson = json.list;
	 		indexGoods.showMemberAskList( );
	 	}
	 },
	 showMemberAskList:function( ){//显示评价(所有类型的)
		var result = '';
		var list = indexGoods.memberAskJson;
		//滑动效果 
		for(var i = 0 ;i< list.length;i++){
		  var data = list[i];
		  result+='<dl>'
					+'<dt><a href="/goods/'+data.goodsId+'.html"><img src="'+getImgsrc_1(data.goodsId)+'" /></a></dt>'
					+'<dd class="snf5"><a href="/goods/'+data.goodsId+'.html">'+data.name+'</a></dd>'
					+'<dd>'+data.content+'</dd>'
					+'<dd class="snf8">'+data.date+'</dd>'
				+'</dl>';
		}
		divContentRoll("memberAskTop","memberAskContent","memberAskTemp");
	 },
	 //动态显示热销图片 
    showHotSellImg:function(goodsId){
		var saleGoodsDivs = document.getElementsByTagName("dd");
 		var id = null;
		for(var i = 0;  i < saleGoodsDivs.length; i++ ){
			if(saleGoodsDivs[i].id.indexOf('hotSell_')!=-1){
				id = saleGoodsDivs[i].id.split("_");
				if(goodsId == id[1]){
					saleGoodsDivs[i].style.display='block';
					document.getElementById("hotSelldt_"+id[1]).className ='snf18';
				}else{
					saleGoodsDivs[i].style.display='none';
					document.getElementById("hotSelldt_"+id[1]).className ='';
				}
			}
		}
	} 
}	
	 
 