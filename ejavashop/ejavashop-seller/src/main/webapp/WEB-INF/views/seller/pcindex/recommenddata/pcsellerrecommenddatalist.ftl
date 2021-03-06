<#include "/seller/commons/_detailheader.ftl" />

<style>
#newstypeTree img {
	max-width: 390px;
	max-height: 290px;
}
</style>
<script language="javascript">

	var statusBox;
	$(function(){
	//为客户端装配本页面需要的字典数据,多个用逗号分隔
		<#noescape>
			statusBox = eval('(${initJSCodeContainer("DATA_TYPE")})');
		</#noescape>

		$("#a-gridAdd").click(function(){
	 		window.location.href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/seller/pcindex/recommenddata/add";
		});
		$("#a-gridSearch").click(function(){
	 		$('#dataGrid').datagrid('load',queryParamsHandler());
		});
		$("#a-gridEdit").click(function(){
			var selected = $('#dataGrid').datagrid('getSelected');
			if(!selected) {
				$.messager.alert('提示','请选择操作行。');
				return;
			}
	 		window.location.href="${(domainUrlUtil.EJS_URL_RESOURCES)!}/seller/pcindex/recommenddata/edit?pcSellerRecommendDataId="+selected.id;
		});
		
		$("#a-gridDel").click(function(){
            var selectedCode = $('#dataGrid').datagrid('getSelected');
            if(!selectedCode){
                $.messager.alert('提示','请选择操作行。');
                return;
            }

            $.messager.confirm('提示', '确定删除吗？', function(r){
                if (r){
                    $.messager.progress({text:"提交中..."});
                    $.ajax({
                        type:"POST",
                        url: "${domainUrlUtil.EJS_URL_RESOURCES}/seller/pcindex/recommenddata/delete",
                        dataType: "json",
                        data: "id="+selectedCode.id,
                        cache:false,
                        success:function(data, textStatus){
                            if (data.success) {
                                $('#dataGrid').datagrid('reload',queryParamsHandler());
                            }else{
                                $.messager.alert('提示', data.message);
                            }
                            $.messager.progress('close');
                        }
                    });
                }
            });
        });
        
		$("#newstypeWin").window({
			width : 666,
			height : 420,
			title : "链接图片",
			closed : true,
			shadow : false,
			modal : true,
			collapsible : false,
			minimizable : false,
			maximizable : false
		});
        
		$("#a-gridView").click(function(){
			window.open("${(domainUrlUtil.EJS_FRONT_URL)!}/storepreview/${(SESSION_SELLER_USER.sellerId)!0}.html");
		});
		
		<#if message??>$.messager.progress('close');$.messager.alert('提示','${message}');</#if>
	})

	function statusFormat(value,row,index){
		return statusBox["DATA_TYPE"][value];
	}

	function imageFormat(value, row, index) {
		return "<a class='newstype_view' onclick='showimg($(this).attr(\"imgpath\"));' href='javascript:;' imgpath='"
				+ value + "'>点击查看</a>";
	}

	function showimg(href) {
		$("#newstypeTree").html("<img src='${domainUrlUtil.EJS_IMAGE_RESOURCES}/"+href+"' >");
		$("#newstypeWin").window('open');
	}

</script>



<div id="searchbar" data-options="region:'north'" style="margin: 0 auto;" border="false">
	<div id="searchbox" class="head-seachbox">
		<h2 class="h2-title">PC端推荐数据列表 <span class="s-poar"><a class="a-extend" href="#">收起</a></span></h2>
		<div class="w-p99 marauto searchCont">
		<form class="form-search" onsubmit="return false;" action="" method="get" id="queryForm" name="queryForm">
			<div class="fluidbox"><!-- 不分隔 -->
				<p class="p4 p-item">
					<label class="lab-item">推荐类型：</label>
					<select name="q_recommendId" id="q_recommendId" value="${q_recommendId!''}">
                        <option value="">--全部--</option>
                        <#if recommends?? && recommends?size &gt; 0>
                        	<#list recommends as recommend>
								<option value="${(recommend.id)!}">${(recommend.title)!}</option>
							</#list>
						</#if>
				    </select>
				</p>
				<p class="p4 p-item">数据类型：<@cont.select id="q_dataType" value="${(q_dataType)!''}" codeDiv="DATA_TYPE" style="width:80px" /></p>
			</div>
		</form>
		</div>
	</div>
</div>


<div data-options="region:'center'" border="false">
	<table id="dataGrid" class="easyui-datagrid"
			data-options="rownumbers:true
						,singleSelect:true
						,autoRowHeight:false
						,fitColumns:false
						,collapsible:true
						,toolbar:'#gridTools'
						,striped:true
						,pagination:true
						,pageSize:'${pageSize}'
						,fit:true
    					,url:'${(domainUrlUtil.EJS_URL_RESOURCES)!}/seller/pcindex/recommenddata/list'
    					,queryParams:queryParamsHandler()
    					,onLoadSuccess:dataGridLoadSuccess
    					,method:'get'">
		<thead>
			<tr>
				<th field="recommendTitle" width="100" align="left" halign="center">推荐类型</th>
	            <th field="dataType" width="70" align="center" halign="center" formatter="statusFormat">数据类型</th>
				<th field="productName" width="200" align="left" halign="center">商品名称</th>
				<th field="title" width="150" align="left" halign="center">图片标题</th>
				<th field="linkUrl" width="150" align="left" halign="center">链接地址</th>
	            <th field="image" width="80" align="left" halign="center" formatter="imageFormat">查看图片</th>
	            <th field="orderNo" width="50" align="center" halign="center">排序号</th>
	            <th field="remark" width="150" align="left" halign="center">备注</th>
	            <th field="updateUserName" width="100" align="center">最后修改人</th>
	            <th field="updateTime" width="150" align="center">最后修改时间</th>
			</tr>
		</thead>
	</table>
	<div id="gridTools">
		<a id="a-gridSearch" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
		
		<@shiro.hasPermission name="/seller/pcindex/recommenddata/add">
		<a id="a-gridAdd" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增</a>
		</@shiro.hasPermission>
		<@shiro.hasPermission name="/seller/pcindex/recommenddata/edit">
		<a id="a-gridEdit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
		</@shiro.hasPermission>
		<@shiro.hasPermission name="/seller/pcindex/recommenddata/delete">
		<a id="a-gridDel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-delete" plain="true">删除</a>
		</@shiro.hasPermission>
		
		<a id="a-gridView" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-filter" plain="true">预览</a>
	</div>
</div>

<div id="newstypeWin">
	<form id="newstypeForm" method="post">
		<ul id="newstypeTree"
			style="margin-top: 10px; margin-left: 10px; max-height: 370px; overflow: auto; border: 1px solid #86a3c4;"></ul>
	</form>
</div>

<#include "/seller/commons/_detailfooter.ftl" />