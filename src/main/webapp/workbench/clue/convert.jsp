<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
	request.getServerPort() + request.getContextPath() + "/";


	String id = request.getParameter("id");
	String fullname = request.getParameter("fullname");
	String appellation = request.getParameter("appellation");
	String company = request.getParameter("company");
	String owner = request.getParameter("owner");
%>

<html lang="en">
<head>
	<base href="<%=basePath%>" />
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<script type="text/javascript">
	$(function(){

		<%
			if(request.getAttribute("msg") != null){
		%>
			alert("${requestScope.msg}");
		<%
			}
		%>

		// bootstrap的时间选择器
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});

		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});


		//关联的模态窗口搜索栏绑定keydown事件  进入后台模糊查询条件
		$("#getActivities").keydown(function (e) {
			// 按下回车键
			if(e.keyCode == 13){
				// alert("按下了回车！");
				// alert($("#getActivities").val());

				$.ajax({
					url:"workbench/clue/getAcByName.do",
					data:{
						"name":$.trim($("#getActivities").val()),
						"clueId":"${requestScope.clue.id}"
					},
					type:"get",
					dataType:"json",
					success:function (data) {
						// 显示模糊查询出来的ac
						var html = "";

						$.each(data , function (index,element) {
							html += '<tr>';
							html += '<td><input type="radio" name="xz" value="'+element.id+'"/></td>';
							html += '<td id="'+element.id+'">'+element.name+'</td>';
							html += '<td>'+element.startDate+'</td>';
							html += '<td>'+element.endDate+'</td>';
							html += '<td>'+element.owner+'</td>';
							html += '</tr>';
						});

						$("#searchAcBody").html(html);

					}
				});

				// 阻止关闭该模态窗口
				return false;

			}
		});

		// 单击搜索市场中的提交将选中项提交到活动源
		$("#submitBtn").on("click",function () {

			// 隐藏域中保存选中的市场活动的id
			var id = $("input[name=xz]:checked").val();

			$("#hidden-acId").val(id);

			$("#activity").val($("#" + id).html());

			// alert($("#hidden-acId").val());

			$("#searchActivityModal").modal("hide");
		});


		//为转换按钮绑定事件
		$("#convertBtn").on("click",function () {
			if($("#isCreateTransaction").prop("checked")){
				// 需要创建交易
				<%--window.location.href = "workbench/clue/convertAdd.do?clueId=${param.id}&activityId=" + $("#hidden-acId").val() + "&money=" + $("#amountOfMoney").val() + "&name=" + $("#tradeName").val() + "&expectedDate" + $("#expectedClosingDate").val() + "&stage=" + $("#stage>option:selected").val();--%>
				$("#tranFrom").submit();
			}else{
				// 不需要创建交易
				window.location.href = "workbench/clue/convert.do?clueId=${param.clueId}&flag=0";
			}
		})

	});
</script>

</head>
<body>

	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" id="getActivities" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="searchAcBody">

						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
				</div>
			</div>
		</div>
	</div>

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small>${param.fullname}<%=appellation%>-${param.company}</small></h4>

	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		新建客户：<%=company%>
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		新建联系人：<%=fullname%><%=appellation%>
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction" />
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >

		<%--
			提交表单会上传交易信息的参数
		--%>

		<form id="tranFrom" action="workbench/clue/convert.do" method="post">
			<input type="hidden" name="flag" value="1" />
		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney" name="money">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input type="text" class="form-control" id="tradeName" value="动力节点-" name="name">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input type="text" class="form-control time" id="expectedClosingDate" name="expectedDate">
		  </div>
				<div class="form-group" style="width: 400px;position: relative; left: 20px;">
					<label for="stage">阶段</label>
					<select id="stage"  name="stage" class="form-control">
						<option></option>
						<c:forEach items="${applicationScope.stage}" var="s" >

							<option value="${s.value}">${s.text}</option>

						</c:forEach>

		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#searchActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control"  id="activity" placeholder="点击上面搜索" readonly>
			  <input type="hidden" name="activityId" id="hidden-acId"/>
			  <input type="hidden" name="clueId" value="${param.clueId}"/>
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b><%=owner%></b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input class="btn btn-primary" id="convertBtn" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-default" type="button" value="取消">
	</div>
</body>
</html>