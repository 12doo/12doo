var currTime;
var handler;
var endTime;

$.ajax({
   type: "POST", 
   url: "/sales/getPromotionInfoByAjax.jspa",
   dataType : 'json',
   success: function(salesDTO){
	 
	 if (salesDTO.promotion) {
         currTime = salesDTO.nowDate.time;
		 var start = salesDTO.promotion.startTime.time;
		 var end = salesDTO.promotion.endTime.time;
		 if (currTime >= end) {
		 	return;
		 } else if (currTime < start) {
            endTime = start
            $('#startEnd').html("开始");
         } else if (currTime < end) {
            endTime = end
            $('#startEnd').html("结束");
		 }
        // 显示时间
        doFresh();
        handler = setInterval(doFresh,1000); 
	 }
   }
});

function doFresh()
{
    currTime = currTime+1000;
    
    var leftsecond=parseInt((endTime-currTime)/1000);
    __d=parseInt(leftsecond/3600/24);
    __h=parseInt((leftsecond/3600)%24);
    __m=parseInt((leftsecond/60)%60);
    __s=parseInt(leftsecond%60);

    if (leftsecond<=0){
        clearInterval(handler);
    } else {
        if(__d<100){
            $('#timeDay').html(__d);
            $('#timeHour').html(__h);
            $('#timeMin').html(__m);
            $('#timeSec').html(__s);
        }
    }
}
