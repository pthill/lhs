<#include "/front/commons/_headbig.ftl" />
<link rel="stylesheet" type="text/css" href="${(domainUrlUtil.EJS_STATIC_RESOURCES)!}/css/list.css">
<link rel="stylesheet" type="text/css" href="${(domainUrlUtil.EJS_STATIC_RESOURCES)!}/css/activit.css">
		
	<div class="activit-main">
	
	<#if actFlashSale??>
      <div class="container-img">
        <a href="javascript:;">
          <img src="${(domainUrlUtil.EJS_IMAGE_RESOURCES)!}${(actFlashSale.pcImage)!''}" alt="" width="1210px">   
        </a>
      </div>
  	</#if>
      
   <#if actFlashSaleStage??>
      <div class="sections">
        <div class="section-title">
            <span class="icon-clock"></span>
            <span class="now-time">今日${(actFlashSaleStage.startTime)!}:00点开抢
            <#if state==1>
            	（未开始）
            </#if>
            <#if state==2>
            </#if>
            <#if state==3>
            	（已结束）
            </#if>
            </span>
            <span class="low-price">整点开抢，全网最低</span>
            <#if state==2>
	            <div class="time-item">距离结束：
	              <strong class="hour_show item-h">0时</strong>
	              <strong class="minute_show item-m">0分</strong>
	              <strong class="second_show item-s">0秒</strong>
	            </div>
            </#if>
        </div>
        
        <#if actFlashSaleStage.productList??>
	        <#list actFlashSaleStage.productList as saleProduct>
	        	
		        	<#if saleProduct.product??>
				        <div class="item">
				            <div class="item-dbox">
				            <#if state==2>
				              <#if saleProduct.stock gt 0>
				              	<span class="state" onclick="location.href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(saleProduct.product.id)!0}.html?type=1'">抢购中...</span>
				              <#else>
				              	<span class="state-charterd" onclick="location.href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(saleProduct.product.id)!0}.html'"></span>
				              </#if>
			                </#if>
			                <#if state==2>
				              <a href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(saleProduct.product.id)!0}.html?type=1" class="item-box-a">
				            <#else>
				              <a href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(saleProduct.product.id)!0}.html" class="item-box-a">
				            </#if>
				                <img src="${(domainUrlUtil.EJS_IMAGE_RESOURCES)!}${(saleProduct.product.masterImg)!}" alt="">
				              </a>
				               <#if state==2>
				              		<a href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(saleProduct.product.id)!0}.html?type=1" class="disbox">
				               <#else>
					               <a href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(saleProduct.product.id)!0}.html" class="disbox">
				               </#if>
				              	${(saleProduct.product.name1)!""}
			              	 </a>
				              <div class="item-price">
				                <span class="new-price">￥${(saleProduct.price)!""}</span>
				                <em>${(saleProduct.actualSales)!""}件已被秒杀</em>
				                <span class="old-price">￥${(saleProduct.product.marketPrice)!""}</span>
				              </div>
				            </div>
				        </div>
		        	</#if>
	        	
	        </#list>
        </#if>
      </div> 
	</#if>

      
    </div>
    			
<script type="text/javascript">
    $(function(){
      $('.item').on('mouseenter',function(){
          $(this).find('.state').show();
        })
      $('.item').on('mouseleave',function(){
          $(this).find('.state').hide();
      })

      function timer(time,d,h,m,s){
            window.setInterval(function(){
            var day=0,
                hour=0,
                minute=0,
                second=0;//时间默认值       
            if(time > 0){
                day = Math.floor(time / (60 * 60 * 24));
                hour = Math.floor(time / (60 * 60)) - (day * 24);
                minute = Math.floor(time / 60) - (day * 24 * 60) - (hour * 60);
                second = Math.floor(time) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
            }
            if (minute <= 9) minute = '0' + minute;
            if (second <= 9) second = '0' + second;
            $(d).html(day+"天");
            $(h).html('<s id="h"></s>'+hour+'时');
            $(m).html('<s></s>'+minute+'分');
            $(s).html('<s></s>'+second+'秒');
            time--;
            }, 1000);
        } 
        
        var tim = parseInt('${(countTime)!0}');
        timer(tim,'.item-d','.item-h','.item-m','.item-s');

    })
</script>			

		</div>
<#include "/front/commons/logindialog.ftl" />		
<#include "/front/commons/_endbig.ftl" />

<script type="text/javascript">
	function addCart(productId,sellerId) {
		if (!isUserLogin()) {
			showid('ui-dialog');
			return;
		}
		<#--
		<#if Session.memberSession??>
			 <#assign user = Session.memberSession.member>
		</#if>
		<#if !user??>
			jAlert("请登录之后再添加购物车！");   
			return false;
		</#if>
		-->
		$.ajax({
			type : "POST",
			url :  domain+"/cart/addtocart.html",
			data : {productId:productId,sellerId:sellerId},
			dataType : "json",
			success : function(data) {
				if(data.success){
						//跳转到添加购物车成功页面
						window.open(domain+"/cart/add.html");  
				}else{
					jAlert(data.message);
				}
			},
			error : function() {
				jAlert("数据加载失败！");
			}
		});
	}
</script>