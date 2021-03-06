<#include "/seller/commons/_detailheader.ftl" />

<script language="javascript">

$(function(){


	$("#back").click(function(){
 		window.location.href="${domainUrlUtil.EJS_URL_RESOURCES}/seller/pcindex/recommenddata";
	});
	$("#edit").click(function(){

		var recommendId = $("#recommendId").val();
    	if (recommendId == null || recommendId == "") {
    		$.messager.alert('提示','请选择推荐类型');
    		return false;
    	}
    	
		var dataType = $("#dataType").val();
		if (dataType == null || dataType == "") {
    		$.messager.alert('提示','请选择数据类型');
    		return false;
    	} else if (dataType == 1) {
        	var refId = $("#refId").val();
        	if (refId == null || refId == "" || refId == 0) {
        		$.messager.alert('提示','请选择商品');
        		return false;
        	}
        } else if (dataType == 2) {
        	var title = $("#title").val();
        	if (title == null || title == "") {
        		$.messager.alert('提示','请填写图片标题');
        		return false;
        	}
        	var linkUrl = $("#linkUrl").val();
        	if (linkUrl == null || linkUrl == "") {
        		$.messager.alert('提示','请填写链接地址');
        		return false;
        	}
        	var imageFile = $("#image").val();
        	if (imageFile == null || imageFile == "") {
        		$.messager.alert('提示','请选择图片');
        		return false;
        	}
        }
		
		if($("#addForm").form('validate')){
	 		$("#addForm").attr("action", "${domainUrlUtil.EJS_URL_RESOURCES}/seller/pcindex/recommenddata/update")
  				 .attr("method", "POST")
  				 .submit();
  		}
	});

	$('#pro').click(function(){
		$('#goodsDialog').dialog('open');
		$('#gd_dataGrid').datagrid('unselectAll');
	});
	
	
	$("#dataType").change(function(){
        var dataType = $(this).val();
        $("#dataPrdDiv").hide();
        $("#dataLinkDiv").hide();
        if (dataType == 1) {
        	$("#dataPrdDiv").show();
        } else if (dataType == 2) {
        	$("#dataLinkDiv").show();
        }
        
    });
	
	<#if message??>$.messager.progress('close');$.messager.alert('提示','${message}');</#if>
})

</script>

<div class="wrapper">
	<div class="formbox-a">
		<h2 class="h2-title">编辑推荐数据<span class="s-poar"><a class="a-back" href="${domainUrlUtil.EJS_URL_RESOURCES}/seller/pcindex/recommenddata">返回</a></span></h2>
		
		<#--1.addForm----------------->
		<div class="form-contbox">
			<@form.form method="post" class="validForm" id="addForm" name="addForm" enctype="multipart/form-data">
			<dl class="dl-group">
				<dt class="dt-group"><span class="s-icon"></span>基本信息</dt>
				<dd class="dd-group">
					<input type="hidden" id="id" name="id" value="${(pcSellerRecommendData.id)!''}">
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item"><font class="red">*</font>楼层：</label>
							<select name="recommendId" id="recommendId" value="${(pcSellerRecommendData.recommendId)!''}" disabled="disabled">
		                    	<option value="">--请选择--</option>
		                        <#if recommends?? && recommends?size &gt; 0>
		                        	<#list recommends as recommend>
										<option value="${(recommend.id)!}" <#if pcSellerRecommendData?? && pcSellerRecommendData.recommendId?? && pcSellerRecommendData.recommendId == recommend.id>selected="true"</#if>>${(recommend.title)!}</option>
									</#list>
								</#if>
						    </select>
						</p>
					</div>
					<br/>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item"><font class="red">*</font>排序号：</label>
							<input class="easyui-numberbox w280" id="orderNo" name="orderNo" value="${(pcSellerRecommendData.orderNo)!''}" data-options="required:true,max:99" >
						</p>
						<p class="p12 p-item">
							<label class="lab-item">&nbsp;</label>
							<label>
								<font style="color: #808080">
								序号越小越靠前显示
								</font>
							</label>
						</p>
					</div>
					<br/>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item"><font class="red">*</font>数据类型: </label>
							<@cont.select id="dataType" value="${(pcSellerRecommendData.dataType)!''}" codeDiv="DATA_TYPE" style="width:100px" mode="1"/>
						</p>
					</div>
					<br/>
					<div id="dataPrdDiv" <#if pcSellerRecommendData?? && pcSellerRecommendData.dataType?? && pcSellerRecommendData.dataType != 1>style="display:none;"</#if>>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item"><font class="red">*</font>商品: </label> 
							<input type="button" value="选择商品" id="pro"/>
							<input type="text" id="productName" name="productName" value="${(pcSellerRecommendData.product.name1)!''}" readonly="readonly">
							<input type="hidden" id="refId" name="refId" value="${(pcSellerRecommendData.refId)!''}">
						</p>
					</div>
					<br/>
					</div>
					
					<div id="dataLinkDiv" <#if pcSellerRecommendData?? && pcSellerRecommendData.dataType?? && pcSellerRecommendData.dataType != 2>style="display:none;"</#if>>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item"><font class="red">*</font>图片标题：</label>
							<input class="easyui-validatebox txt w280" type="text" id="title" name="title" value="${(pcSellerRecommendData.title)!''}" data-options="validType:'length[0,100]'" >
						</p>
					</div>
					<br/>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item"><font class="red">*</font>链接地址：</label>
							<input class="easyui-validatebox txt w280" type="text" id="linkUrl" name="linkUrl" value="${(pcSellerRecommendData.linkUrl)!''}" data-options="validType:'length[0,100]'" >
						</p>
						<p class="p12 p-item">
							<label class="lab-item">&nbsp;</label>
							<label>
								<font style="color: #808080">
								请填写完整的地址
								</font>
							</label>
						</p>
					</div>
					<br/>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item"><font class="red">*</font>图片：</label>
							<input type="file" id="imageFile" name="imageFile"
								style="height: 21px; float: left;line-height: 30px; vertical-align: middle;"
								missingMessage="请选择图片"
								class="txt w200 easyui-validatebox" />
							<input type="hidden" id="image" name="image" value="${(pcSellerRecommendData.image)!''}">
						</p>
						<p class="p12 p-item">
							<label class="lab-item">&nbsp;</label>
							<label>
								<font style="color: #808080">
								图片最佳像素（或保持该比例）：宽171，高247
								</font>
							</label>
						</p>
						<p class="p12 p-item">
							<label class="lab-item">&nbsp;</label>
							<img alt="图片" style="width: 171px;height: 247px;" src="${domainUrlUtil.EJS_IMAGE_RESOURCES}${(pcSellerRecommendData.image)!''}">
						</p>
					</div>
					<br/>
					<br/>
					</div>
					<div class="fluidbox">
						<p class="p12 p-item">
							<label class="lab-item">备注：</label>
							<textarea name="remark" rows="4" cols="60" id="remark" class="{maxlength:100}" >${(pcSellerRecommendData.remark)!''}</textarea>
						</p>
					</div>
					<br/>
					
				</dd>
			</dl>

			<#--2.batch button-------------->
			<p class="p-item p-btn">
				<input type="button" id="edit" class="btn" value="修改" />
				<input type="button" id="back" class="btn" value="返回"/>
			</p>
			</@form.form>
		</div>
	</div>
</div>

<div style="display: none">
<#include "goodsDialog.ftl"/>
</div>

<#include "/seller/commons/_detailfooter.ftl" />