<#include "/admin/commons/_detailheader.ftl" />
<#assign currentBaseUrl="${domainUrlUtil.EJS_URL_RESOURCES}/admin/member/settle"/>

<script type="text/javascript" src="${(domainUrlUtil.EJS_STATIC_RESOURCES)!}/resources/admin/jslib/easyui/datagrid-detailview.js"></script>

<style>
#newstypeTree img {
	max-width: 390px;
	max-height: 290px;
}
</style>

<script language="javascript">
	var statusBox;
	var otherTypeBox;
	$(function() {

		<#noescape>
			statusBox = eval('(${initJSCodeContainer("SETTLEMENT_STATUS")})');
			otherTypeBox = eval('(${initJSCodeContainer("SETTLE_OTHER_TYPE")})');
		</#noescape>
		
		// 查询按钮
		$('#btn-search').click(function() {
			$('#dataGrid').datagrid('reload', queryParamsHandler());
		});

		<#if message??>$.messager.progress('close');$.messager.alert('提示','${message}');</#if>
	});

	function settlementStatus(value, row, index) {
		var box = statusBox["SETTLEMENT_STATUS"][value];
		return box;
	}
	
	function otherType(value, row, index) {
		var box = otherTypeBox["SETTLE_OTHER_TYPE"][value];
		return box;
	}
	
	
</script>

<div id="devWin"></div>

<div id="searchbar" data-options="region:'north'"
	style="margin: 0 auto;" border="false">
	<h2 class="h2-title">
		结算账单列表 <span class="s-poar"><a class="a-extend" href="#">收起</a></span>
	</h2>
	<div id="searchbox" class="head-seachbox" style="display:none">
		<form class="form-search" action="doForm" method="post" id="queryForm"
			name="queryForm">
			<div class="fluidbox">
				<p class="p4 p-item">
					<label class="lab-item">结算周期:</label> <input type="text" class="txt"
						id="q_settleCycle" name="q_settleCycle" value="${q_settleCycle!''}" />
				</p>
				<p class="p4 p-item">
					<label class="lab-item">结算状态 :</label> <@cont.select id="q_status"
					codeDiv="SETTLEMENT_STATUS" value="${q_status!''}" name="q_status" style="width:100px"/>
				</p>
			</div>
		</form>
	</div>
</div>
</div>

<div data-options="region:'center'" border="false">
	<table id="dataGrid" class="easyui-datagrid"
		data-options="rownumbers:true
						,idField :'id'
						,singleSelect:true
						,autoRowHeight:false
						,fitColumns:true
						,toolbar:'#gridTools'
						,striped:true
						,pagination:true
						,pageSize:'${pageSize}'
						,fit:true
    					,url:'${currentBaseUrl}/detaillist'
    					,queryParams:queryParamsHandler()
    					,onLoadSuccess:dataGridLoadSuccess
    					,method:'get'">
		<thead>
			<tr>
				<th field="id" hidden="hidden"></th>
				<th field="settleTime" width="60" align="center">结算周期</th>
			</tr>
		</thead>
	</table>

	<div id="gridTools">
		<a id="btn-search" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		<@shiro.hasPermission name="/admin/member/settle/detail">
		<a id="btn-detail" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">详情</a>
		</@shiro.hasPermission>
	</div>
</div>

<#include "/admin/commons/_detailfooter.ftl" />