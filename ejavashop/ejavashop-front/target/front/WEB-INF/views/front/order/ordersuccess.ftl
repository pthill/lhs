<#include "/front/commons/_head.ftl" />

<link  rel="stylesheet" href='${(domainUrlUtil.EJS_STATIC_RESOURCES)!}/css/order.css'>

		<div class='w w1 header container'>
			<!-- <div id='logo'>
				<a href='' target='_blank' class='link1'>
					<img src=''>
				</a>
			</div> -->
			<div class='stepflex'>
				<dl class='first done'>
					<dt class='s-num'>1</dt>
					<dd class='s-text'>
						1.我的购物车
						<s></s>
						<b></b>
					</dd>
				</dl>
				<dl class='normal done'>
					<dt class='s-num'>2</dt>
					<dd class='s-text'>
						2.填写核对订单信息
						<s></s>
						<b></b>
					</dd>
				</dl>
				<dl class='normal last doing'>
					<dt class='s-num'>3</dt>
					<dd class='s-text'>
						3.成功提交订单
						<s></s>
						<b></b>
					</dd>
				</dl>
			</div>
		</div>
		<!-- 订单成功信息 -->
		<div class='container w'>
			<div class='msop mts'>
				<s class='icon-mts'></s>
				<h3 class='ftc-02'>感谢您，订单提交成功！请到<a href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/member/order.html'>订单中心</a>查看详情。</h3>
				<#if ordervo??>
					<#if (ordervo.ordersList?size>1)>
					<h2>亲爱的用户，由于您购买的商品分属不同的商家，此订单被拆分为${(ordervo.ordersList?size) }个订单进行结算及配送。</h2>
					</#if>
			   </#if>
			<#if ordervo??>
			<#list ordervo.ordersList as order>
				<div class='mcs' id='msop_detail'>
					<ul class='list-order'>
						<li class='li-st'>
							<div class='li-for1'>
								订单号：
								<a href='${(domainUrlUtil.EJS_URL_RESOURCES)!}/member/orderdetail.html?id=${(order.id)!''}'>${(order.orderSn)!'' }</a>
							</div>
							<div class='li-for2'>
								${(order.paymentName)!'' }：
								<strong class='ftc-01'>${(order.moneyOrder - order.moneyIntegral)?string('0.00')!'' }元</strong>
							</div>
						</li>
					</ul>
				</div>
			  </#list>
			 </#if>	
			</div>
			
		</div>
<#include "/front/commons/_end.ftl" />