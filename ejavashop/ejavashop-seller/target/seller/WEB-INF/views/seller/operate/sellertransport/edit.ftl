<#include "/seller/commons/_detailheader.ftl" /> <#assign
currentBaseUrl="${domainUrlUtil.EJS_URL_RESOURCES}/seller/operate/sellerTransport"/>

<link rel="stylesheet"
	href="${(domainUrlUtil.EJS_STATIC_RESOURCES)!}/resources/admin/css/seller.css"
	type="text/css"></link>
<script>
	var domain = "${domainUrlUtil.EJS_URL_RESOURCES}";
	var currentBaseUrl = "${currentBaseUrl}";
	var id = "${(obj.id)!}";
	var transType = "${(obj.transType)!}";
</script>
<script
	src="${(domainUrlUtil.EJS_STATIC_RESOURCES)!}/resources/admin/jslib/seller/transport_edit.js"></script>

<style>
.dl-group p img {
	max-width: 120px;
	float: left;
}

.formbox-a .lab-item {
	float: left;
	width: 120px;
	text-align: right;
	margin-right: 3px;
	display: inline;
	padding-top: 5px;
}

iframe .panel-fit, .panel-fit body {
    overflow: scroll;
}
</style>

<div class="wrapper">
	<div class="formbox-a">
		<h2 class="h2-title">
			<#if obj??> 编辑运费模板 <#else> 新增运费模板 </#if> <span class="s-poar">
				<a class="a-back" href="${currentBaseUrl}">返回</a>
			</span>
		</h2>

		<#--1.addForm----------------->
		<div class="form-contbox">
			<@form.form method="post" class="validForm" id="addForm"
			name="addForm" enctype="multipart/form-data"
			action="${currentBaseUrl}/doAdd"> 
			
			<input type="hidden" value="${(obj.id)!''}" name="id"> 
         	<input type="hidden" name="mail_city_count" id="mail_city_count" />
            <input type="hidden" name="express_city_count" id="express_city_count" />
            <input type="hidden" name="ems_city_count" id="ems_city_count" />

			<dl class="dl-group">
				<dt class="dt-group">
					<span class="s-icon"></span>基本信息
				</dt>
				<dd class="dd-group" id="templateinfo">
					<div class="fluidbox">
						<p class="p6 p-item">
							<label class="lab-item"><font class="red">*</font>模板名称: </label>
							<input type="text" id="transName" name="transName" value="${(obj.transName)!}"
								class="txt w200 easyui-validatebox" missingMessage="请输入模板名称"
								data-options="required:true" />
								
						</p>
						<p class="p6 p-item">
							<label class="lab-item"><font class="red">*</font>发货时间: </label>
                        	 <@cont.select class="txt w200" id="transTime" style="height: 23px;padding: 0;"
								codeDiv="TRANSPORT_TIME"  value="${(obj.transTime)!}" name="transTime"/>
						</p>
					</div>
					<#--
					<div class="fluidbox">
						<p class="p6 p-item">
							<label class="lab-item"><font class="red">*</font>计价方式: </label>
							<label> 
							<input name="transType" type="radio"
								id="transType" value="1" 
									<#if ((obj.transType)!0)==1||((obj.transType)!0)==0>checked="checked"</#if> /> 按件数
							</label> <label> <input type="radio" name="transType"
								id="transType" value="2" <#if ((obj.transType)!0)==2>checked="checked"</#if>/> 按重量
							</label>
						</p>
					</div>
					-->
					<input type="hidden" name="transType" id="transType" value="${(obj.transType)!1}"/>
					<div class="fluidbox">
						<label class="lab-item" style="width: auto; margin-left: 71px;">
							<font class="red">*</font>
							运送方式: 
							<span style="color: red">
								（除指定地区外，其他地区的运费采用“默认运费”）
							</span>
						</label>
					</div>
					<div class="fluidbox" id="trans_detail">
						<!--平邮 开始-->
						<div class="db_box_main">
							<div class="db_box_main_input">
								<label> <input name="transMail" type="checkbox"
									id="transtype_mail" value="1" 
									<#if ((obj.transMail)!0)==1>checked</#if> /> 平邮
								</label>
							</div>
							<div class="db_box_main_rdinary" id="transtype_mail_info" 
								<#if ((obj.transMail)!0)!=1>style="display: none;"</#if>>
								<div class="rdinary_top">
									默认运费： 
									<input name="mail_trans_weight" type="text"
										id="mail_trans_weight" size="5" class="easyui-numberbox"
										value="${(mail.trans_weight)!}"/> 件内， 
									<input
										name="mail_trans_fee" type="text" precision="1"
										id="mail_trans_fee" size="8" class="easyui-numberbox"
										value="${(mail.trans_fee)!}"/>元， 每增加 
									<input name="mail_trans_add_weight" type="text"
										id="mail_trans_add_weight" size="5" 
										class="easyui-numberbox"
										value="${(mail.trans_add_weight)!}"/> 件，增加运费 
									<input precision="1"
										name="mail_trans_add_fee" type="text" class="easyui-numberbox"
										id="mail_trans_add_fee"
										size="8" value="${(mail.trans_add_fee)!}"/> 元
								</div>
								
								<div class="rdinary_ul" id="mail_trans_city_info" 
									<#if mailList?size==0>style="display:none;"</#if>>
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr bgcolor="#f5f5f5">
											<td width="46%" align="center"><span class="width1">运送到</span></td>
											<td width="11%"><span class="width2">首件(件)</span></td>
											<td width="13%"><span class="width2">首费(元)</span></td>
											<td width="11%"><span class="width2">续件(件)</span></td>
											<td width="12%"><span class="width2">续费(元)</span></td>
											<td width="7%"><span class="width3">操作</span></td>
										</tr>
										<#if mailList??>
										<#list mailList as info>
											<tr index="${info_index}">
												<td><a href="javascript:void(0);"
													onclick="edit_trans_city(this);" trans_city_type="mail">编辑</a></span><span
													class="width1" id="mail${info_index}">${(info.city_name)!}</span>
													<input type="hidden" id="mail_city_ids${info_index}"
														   name="mail_city_ids${info_index}"
														   value="${(info.city_id)!}"/>
                                                    <input type="hidden" id="mail_city_names${info_index}"
                                                           name="mail_city_names${info_index}"
                                                           value="${(info.city_name)!}"/>
												</td>
												<td><input type="text" class="in"
													id="mail_trans_weight${info_index}"
													name="mail_trans_weight${info_index}" 
													value="${(info.trans_weight)!}"/></td>
												<td><input type="text" class="in"
													id="mail_trans_fee${info_index}"
													name="mail_trans_fee${info_index}" 
													value="${(info.trans_fee)!}"/></td>
												<td><input type="text" class="in"
													id="mail_trans_add_weight${info_index}"
													name="mail_trans_add_weight${info_index}" 
													value="${(info.trans_add_weight)!}"/></td>
												<td><input type="text" class="in"
													id="mail_trans_add_fee${info_index}"
													name="mail_trans_add_fee${info_index}" 
													value="${(info.trans_add_fee)!}"/></td>
												<td><span class="width3"><a
														href="javascript:void(0);"
														onclick="if(confirm('确认要删除当前地区的设置么？'))remove_trans_city(this)">删除</a></span></td>
											</tr>
										</#list>
										</#if>
									</table>
								</div>
								<div class="rdinary_ul_bottom">
									<a href="javascript:void(0);" onclick="trans_city('mail')">为指定地区城市设置运费</a>
								</div>
							</div>
						</div>
						<!--平邮 结束-->
						<!--快递 开始-->
						<div class="db_box_main">
							<div class="db_box_main_input">
								<label> 
									<input name="transExpress" type="checkbox"
										id="transtype_express" value="1" 
										<#if ((obj.transExpress)!0)==1>checked</#if> /> 快递
								</label>
							</div>
							<div class="db_box_main_rdinary" id="transtype_express_info" 
								<#if ((obj.transExpress)!0)!=1>style="display: none;"</#if>>
								<div class="rdinary_top">
									默认运费：
									<input name="express_trans_weight" type="text" 
										id="express_trans_weight" size="5" class="easyui-numberbox"
										value="${(express.trans_weight)!}"/> 件内， 
									<input name="express_trans_fee" type="text" precision="1"
										id="express_trans_fee" size="8" class="easyui-numberbox"
										value="${(express.trans_fee)!}"/> 元， 每增加 
									<input name="express_trans_add_weight" type="text" 
										id="express_trans_add_weight" size="5" class="easyui-numberbox"
										value="${(express.trans_add_weight)!}"/> 件，增加运费
									<input name="express_trans_add_fee" type="text" precision="1"
										id="express_trans_add_fee" size="8" class="easyui-numberbox"
										value="${(express.trans_add_fee)!}"/> 元
								</div>
								<div class="rdinary_ul" id="express_trans_city_info" 
									<#if expressList?size==0>style="display:none;"</#if>>
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr bgcolor="#f5f5f5">
											<td width="46%" align="center"><span class="width1">运送到</span></td>
											<td width="11%"><span class="width2">首件(件)</span></td>
											<td width="13%"><span class="width2">首费(元)</span></td>
											<td width="11%"><span class="width2">续件(件)</span></td>
											<td width="12%"><span class="width2">续费(元)</span></td>
											<td width="7%"><span class="width3">操作</span></td>
										</tr>
										<#if expressList??>
										<#list expressList as info>
											<tr index="${info_index}">
												<td><a href="javascript:void(0);" onclick="edit_trans_city(this);"
														trans_city_type="express">编辑</a><span class="width1"
													id="express${info_index}">${(info.city_name)!}</span>
                                                    <input type="hidden" id="express_city_ids${info_index}"
                                                           name="express_city_ids${info_index}"
                                                           value="${(info.city_id)!}"/>
                                                    <input type="hidden" id="express_city_names${info_index}"
                                                           name="express_city_names${info_index}"
                                                           value="${(info.city_name)!}"/>
												</td>
												<td><input type="text" class="in"
													id="express_trans_weight${info_index}"
													name="express_trans_weight${info_index}" 
													value="${(info.trans_weight)!}"/></td>
												<td><input type="text" class="in" 
													id="express_trans_fee${info_index}"
													name="express_trans_fee${info_index}" 
													value="${(info.trans_fee)!}"/></td>
												<td><input type="text" class="in"
													id="express_trans_add_weight${info_index}"
													name="express_trans_add_weight${info_index}" 
													value="${(info.trans_add_weight)!}"/></td>
												<td><input type="text" class="in"
													id="express_trans_add_fee${info_index}"
													name="express_trans_add_fee${info_index}" 
													value="${(info.trans_add_fee)!}"/></td>
												<td><span class="width3"><a
														href="javascript:void(0);"
														onclick="if(confirm('确认要删除当前地区的设置么？'))remove_trans_city(this)">删除</a></span></td>
											</tr>
										</#list>
										</#if>
									</table>
								</div>
								<div class="rdinary_ul_bottom">
									<a href="javascript:void(0);" onclick="trans_city('express')">为指定地区城市设置运费</a>
								</div>
							</div>
						</div>
						<!--快递 结束-->
						<!--EMS 开始-->
						<div class="db_box_main">
							<div class="db_box_main_input">
								<label> <input name="transEms" type="checkbox"
									id="transtype_ems" value="1" 
									<#if ((obj.transEms)!0)==1>checked</#if> /> EMS
								</label>
							</div>
							<div class="db_box_main_rdinary" id="transtype_ems_info" 
								<#if ((obj.transEms)!0)!=1>style="display: none;"</#if>>
								<div class="rdinary_top">
									默认运费： 
									<input name="ems_trans_weight" type="text"
										id="ems_trans_weight" size="5" class="easyui-numberbox"
										value="${(ems.trans_weight)!}"/> 件内， 
									<input name="ems_trans_fee" type="text" precision="1"
										id="ems_trans_fee" size="8" class="easyui-numberbox"
										value="${(ems.trans_fee)!}"/> 元， 每增加
									<input name="ems_trans_add_weight" class="easyui-numberbox"
										type="text" id="ems_trans_add_weight" size="5" 
										value="${(ems.trans_add_weight)!}"/> 件，增加运费 
									<input name="ems_trans_add_fee" class="easyui-numberbox"
										type="text" id="ems_trans_add_fee" size="8" precision="1"
										value="${(ems.trans_add_fee)!}"/> 元
								</div>
								<div class="rdinary_ul" id="ems_trans_city_info" <#if emsList?size==0>style="display:none;"</#if>>
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr bgcolor="#f5f5f5">
											<td width="46%" align="center"><span class="width1">运送到</span></td>
											<td width="11%"><span class="width2">首件(件)</span></td>
											<td width="13%"><span class="width2">首费(元)</span></td>
											<td width="11%"><span class="width2">续件(件)</span></td>
											<td width="12%"><span class="width2">续费(元)</span></td>
											<td width="7%"><span class="width3">操作</span></td>
										</tr>
										<#if emsList??>
										<#list emsList as info>
											<tr index="${info_index}">
												<input type="hidden" id="ems_city_ids${info_index}"
                                                           name="ems_city_ids${info_index}"
                                                           value="${(info.city_id)!}"/>
                                                    <input type="hidden" id="ems_city_names${info_index}"
                                                           name="ems_city_names${info_index}"
                                                           value="${(info.city_name)!}"/>
												<td><a href="javascript:void(0);" onclick="edit_trans_city(this);"
														trans_city_type="ems">编辑</a><span class="width1"
													id="ems${info_index}">${(info.city_name)!}</span>
												</td>
												<td><input type="text" class="in"
													id="ems_trans_weight${info_index}"
													name="ems_trans_weight${info_index}" 
													value="${(info.trans_weight)!}"/></td>
												<td><input type="text"  class="in" 
													id="ems_trans_fee${info_index}"
													name="ems_trans_fee${info_index}" 
													value="${(info.trans_fee)!}"/></td>
												<td><input type="text" class="in"
													id="ems_trans_add_weight${info_index}"
													name="ems_trans_add_weight${info_index}" 
													value="${(info.trans_add_weight)!}"/></td>
												<td><input type="text"  class="in"
													id="ems_trans_add_fee${info_index}"
													name="ems_trans_add_fee${info_index}" 
													value="${(info.trans_add_fee)!}"/></td>
												<td><span class="width3"><a
														href="javascript:void(0);"
														onclick="if(confirm('确认要删除当前地区的设置么？'))remove_trans_city(this)">删除</a></span></td>
											</tr>
										</#list>
										</#if>
									</table>
								</div>
								<div class="rdinary_ul_bottom">
									<a href="javascript:void(0);" onclick="trans_city('ems')">为指定地区城市设置运费</a>
								</div>
							</div>
						</div>
						<!--EMS 结束-->
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
							设置运费模板 </label>
					</div>
				</dd>
			</dl>

			<p class="p-item p-btn">
				<input type="button" id="add" class="btn" value="提交" />
				<input type="button" id="back" class="btn" value="返回" />
			</p>
			</@form.form>
		</div>
	</div>
</div>

<#include "/seller/commons/_detailfooter.ftl" />
