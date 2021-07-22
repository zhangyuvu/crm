<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.zy.crm.settings.domain.DicValue" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zy.crm.workbench.domain.Tran" %>

<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
request.getServerPort() + request.getContextPath() + "/";

	// 取出阶段和可能性的对应关系
	Map<String , String > pMap = (Map<String, String>) application.getAttribute("pMap");

	Set<String> keySet = pMap.keySet();

	// 取出每个阶段值
	List<DicValue> dvList = (List<DicValue>) application.getAttribute("stage");


	// 获取到正常阶段和丢失阶段的分界点
	int point = 0;
	for (int i = 0; i < dvList.size() ; i++) {

		String stage = dvList.get(i).getValue();

		if( "0".equals(pMap.get(stage))){
			point = i;
			break;

		}
	}

%>

<html lang="en">
<head>
	<base href="<%=basePath%>" />
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<style type="text/css">
.mystage{
	font-size: 20px;
	vertical-align: middle;
	cursor: pointer;
}
.closingDate{
	font-size : 15px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
	
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	var json = {
		<%
            for(String key : keySet){
                String value = pMap.get(key);
        %>
		"<%=key%>" : <%=value%>,
		<%
            }
        %>
	};

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;

	function init(){
		var stage = $("#stage").text();

		$("#possibility").text(json[stage]);
	}

	// 展示交易历史记录的列表
	function showHistoryList(){
		$.ajax({
			url:"workbench/transaction/getHistoryListByTranId.do",
			data:{
				"id":"${tran.id}"
			},
			dataType:"json",
			type:"get",
			success:function (data) {

				var html = "";

				$.each(data, function (index,element) {
					html += '<tr>';
					html += '<td>'+element.stage+'</td>';
					html += '<td>'+element.money+'</td>';
					html += '<td>'+json[element.stage]+'</td>';
					html += '<td>'+element.expectedDate+'</td>';
					html += '<td>'+element.createTime+'</td>';
					html += '<td>'+element.createBy+'</td>';
					html += '</tr>';
				});

				$("#tranHistoryBody").html(html);
			}
		});
	}


	$(function(){

		// init();


		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
		
		
		//阶段提示框
		$(".mystage").popover({
            trigger:'manual',
            placement : 'bottom',
            html: 'true',
            animation: false
        }).on("mouseenter", function () {
                    var _this = this;
                    $(this).popover("show");
                    $(this).siblings(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                }).on("mouseleave", function () {
                    var _this = this;
                    setTimeout(function () {
                        if (!$(".popover:hover").length) {
                            $(_this).popover("hide")
                        }
                    }, 100);
                });


		// 页面加载完毕后 展现交易历史列表
		showHistoryList();




	});
	

	// 当单击阶段图标时触发的逻辑
	function changeStage(stage , index) {
		// alert(index);
		// alert(stage);
		if(confirm("确认修改阶段？")){
			var editBy = "${sessionScope.user.name}";
			$.ajax({
				url:"workbench/transaction/changeStage.do",
				data:{
					"id":"${requestScope.tran.id}",
					"stage":stage,
					"editBy":editBy,
					"money":"${tran.money}", // 交易历史用
					"expectedDate":"${tran.expectedDate}"// 交易历史用
				},
				type:"post",
				dataType:"json",
				success:function (data) {

					if(data.msg.success){
						$("#stage").html(stage);
						$("#possibility").html(json[stage]);
						$("#editBy").html(editBy + "&nbsp;&nbsp;&nbsp;");
						$("#editTime").html(data.tran.editTime);


						// 填充好值后 将所有阶段的图标进行重新判断
						changeIcon(stage,index);


					}else {
						alert(data.msg.msg);
					}
				}
			});
		}
	}


	/*
		更换图标样式的方法
		第一个参数当前单击的图标对应的阶段，第二个参数为对应的下标
	*/
	function changeIcon(stage,index) {

		// 当前阶段可能性
		var possibility = json[stage];

		// 获取临界点下标
		var point = "<%=point%>";

		// 当前阶段的可能性为0
		if("0" == possibility){
			// 临界点前的所有图标全部变为黑圈
			for( var i = 0 ; i < point ; i++){

				// 移除以前的样式
				$("#" + i).removeClass();

				//添加新的样式
				$("#" + i).addClass("glyphicon glyphicon-record mystage");

				// 添加新的颜色
				$("#" + i).css("color" , "#000000");

			}


			// 当前阶段变红叉，除开当前阶段其他阶段变黑叉
			for(var i = point ; i < <%=dvList.size()%> ; i++ ){
				// 如果是当前阶段，则为红叉
				if( i == index){

					$("#" + i).css("color","#FF0000");

				// 如果不是当前阶段，则为黑叉
				}else{
					$("#" + i).css("color","#000000");
				}
			}

		/*当前阶段可能性不为0*/
		}else {
			// 后面为黑叉
			for(var i = point ; i < <%=dvList.size()%> ; i++ ){
				$("#" + i).css("color","#000000");
			}

			for( var i = 0 ; i < point ; i++){
				// 移除以前的样式
				$("#" + i).removeClass();

				// 当前阶段之前为绿圈
				if(i < index){

					//添加新的样式
					$("#" + i).addClass("glyphicon glyphicon-ok-circle mystage");

					// 添加新的颜色
					$("#" + i).css("color" , "#90F790");

				// 当前阶段之后为黑圈
				}else if( i > index){
					//添加新的样式
					$("#" + i).addClass("glyphicon glyphicon-record mystage");

					// 添加新的颜色
					$("#" + i).css("color" , "#000000");

				// 当前阶段为绿箭头
				}else {

					//添加新的样式
					$("#" + i).addClass("glyphicon glyphicon-map-marker mystage");

					// 添加新的颜色
					$("#" + i).css("color" , "#90F790");
				}
			}




		}


	}
	
</script>

</head>
<body>
	
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>${tran.customerId}-${requestScope.tran.name}<small>￥${tran.money}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" onclick="window.location.href='workbench/transaction/edit.jsp';"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>

	<!-- 阶段状态 -->
	<div style="position: relative; left: 40px; top: -50px;">
		阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
			// 准备当前阶段
			Tran tran = (Tran) request.getAttribute("tran");
			String currentStage = tran.getStage();

			// 准备当前可能性
			String curretnPossibility = pMap.get(currentStage);

			// 如果当前阶段可能性为0
			if("0".equals(curretnPossibility)){
				for(int i = 0 ; i < dvList.size() ; i++){
					// 取得每一个阶段 前七个阶段为黑圈  后两个一个为红叉 一个为黑叉
					String stage = dvList.get(i).getValue();
					String possibility = pMap.get(stage);


					// 可能性不为0的前七个阶段 变成黑圈
					if(!"0".equals(possibility)){
		%>
						<span id="<%=i%>" onclick="changeStage('<%=stage%>' , '<%=i%>')" class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="<%=stage%>"></span>
						-----------
		<%
					}else{
						// 后两个可能性为0的阶段
						// 哪一个阶段丢失的线索 那个阶段对应的红叉
						if(stage.equals(currentStage)){
		%>
							<span id="<%=i%>" onclick="changeStage('<%=stage%>' , '<%=i%>')" class="glyphicon glyphicon-remove mystage" style="color:#FF0000;" data-toggle="popover" data-placement="bottom" data-content="<%=stage%>"></span>
							-----------
		<%
						}else{
		%>
							<span id="<%=i%>" onclick="changeStage('<%=stage%>' , '<%=i%>')" class="glyphicon glyphicon-remove mystage" data-toggle="popover" data-placement="bottom" data-content="<%=stage%>"></span>
							-----------
		<%
						}
					}
				}
			// 当前阶段可能性不为0
			}else{

				// 当前阶段的分界点
				int currentPoint = 0;
				for(int i = 0 ; i < dvList.size() ; i++){
					if(dvList.get(i).getValue().equals(currentStage)){
						currentPoint = i;
						break;
					}
				}


				for(int i = 0 ; i < dvList.size() ; i++){
					String stage = dvList.get(i).getValue();
					String possibility = pMap.get(stage);

					// 不是可能性为0的阶段
					if(!"0".equals(possibility)){

						/*在当前阶段之前 为绿圈*/
						if(i < currentPoint ){
		%>

							<span id="<%=i%>" onclick="changeStage('<%=stage%>' , '<%=i%>')" class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="<%=stage%>" style="color: #90F790;"></span>
							-----------

		<%				/*当前阶段 为箭头*/
						}else if (i == currentPoint ){
		%>

							<span id="<%=i%>" onclick="changeStage('<%=stage%>' , '<%=i%>')" class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom" data-content="<%=stage%>" style="color: #90F790;"></span>
							-----------

		<%				/*在当前阶段之后 为黑圈*/
						} else {
		%>
							<span id="<%=i%>" onclick="changeStage('<%=stage%>' , '<%=i%>')" class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="<%=stage%>"></span>
							-----------
		<%
						}
					// 可能性为0 的阶段 两个都为黑叉
					}else{
		%>
						<span id="<%=i%>" onclick="changeStage('<%=stage%>' , '<%=i%>')" class="glyphicon glyphicon-remove mystage" data-toggle="popover" data-placement="bottom" data-content="<%=stage%>"></span>
						-----------
		<%
					}
				}
			}

		%>



		<%--<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="资质审查" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="需求分析" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="价值建议" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="确定决策者" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom" data-content="提案/报价" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="谈判/复审"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="成交"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="丢失的线索"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="因竞争丢失关闭"></span>
		-------------%>
		<span class="closingDate">${tran.expectedDate}</span>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: 0px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.money}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.customerId}-${requestScope.tran.name}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.expectedDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.customerId}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="stage">${tran.stage}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">类型</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.type}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="possibility">${tran.possibility}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.source}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.activityId}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">联系人名称</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.contactsId}</b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${tran.createTime}&nbsp;</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy">${tran.editBy}&nbsp;&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="editTime">${tran.editTime}&nbsp;</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${tran.description}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${tran.contactSummary}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 100px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.nextContactTime}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 100px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>哎呦！</h5>
				<font color="gray">交易</font> <font color="gray">-</font> <b>动力节点-交易01</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		
		<!-- 备注2 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>呵呵！</h5>
				<font color="gray">交易</font> <font color="gray">-</font> <b>动力节点-交易01</b> <small style="color: gray;"> 2017-01-22 10:20:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 阶段历史 -->
	<div>
		<div style="position: relative; top: 100px; left: 40px;">
			<div class="page-header">
				<h4>阶段历史</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>阶段</td>
							<td>金额</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>创建时间</td>
							<td>创建人</td>
						</tr>
					</thead>
					<tbody id="tranHistoryBody">
						<%--<tr>
							<td>资质审查</td>
							<td>5,000</td>
							<td>10</td>
							<td>2017-02-07</td>
							<td>2016-10-10 10:10:10</td>
							<td>zhangsan</td>
						</tr>
						<tr>
							<td>需求分析</td>
							<td>5,000</td>
							<td>20</td>
							<td>2017-02-07</td>
							<td>2016-10-20 10:10:10</td>
							<td>zhangsan</td>
						</tr>
						<tr>
							<td>谈判/复审</td>
							<td>5,000</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>2017-02-09 10:10:10</td>
							<td>zhangsan</td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	
	<div style="height: 200px;"></div>
	
</body>
</html>