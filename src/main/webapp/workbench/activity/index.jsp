<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
	request.getServerPort() + request.getContextPath() + "/";
%>

<html lang="en">
<head>
	<base href="<%=basePath%>" />
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
<script type="text/javascript">

	// 遍历传入的文本对象数组 检查是否是空字符串
	// function checkEmpty( element ) {
	// 	$.each(element,function (index,e) {
	// 		if(e.trim() == ""){
	// 			return true;
	// 		}
	// 	});
	// 	return false;
	// }

	$(function(){

		// 页面加载完成时分页查询出数据
		pageList(1,2);

		// 为搜索按钮注册条件查询时间
		$("#searchBtn").click(function () {

			//单击查询按钮的时候将查询条件全部保存在隐藏域中
			$("#hidden-name").val($("#search-name").val());
			$("#hidden-owner").val($("#search-owner").val());
			$("#hidden-startDate").val($("#search-startDate").val());
			$("#hidden-endDate").val($("#search-endDate").val());

			pageList(1,2);
		});

		// 全选框
		$("#qx").on("click",function () {
			$("input[name=xz]").prop("checked",this.checked);
		});

		// 动态生成的标绑定单击事件的用法
		// 下面是外层有效标签的jQuery对象（不是动态生成的标签）
		$("#activityBody").on("click",$("input[name=xz]"),function () {
			// 这里表示选择框的总数量等于被选选择框的数量 那么全选框就勾选 否则就不勾选
			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
		});


		// 为修改市场活动模态窗口中的保存按钮绑定事件
		$("#updateBtn").on("click",function(){
			// 拿到需要添加的属性值
			var id = $("#hidden-edit-activityId").val();
			var owner = $("#edit-marketActivityOwner").val();
			var name = $("#edit-marketActivityName").val();
			var startDate = $("#edit-startDate").val();
			var endDate = $("#edit-endDate").val();
			var cost = $("#edit-cost").val();
			var description = $("#edit-description").val();

			// 检查是否含有空字符串
			// if(checkEmpty([owner,name,startDate,endDate,cost,description])) {
			// 	alert("请保证信息填写完整！");
			// 	return;
			// }
			$.ajax({
				url:"workbench/activity/updateActivity.do",
				data:{
					"id":id,
					"owner":owner,
					"name":name,
					"startDate":startDate,
					"endDate":endDate,
					"cost":cost,
					"description":description,
					"editBy":"${sessionScope.user.name}" // 修改人为当前登录用户
				},
				dataType:"json",
				type:"post",
				success:function (data) {
					// 隐藏模态窗口
					$("#editActivityModal").modal("hide");
					if(data.success){
						// 刷新活动信息列表
						alert("修改成功！");
						// 清空模态窗口
					}else {
						alert("修改失败！")
					}

				}
			});
			// 保持当前页不动
			pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
					,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
		});


		// 为修改按钮绑定事件
		$("#editBtn").on("click",function () {

			// 拿到选中的复选框
			var $xz = $("input[name=xz]:checked");
			var owner ;
			// 没有选择提示用户
			if ($xz.length == 0){
				alert("请选择需要修改的记录");
			}else if($xz.length >1){
				alert("请选择最多一条记录");
			}else{
				// 后台取数据
				$.ajax({
					url:"workbench/activity/getAcById.do",
					data: {
						"id":$xz.val()},  // 传入id
					type:"get",
					dataType:"json",
					success:function (data) {
						// 拿到所有者下拉框jQuery对象
						var activityOwner = $("#edit-marketActivityOwner");
						// 清空下拉框
						activityOwner.empty();

						// 下拉框赋值 每一个option中的value赋值为该对应用户的id
						$.each(data.userList , function (index,element) {
							// 当前活动的所有着 为下列列表的开头
							activityOwner.append("<option value='"+element.id+"'>"+element.name+"</option>");
						});

						// 给所有文本栏赋值
						$("#edit-marketActivityName").val(data.activity.name);
						$("#edit-startDate").val(data.activity.startDate);
						$("#edit-endDate").val(data.activity.endDate);
						$("#edit-cost").val(data.activity.cost);
						$("#edit-description").val(data.activity.description);

						// 隐藏域中保存id
						$("#hidden-edit-activityId").val(data.activity.id);
					}
				});
				// 打开模态窗口
				$("#editActivityModal").modal("show");
			}
		});



		// 为删除按钮绑定事件
		$("#deleteBtn").on("click",function () {

			// 拿到所有选中框的jquery数组
			var $xz = $("input[name=xz]:checked");

			// 一条选中记录都没有 提示用户
			if($xz.length == 0){
				alert("请选择需要删除的记录");
			}else {

				// 给用户一个确定删除的提示
				if(confirm("确定删除所选中的记录吗？")){
					// 因为请求参数可能有多个 提前拼接起来
					var param =	"";
					for (var i = 0; i < $xz.length; i++) {
						param += "id=" + $xz[i].value ;
						if(	i < $xz.length - 1){
							param += "&";
						}
					}
					$.ajax({
						url:"workbench/activity/delete.do",
						data:param,
						type:"post",
						dataType:"json",
						success:function (data) {
							// 返回true则删除成功 否则删除失败
							if(data.success){
								alert(data.msg);
								pageList( 1 ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
							}else {
								// 将所有复选框取消选择
								$("#qx").prop("checked",false);
								alert(data.msg);
							}
						}
					});
				}
			}
		});



		// 为创建按钮绑定事件 目的是在打开模态窗口的同时绑定一些事件
		$("#addBtn").click(function () {
			// bootstrap的时间选择器
			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});


			// ajax回到后台拿到所有的用户姓名 为所有者下拉框传值
			$.ajax({
				url:"workbench/activity/getUserList.do",
				dataType:"json",
				type:"get",
				success:function (data) {
					// 拿到所有者下拉框jQuery对象
					var activityOwner = $("#create-marketActivityOwner");
					// 清空下拉框
					activityOwner.empty();


					// 下拉框赋值 每一个option中的value赋值为该对应用户的id
					$.each(data , function (index,element) {
						activityOwner.append("<option value='"+element.id+"'>"+element.name+"</option>");
					});

					/*
                        将登录的用户的姓名作为拥有者下拉框的开头
                        也就是选中session中用户的id对应在下拉列表中的用户
                    */
					activityOwner.val("${sessionScope.user.id}");
				}
			});
			// 展示模态窗口
			$("#createActivityModal").modal("show");
		});




		// 为创建市场活动 模态窗口中的保存按钮添加操作
		$("#saveBtn").click(function () {
			// 拿到需要添加的属性值
			var owner = $("#create-marketActivityOwner").val();
			var name = $("#create-marketActivityName").val();
			var startDate = $("#create-startDate").val();
			var endDate = $("#create-endDate").val();
			var cost = $("#create-cost").val();
			var description = $("#create-description").val();


			$.ajax({
				url:"workbench/activity/saveActivity.do",
				data:{
					"owner":$.trim(owner),
					"name":name,
					"startDate":startDate,
					"endDate":endDate,
					"cost":cost,
					"description":description,
					"createBy":"${sessionScope.user.name}" // 创建人为当前登录用户
				},
				dataType:"json",
				type:"post",
				success:function (data) {

					if(data.success){
						// 回到第一页  保持每页记录数量不变
						pageList(  1  ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

						// 清空和关闭添加操作的模态窗口
						$("#createActivityModal").modal("hide");
						$("#saveForm").get(0).reset();
					}else {

						// 保持当前页不动
						pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
								,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
						$("#createActivityModal").modal("hide");
						alert("添加市场活动失败！")
					}

				}
			});
		});
	});






	// 分页查询 展示信息   pageNo传页数 pageSize传每一页的记录条数
	function pageList(pageNo , pageSize) {

		// 将所有复选框取消选择
		$("#qx").prop("checked",false);

		// 每次发送ajax请求的时候 将保存在隐藏域中的查询条件赋值到文本框中的查询条件
		// 可以有效避免查询出错
		$("#search-name").val($("#hidden-name").val());
		$("#search-owner").val($("#hidden-owner").val());
		$("#search-startDate").val($("#hidden-startDate").val());
		$("#search-endDate").val($("#hidden-endDate").val());


		$.ajax({
			url:"workbench/activity/pageList.do",
			data:{
				// 分页查询的条件
				"pageNo":pageNo,
				"pageSize":pageSize,
				// 搜索条件 利用动态sql 有就填 没有就不填
				"name":$.trim($("#search-name").val()),
				"owner":$.trim($("#search-owner").val()),
				"startDate":$.trim($("#search-startDate").val()),
				"endDate":$.trim($("#search-endDate").val()),
			},
			dataType:"json",
			type:"get",
			success:function (data) {
				// 把数据添加到活动列表中
				$("#activityTr01").empty();
				$("#activityTr02").empty();
				$.each(data.dataList, function (index , element) {
					if(index == 0){
						$("#activityTr01").append("<td><input type='checkbox' name='xz' value='"+element.id+"'/></td>");
						$("#activityTr01").append("<td><a style='text-decoration: none; cursor: pointer;' onclick=\"window.location.href='workbench/activity/showDetail.do?id="+element.id+"';\">"+element.name+"</a></td>\n");
						$("#activityTr01").append("<td>"+element.owner+"</td>");
						$("#activityTr01").append("<td>"+element.startDate+"</td>");
						$("#activityTr01").append("<td>"+element.endDate+"</td>");
					}else if(index == 1){
						$("#activityTr02").append("<td><input type='checkbox' name='xz' value='"+element.id+"' /></td>");
						$("#activityTr02").append("<td><a style='text-decoration: none; cursor: pointer;' onclick=\"window.location.href='workbench/activity/showDetail.do?id="+element.id+"';\">"+element.name+"</a></td>\n");
						$("#activityTr02").append("<td>"+element.owner+"</td>");
						$("#activityTr02").append("<td>"+element.startDate+"</td>");
						$("#activityTr02").append("<td>"+element.endDate+"</td>");
					}
				});


				// 获取总页数 总记录条数除每没一页展示的条数 向上取整
				var totalPages = Math.ceil(parseInt(data.totalSize / pageSize));
				$("#activityPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.totalSize, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});
			}
		});
	}

</script>
</head>
<body>
	<%--隐藏域 用来保存信息--%>
	<input type="hidden" id="hidden-name"/>
	<input type="hidden" id="hidden-owner"/>
	<input type="hidden" id="hidden-startDate"/>
	<input type="hidden" id="hidden-endDate"/>

	<input type="hidden" id="hidden-edit-activityId"/>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="saveForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner">



								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startDate" class="col-sm-2 control-label ">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate">
							</div>
							<label for="create-endDate" class="col-sm-2 control-label ">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="editForm">
					
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName" value="张三1">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startDate" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate" value="2020-10-10">
							</div>
							<label for="edit-endDate" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endDate" value="2020-10-20">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost" value="5,000">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="search-startDate" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="search-endDate">
				    </div>
				  </div>
				  
				  <button type="button" id="searchBtn" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button><%--data-toggle="modal" data-target="#editActivityModal"--%>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">
						<tr class="active" id="activityTr01">
<%--							<td><input type="checkbox" /></td>--%>
<%--							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>--%>
<%--							<td>zhangsan</td>--%>
<%--							<td>2020-10-10</td>--%>
<%--							<td>2020-10-20</td>--%>
						</tr>
						<tr class="active" id="activityTr02">
<%--							<td><input type="checkbox" /></td>--%>
<%--							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/activity/detail.jsp';">发传单</a></td>--%>
<%--							<td>zhangsan</td>--%>
<%--							<td>2020-10-10</td>--%>
<%--							<td>2020-10-20</td>--%>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage">

				</div>
			</div>
			
		</div>
		
	</div>
</body>
</html>