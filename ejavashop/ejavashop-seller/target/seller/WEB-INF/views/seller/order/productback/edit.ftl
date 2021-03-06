<#include "/seller/commons/_detailheader.ftl" /> <#assign
currentBaseUrl="${domainUrlUtil.EJS_URL_RESOURCES}/seller/order/productBack"/>

<style>
.dl-group p img {
	max-width: 120px;
	float: left;
}

.dl-group label img {
	float: left;
	padding-right: 10px;
}
</style>

<script language="javascript">
	$(function() {

		$("#back").click(function() {
			location.href = '${currentBaseUrl}';
		});

		$("#agree").click(function() {
			$.messager.confirm('确认', '确定同意该买家的退货申请吗？', function(r) {
				if (r) {
					$.messager.progress({
						text : "提交中..."
					});
					$.ajax({
						type : "GET",
						url : "${currentBaseUrl}/audit?type=2&id=${obj.id}&remark=" + $("#remarkStr").val(),
						success : function(data, textStatus) {
							$('#dataGrid').datagrid('reload');
							$.messager.progress('close');
							location.href = '${currentBaseUrl}';
						}
					});
				}
			});
		});

		$("#disagree").click(function() {
			var remarkStr = $("#remarkStr").val();
			if (remarkStr = null || remarkStr == "") {
				$.messager.alert("提示", "请描述不予换货的原因。");
				return;
			}
			$.messager.confirm('确认', '确定对该买家的退货申请不予处理吗？', function(r) {
				if (r) {
					$.messager.progress({
						text : "提交中..."
					});
					$.ajax({
						type : "GET",
						url : "${currentBaseUrl}/audit?type=4&id=${obj.id}&remark=" + $("#remarkStr").val(),
						success : function(data, textStatus) {
							$('#dataGrid').datagrid('reload');
							$.messager.progress('close');
							location.href = '${currentBaseUrl}';
						}
					});
				}
			});
		});

		/* $("#received").click(function() {
			$.messager.confirm('确认', '确定已经收到退货了吗？', function(r) {
				if (r) {
					$.messager.progress({
						text : "提交中..."
					});
					$.ajax({
						type : "GET",
						url : "${currentBaseUrl}/audit?type=3&id=${obj.id}",
						success : function(data, textStatus) {
							$('#dataGrid').datagrid('reload');
							$.messager.progress('close');
							location.href = '${currentBaseUrl}';
						}
					});
				}
			});
		}); */

	})

	function closeWin() {
		$('#newstypeWin').window('close');
	}
</script>

<div class="wrapper">
	<div class="formbox-a">
		<h2 class="h2-title">
			退货申请<span class="s-poar"> <a class="a-back"
				href="${currentBaseUrl}">返回</a>
			</span>
		</h2>

		<div class="form-contbox">

			<dl class="dl-group">
				<dt class="dt-group">
					<span class="s-icon"></span>基本信息
				</dt>
				<dd class="dd-group">
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">订单号: </label> <label>${obj.orderSn!}</label>
						</p>
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">商品名称: </label><label>${obj.productName!}</label>
						</p>
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">用户名: </label> <label>${obj.memberName!}</label>
						</p>
						<!-- <p class="p6 p-item">
							<label class="lab-item">详细地址: </label><label>${obj.addressInfo!}</label>
						</p> -->
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">退货人手机: </label> <label>${obj.phone!}</label>
						</p>
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">联系人姓名: </label> <label>${obj.returnName!}</label>
						</p>
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">问题描述: </label> <label>${obj.question!}</label>
						</p>
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">退款金额: </label> <label>${obj.backMoney!}</label>
						</p>
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">退回积分: </label> <label>${obj.backIntegral!}</label>
						</p>
					</div>
					<#if couponUser?? >
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">退回优惠券: </label> <label>${couponUser.couponSn!}</label>
						</p>
					</div>
					</#if>
					<!-- <div class="fluidbox">
						<p class="p6 p-item">
							<label class="lab-item">邮编: </label> <label>${obj.zipCode!}</label>
						</p>
						<p class="p6 p-item">
							<label class="lab-item">问题描述: </label> <label>${obj.question!}</label>
						</p>
					</div> -->
					<!-- <div class="fluidbox">
						<p class="p6 p-item">
							<label class="lab-item">备注: </label> <label>${obj.remark!}</label>
						</p>
					</div> -->
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">备注: </label>
							<textarea name="remarkStr" rows="4" cols="60" id="remarkStr" class="{maxlength:255}">${(obj.remark)!''}</textarea>
						</p>
					</div>
				</dd>
			</dl>

			<dl class="dl-group">
				<dt class="dt-group">
					<span class="s-icon"></span>帮助
				</dt>
				<dd class="dd-group">
					<div class="fluidbox">
						<label class="lab-item" style="width: 100%; text-align: left;">
							<img src="${domainUrlUtil.EJS_URL_RESOURCES}/resources/admin/images/warning.jpg" />
							如果您同意买家的退货申请,将进入退货流程<br>
						</label>
					</div>
					<div class="fluidbox">
						<label class="lab-item" style="width: 100%; text-align: left;">
							<img src="${domainUrlUtil.EJS_URL_RESOURCES}/resources/admin/images/warning.jpg" />
							如果您不同意该退货申请,买家可选择向平台投诉
						</label>
					</div>
				</dd>
			</dl>

			<p class="p-item p-btn">
				<!-- 退货状态：1、未处理；2、审核通过待收货；3、已经收货；4、不予处理 -->
				<#if obj.stateReturn == 1>
					<input type="button" id="agree" class="btn" value="同意退货" />
					<input type="button" id="disagree" class="btn" value="不同意" /> 
				</#if>
				<#--
				<#if obj.stateReturn == 2>
					<input type="button" id="received" class="btn" value="已经收货" />
				</#if>
				-->
				<input type="button" id="back" class="btn" value="返回" />
			</p>
		</div>
	</div>
</div>

<#include "/seller/commons/_detailfooter.ftl" />
