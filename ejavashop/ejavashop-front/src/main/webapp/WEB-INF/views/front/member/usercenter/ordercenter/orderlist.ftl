<#include "/front/commons/_head.ftl" />

<style type='text/css' rel="stylesheet">
		.tool-tip{position: relative;cursor: pointer;}
		.delivery-detail{
			position: absolute;
			z-index: 1;
			width: 400px;
			right: 90px;
			border: 1px solid #ddd;
			background: #fff;
			-webkit-box-shadow: 0 0 2px 2px #eee;
			-moz-box-shadow: 0 0 2px 2px #eee;
			box-shadow: 0 0 2px 2px #eee;
			-webkit-border-radius: 1px;
			-moz-border-radius: 1px;
			border-radius: 1px;
			text-align:left;
			top: -25px;
			display: none;
		}
		.delivery-detail .inner>p{
			padding-left: 7px;
		}
		.delivery-detail .inner{padding:10px;}
		.delivery-detail .inner p{
			margin-bottom: 0;
			color: #333;
			font-weight: 400;
			/*margin:0;*/
			margin-bottom: 10px;
		}
		.delivery-detail .inner ul{
			overflow: auto;
			max-height: 250px;
			margin-top: 10px;
			padding: 10px 7px 0;
			border-top: 1px dashed #c5c5c5;
		}
		.delivery-detail .inner ul li{
			margin-bottom: 18px;
			padding-left: 1em;
			position: relative;
		}
		.delivery-detail .inner ul li a:hover{
			color:#E64346;
			text-decoration: none;
		}
		.delivery-detail .inner ul li span{
			width: 5px;
			height: 5px;
			border-radius: 50%;
			border: 1px solid #686363;
			display: block;
			position: absolute;
			left: -6px;
			top: 5px;
			background: #686363;
		}
		.delivery-detail .inner ul .newest p{
			color:#E64346;
		}
		.delivery-detail .delivery-more{
			display: block;
			width: 80px;
			height: 28px;
			margin: 0 auto;
			background: #f0f0f0;
			border-radius: 2px;
			color: #666;
			line-height: 28px;
			text-align: center;
		}
		.delivery-detail .delivery-more:hover{
			color:#666;
			text-decoration: none;
		}
</style>

		<div class='container w'>
			<div class='breadcrumb'>
				<strong class='business-strong'>
					<a href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/index.html'>首页</a>
				</strong>
				<span>
					&nbsp;>&nbsp;
					<a href='javascript:void(0)'>我的ejavashop</a>
				</span>
				<span>
					&nbsp;>&nbsp;
					<a href='javascript:void(0)'>订单中心</a>
				</span>
			</div>
		</div>
		<div class='container w'>
			<!--左侧导航 -->
			<#include "/front/commons/_left.ftl" />
			<!-- 右侧主要内容 -->
			<div class='wrapper_main myorder'>
				<h3>我的订单</h3>
				<div class='mc'>
					<table class='tb-void'>
						<thead>
							<tr>
								<th width='300'>订单信息</th>
								<th>数量</th>
								<th>收货人</th>
								<th>订单金额</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						
						<#if ordersList??>
							<#list ordersList as order>
						<tbody>
							<tr class='tr-th'>
								<td colspan="6">  
									<span class=''>${order.createTime?string("yyyy-MM-dd HH:mm:ss")}&nbsp;&nbsp;订单编号:
										<a href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/member/orderdetail.html?id=${(order.id)!''}' target='_blank' title="${(order.orderSn)!''}">${(order.orderSn)!''}</a>
									</span>
								</td>
							</tr>
								
							<#if (order.orderProductList)??>
								<#list (order.orderProductList) as product>
								<tr class='tr-td'>
									<td>
										<div class='img-list'>
												<a href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(product.productId)!0}.html" target='_blank' class='img-box'>
													<img src='${(domainUrlUtil.EJS_IMAGE_RESOURCES)!}${product.productLeadLittle}'  target='_blank' width='50' height='50' class='err-product' title='${(product.productName)!''}'>
												</a>
												<div class='p-msg'>
													<a href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/product/${(product.productId)!0}.html'  target='_blank'>${(product.productName)!''}</a>
												</div>
										</div>
									</td>
									<td>
										<div class='p-num'>${(product.number)!''}</div>
									</td>
									
									
									
								<#assign sizeOrders = (order.orderProductList)?size>
								<#if product_index == 0>
									<td rowspan="${(sizeOrders)!1}">
										<div class='u-name'>${(order.name)!''}</div>
									</td>
									<td rowspan="${(sizeOrders)!1}">
										￥${(order.moneyOrder)!''}
										<br>
										${(order.paymentName)!''}
									</td>
									<td rowspan="${(sizeOrders)!1}">
										<#if order.orderState??>
							  				<#assign state = order.orderState>
							  				<#if state==1>未付款  
								  				<#elseif state==2>待确认
								  				<#elseif state==3>待发货
								  				<#elseif state==4>已发货
								  				<#elseif state==5>已完成
								  				<#elseif state==6>已取消
								  				<#else>
							  				</#if>
							  		    	</#if>
							  		        <#if order.orderState?? && order.paymentCode??>
												<#if (order.orderState==4)>	
								  		    	<div class='tool-tip'>
												</div>
										    </#if>
										</#if>
									</td>
									
									<td rowspan="${(sizeOrders)!1}" style="width:90px;">
										<span>
											<a href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/member/orderdetail.html?id=${(order.id)!''}" target='_blank'>查看</a>
										</span>
										<#if order.orderState?? && order.paymentCode??>
											<#if (order.orderState==1)||(order.orderState==2)||(order.orderState==3)><!-- 订单状态 为1（未付款的订单）或者 2待确认 或者 3待发货的订单 才能取消 -->
												<span><a href='javascript:void(0)' onclick="cancalOrder('${order.id}')" class='remove-order'>取消订单</a></span>
											</#if>
											<!-- 已完成的订单 才能评价和申请退换货 -->
											<#if (order.orderState==5)>
												<span>
													<a target='_blank' href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/member/addcomment.html?id=${(order.id)!0}' target='_self'>评价晒单</a>
												</span>
												<span>
													<a target='_blank' href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/member/backapply.html?id=${(order.id)!0}" onclick="" target='_self'>申请退换货</a>
												</span>
											</#if>
											<!-- 已发货状态 可以确认收货 -->
											<#if (order.orderState==4)>
												<span>
													<a  href='javascript:void(0)' onclick="goodsReceipt('${(order.id)!''}')">确认收货</a>
												</span>
											</#if>
										
											<#if (order.orderState==1)&&(order.paymentCode=='ONLINE')>
												<span><a href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/order/pay.html?relationOrderSn=${(order.orderSn)!''}&rid=${commUtil.randomString(20)}" target="_blank" class='btn btn-danger payments-but'>付款</a></span><br/>
											</#if>
										</#if>
									</td>
								</#if>

								</tr>
								</#list>
							</#if>
							
						</tbody>
							</#list>
						</#if>
						
					</table>
				</div>
				<!-- 分页 -->
				<#include "/front/commons/_pagination.ftl" />
			</div>
		</div>
<script type="text/javascript">
	$(".tool-tip").hover(function(){
		$(this).children(".delivery-detail").show();
	},function(){
		$(this).children(".delivery-detail").hide();
	});


	//控制左侧菜单选中
	$("#myorder").addClass("currnet_page");
	
	//取消订单
	function cancalOrder(ordersId){
		if(confirm("确定要取消该订单吗？")){
			$.ajax({
				type : "GET",
				url :  domain+"/member/cancalorder.html",
				data : {id:ordersId},
				dataType : "json",
				success : function(data) {
					if(data.success){
						window.location.reload();
					}else {
						jAlert(data.message);
					}
				},
				error : function() {
					jAlert("数据加载失败！");
				}
			});
		}
	}
	
	//确认收货
	function goodsReceipt(ordersId){
			$.ajax({
				type : "GET",
				url :  domain+"/member/goodreceive.html",
				data : {ordersId:ordersId},
				dataType : "json",
				success : function(data) {
					if(data.success){
						window.location.reload();
					}else {
						jAlert(data.message);
					}
				},
				error : function() {
					jAlert("数据加载失败！");
				}
			});
	}
	

</script>

<#include "/front/commons/_end.ftl" />
