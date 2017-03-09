<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="/common/global.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<script type="text/javascript" src="${ctx}/common/plugins/assets/js/date-time/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="${ctx}/common/plugins/assets/js/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/common/plugins/assets/js/bootbox.js"></script>
<script type="text/javascript" src="${ctx }/common/plugins/assets/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/common/plugins/dist/js/bootstrap.min.js"></script>


<link rel="stylesheet" href="${ctx}/common/plugins/assets/css/jquery-ui.custom.css" />
<link rel="stylesheet" href="${ctx}/common/plugins/assets/css/jquery.gritter.css" />
<link rel="stylesheet" href="${ctx}/common/plugins/assets/css/select2.css" />
<link rel="stylesheet" href="${ctx}/common/plugins/assets/css/datepicker.css" />
<link rel="stylesheet" href="${ctx}/common/plugins/assets/css/bootstrap-editable.css" />
<link rel="stylesheet" href="${ctx}/common/plugins/assets/css/bootstrap.css" />

<style>
   #div1{
position: fixed;
margin:20px auto;
background: #dddddd;
width: 400px;
height: 250px;
margin-left:350px;
margin-top:10px;
}
</style>
<SCRIPT type="text/javascript">
	var setting = {
		check : {
			enable : true,
			chkboxType : {
				"Y" : "",
				"N" : ""
			}
		},
		view : {
			dblClickExpand : false
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			beforeClick : beforeClick,
			onCheck : onCheck
		}
	};
	var zNodes;
	function beforeClick(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		zTree.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}

	function onCheck(e, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"), nodes = zTree
				.getCheckedNodes(true), v = "";
		id = "";
		for (var i = 0, l = nodes.length; i < l; i++) {
			v += nodes[i].name + ",";
			id += nodes[i].id + ",";
		}
		if (v.length > 0)
			v = v.substring(0, v.length - 1);
		var cityObj = $("#citySel");
		cityObj.attr("value", v);
		if (id.length > 0)
			id = id.substring(0, id.length - 1);
		$("#deptID").attr("value", id);
	}

	function showMenu() {
		var cityObj = $("#citySel");
		var cityOffset = $("#citySel").offset();
		$("#menuContent").css({
			left : cityOffset.left - 330 + "px",
			top : cityOffset.top - 35 + cityObj.outerHeight() + "px"
		}).slideDown("fast");

		$("body").bind("mousedown", onBodyDown);
	}
	function hideMenu() {
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		if (!(event.target.id == "menuBtn" || event.target.id == "citySel"
				|| event.target.id == "menuContent" || $(event.target).parents(
				"#menuContent").length > 0)) {
			hideMenu();
		}
	}

	$(document).ready(
			function() {
				$.ajax({
					type : 'post',
					dataType : "json",
					url : '${ctx}/department/getDeparmentList.ht',
					complete : function(response) {
						$.fn.zTree.init($("#treeDemo"), setting, eval("("
								+ response.responseText + ")"));
					}
				});
				$.ajax({
					type : 'post',
					url : '${ctx}/role/getRoleSelectList.ht',
					success : function(data) {
						$("#roleValue").append(data);
					}
				});

			});
	/*  $(document).on("click","#input1",function(e){
         bootbox.prompt({
         title:"选择项目人员",
         inputType:"checkbox",
         inputOptions:[
         {
           text:"choice one",
           value:'1',
         },
         {
           text:"choice two",
           value:'2',
         },
         {
           text:"choice three",
           value:'3',
         }
         ],
         callback:function(result){
         console.log(result);
         }
         });	                                                                                                           
     }); */
</SCRIPT>
<div class="row">
	<div class="col-xs-12">
		<table id="grid-table"></table>
		<div id="grid-pager"></div>
	</div>
</div>
<div id="modal-table" class="modal fade" tabindex="-1" data-backdrop="static">
	<div class="modal-dialog" style="min-width: 420px;">
		<div class="modal-content">
			<div class="modal-body" style="max-height: 500px;">
				<div class="row">
					<div class="col-xs-12">
						<!-- PAGE CONTENT BEGINS -->
						<div>
							<div id="user-profile-3" class="user-profile row">
								<div class="col-sm-offset-1 col-sm-10">
									<div class="space"></div>

									<form class="form-horizontal" id="userForm">
										<div class="tabbable">
											<ul class="nav nav-tabs padding-16">
												<li class="active">
													<!-- <a data-toggle="tab" href="#edit-basic">
										<i class="green ace-icon fa fa-pencil-square-o bigger-125"></i>
										添加纪录
									</a> -->
												</li>
											</ul>

											<div class="tab-content profile-edit-tab-content">
												<div id="edit-basic" class="tab-pane in active">
													<h4 class="header blue bolder smaller">添加新项目</h4>

													<div class="row">
														<div class="vspace-12-sm"></div>

														<div class="col-xs-12 col-sm-8">
															<div class="form-group">
																<label class="col-sm-4 control-label no-padding-right"
																	for="form-field-userName">项目名称</label>

																<div class="col-sm-8">
																	<input class="col-xs-12 col-sm-10" type="text"
																		id="projectName" name="projectName" placeholder="项目名称" />
																</div>
															</div>

															<div class="form-group">
																<label class="col-sm-4 control-label no-padding-right"
																	for="form-field-userName">项目权限</label>

																<div class="col-sm-8">
																	<select class="col-xs-12 col-sm-10">
																		<option></option>
																		<option value="commom">共有项目</option>
																		<option value="private">私有项目</option>
																	</select>
																</div>
															</div>

															<div class="space-4"></div>

															<div class="form-group">
																<label class="col-sm-4 control-label no-padding-right"
																	for="form-field-birthday">备注</label>

																<!-- <div class="col-sm-8">
													<div class="content_wrap">
														<div class="zTreeDemoBackground left">
															<ul class="list">
																<li class="title">
																<input id="citySel" type="text" readonly value="" onclick="showMenu();" />
																<input type="hidden" id="deptID" name="deptID" value=""/>
																</li>
															</ul>
														</div>
													</div>
												</div> -->
																<div class="col-sm-8">
																	<input class="col-xs-12 col-sm-10" type="text"
																		id="name" name="name" placeholder="项目备注" />
																</div>
															</div>

															<div class="space-4"></div>

															<div class="form-group">
																<label class="col-sm-4 control-label no-padding-right"
																	for="form-field-birthday">项目人员</label>
																<!-- <textarea class="col-xs-12 col-sm-10" type="text" id="name" name="name" placeholder="" ></textarea> -->
																<div class="col-sm-8">
																	<textarea class="col-xs-12 col-sm-10" type="text" id="input1" name="person" placeholder="" onclick="popup()"></textarea>
																</div>	
																								                                                           
	                                                           <script>	                                                       	                                                           	                                                	    	
	                                                           $(document).on("click","#input1",function(e){
	                                                        	  e.preventDefault();
	                                                        	  var debateModal;
	                                                        	  
	                                                        	  $.ajax({
	                                                        		 url: '${ctx}/user/getUserList.ht',
	                                                        	     type:"POST",
	                                                        	     data:{},
	                                                        	     dataType:'json'	                                                        	    
	                                                        	  }).done(function(info){ 	                                                      		 
	                                                        		 var options = [];
	                                                        		 for(var i=0;i<info.length;i++){
	                                                        			  var user = {};
	                                                        			  user.text = info[i].name;
	                                                        			  user.value = info[i].userName;
	                                                        			  options[i] = user;
	                                                        		  }
	                                                        		  debateModal=bootbox.prompt({
	                                                        			    title: "选择项目人员",
	                                                        			    inputType: 'checkbox',
	                                                        			    inputOptions: options,
	                                                        			    callback: function (result) {
	                                                        			        console.log(result);
	                                                        			    }
	                                                        			});
	                                                        	  }); 
	                                                        	  
	                                                        	  /* $('#input1').on('click', function (e) {
	                                                                  $.ajax({
	                                                                      url: '${ctx}/user/getUserList.ht',
	                                                                      type: 'POST',
	                                                                      dataType: 'json'
	                                                                  }).done(function (result) {
	                                                                      console.log(result.Mensaje);
	                                                                  });
	                                                              }); */
	                                                        	 /*  bootbox.dialog({                 //write like this can get data and display.
	                                                        		 message:'it can work...',
	                                                        		 title:'please choose',
	                                                        		 closeButton:true
	                                                        	  }); */
	                                                           });
	                                                           </script>
	                                                           
																<!-- <div id="div1" style="display: none;">
																	<label><input name="checkbox" type="checkbox" value="">110</label><br>
																	<label><input name="checkbox" type="checkbox" value="">111</label><br> 
																	<label><input name="checkbox" type="checkbox" value="">112</label><br> 
																	<label><input name="checkbox" type="checkbox" value="">113</label><br> 
																	<label><input name="checkbox" type="checkbox" value="">114</label><br> 
																	<input type="button" value="确定添加" onclick="selectPerson()" />
																</div>
															</div>
															<script>
																function popup() {
																	var div1 = document.getElementById("div1");
																	div1.style.display = "block";
																}
																function selectPerson() {
																	var input1 = document.getElementById("input1");
																	var div1 = document.getElementById("div1");
																	var select1 = document.getElementById("select1");
																	input1.value = select1.value;
																	div1.style.display = "none";
																}
															</script> -->
															
														</div>
													</div>

													<!-- <div class="space"></div> -->

												</div>
											</div>
										</div>
										<div class="clearfix form-actions">
											<div class="col-md-offset-3 col-md-9">
												<button id="submitButton" class="btn btn-info" type="button">
													<i class="ace-icon fa fa-check bigger-110"></i> 保存
												</button>
												&nbsp; &nbsp;
												<button id="closeButton" class="btn" type="button">
													<i class="ace-icon fa fa-close bigger-110"></i> 关闭
												</button>
											</div>
										</div>
										<div id="menuContent" class="menuContent"
											style="display: none; position: absolute;">
											<ul id="treeDemo" class="ztree"
												style="margin-top: 0; width: 200px; height: 300px;"></ul>
										</div>
									</form>
								</div>
								<!-- /.span -->
							</div>
							<!-- /.user-profile -->
						</div>

						<!-- PAGE CONTENT ENDS -->
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<!-- page specific plugin scripts -->
<script type="text/javascript">
	var scripts = [ null, "", null ]
	$('.page-content-area')
			.ace_ajax(
					'loadScripts',
					scripts,
					function() {
						// inline scripts related to this page
						jQuery(function($) {
							var grid_selector = "#grid-table";
							var pager_selector = "#grid-pager";

							// resize to fit page size
							$(window).on(
									'resize.jqGrid',
									function() {
										$(grid_selector).jqGrid('setGridWidth',
												$(".page-content").width());
									})
							// resize on sidebar collapse/expand
							var parent_column = $(grid_selector).closest(
									'[class*="col-"]');
							$(document)
									.on(
											'settings.ace.jqGrid',
											function(ev, event_name, collapsed) {
												if (event_name === 'sidebar_collapsed'
														|| event_name === 'main_container_fixed') {
													// setTimeout is for webkit only to give time for DOM changes and then redraw!!!
													setTimeout(
															function() {
																$(grid_selector)
																		.jqGrid(
																				'setGridWidth',
																				parent_column
																						.width());
															}, 0);
												}
											})

							jQuery(grid_selector)
									.jqGrid(
											{
												subGrid : false,
												url : "${ctx}/project/getProject.ht",
												datatype : "json",
												height : "100%",
												colNames : [ 'ID', '项目名称',
														'项目权限', '项目状态', '备注',
														'创建时间', '操作' ],
												colModel : [
														{
															name : 'id',
															index : 'id',
															label : 'ID',
															width : 60,
															sorttype : "int",
															search : false,
															hidden : true
														},
														{
															name : 'projectName',
															index : 'projectName',
															label : '项目名称',
															width : 100,
															editable : true,
															editoptions : {
																size : "20",
																maxlength : "50"
															},
															searchoptions : {
																sopt : [ 'cn' ]
															},
															editrules : {
																required : true
															},

														},
														{
															name : 'projectAuthority',
															index : 'projectAuthority',
															label : '项目权限',
															width : 80,
															editable : true,
															editoptions : {
																size : "20",
																maxlength : "50"
															},
															searchoptions : {
																sopt : [ 'cn' ]
															},
															editrules : {
																required : true
															}
														},
														{
															name : 'status',
															index : 'status',
															label : '状态',
															width : 80,
															editable : true,
															edittype : "checkbox",
															editoptions : {
																value : "开启:关闭"
															},
															unformat : aceSwitch,
															search : false,
															formatter : function(
																	cellvalue,
																	options,
																	rowObject) {
																return (cellvalue == 1 || cellvalue == "关闭") ? "关闭"
																		: "开启";
															}
														},
														{
															name : 'remarks',
															index : 'remarks',
															label : '备注',
															width : 80,
															editable : true,
															edittype : "textarea",
															editoptions : {
																size : "20",
																maxlength : "50"
															}
														/* edittype : "select",
														editoptions : {value : "1:男;2:女"},
														search : false,
														formatter:function(cellvalue, options, rowObject){
															return (cellvalue==1||cellvalue=="男")?"男":"女"; 
														}*/
														},
														{
															name : 'createTime',
															index : 'createTime',
															label : '创建时间',
															width : 125,
															sorttype : "date",
															search : false,
															formatter : 'date',
															formatoptions : {
																srcformat : 'Y-m-d H:i:s',
																newformat : 'Y-m-d H:i:s'
															}
														},
														{
															name : '',
															index : '',
															width : 80,
															fixed : true,
															sortable : false,
															resize : false,
															formatter : 'actions',
															formatoptions : {
																keys : true,
																//delbutton : false,//disable delete button
																delOptions : {
																	recreateForm : true,
																	beforeShowForm : beforeDeleteCallback
																}
															//editformbutton:true, editOptions:{recreateForm:true, beforeShowForm:beforeEditCallback}
															}
														} ],
												//scroll : 1, // set the scroll property to 1 to enable paging with scrollbar - virtual loading of records
												sortname : "id",
												sortorder : "asc",
												viewrecords : true,
												rowNum : 10,
												rowList : [ 10, 20, 30 ],
												pager : pager_selector,
												altRows : true,
												//toppager : true,
												multiselect : true,
												//multikey : "ctrlKey",
												multiboxonly : true,
												loadComplete : function() {
													var table = this;
													setTimeout(
															function() {
																styleCheckbox(table);
																updateActionIcons(table);
																updatePagerIcons(table);
																enableTooltips(table);
															}, 0);
												},
												editurl : "${ctx}/project/operateProject.ht"
											});
							$(window).triggerHandler('resize.jqGrid');// trigger window resize to make the grid get the correct size

							// enable search/filter toolbar
							// jQuery(grid_selector).jqGrid('filterToolbar',{defaultSearch:true,stringResult:true})
							// jQuery(grid_selector).filterToolbar({});
							// switch element when editing inline
							function aceSwitch(cellvalue, options, cell) {
								setTimeout(
										function() {
											$(cell)
													.find(
															'input[type=checkbox]')
													.addClass(
															'ace ace-switch ace-switch-5')
													.after(
															'<span class="lbl"></span>');
										}, 0);
							}

							// enable datepicker
							function pickDate(cellvalue, options, cell) {
								setTimeout(function() {
									$(cell).find('input[type=text]')
											.datepicker({
												format : 'yyyy-mm-dd',
												autoclose : true,
												language : 'zh-CN'
											});
								}, 0);
							}
							$("#submitButton")
									.click(
											function() {
												$
														.ajax({
															type : 'post',
															url : '${ctx}/project/addProject.ht',
															data : $(
																	"#projectForm")
																	.serialize(),
															success : function(
																	response) {
																var result = eval("("
																		+ response.responseText
																		+ ")");
																$(
																		"#modal-table")
																		.modal(
																				"toggle");
																jQuery(
																		grid_selector)
																		.trigger(
																				"reloadGrid");
															}
														});
											});
							$("#closeButton").click(function() {
								$("#modal-table").modal("toggle");
							});
							// navButtons
							jQuery(grid_selector)
									.jqGrid(
											'navGrid',
											pager_selector,
											{ // navbar options
												edit : <shiro:hasPermission name="${ROLE_KEY}:sysuser:edit">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:edit">false</shiro:lacksPermission>,
												editicon : 'ace-icon fa fa-pencil blue',

												add : <shiro:hasPermission name="${ROLE_KEY}:sysuser:add">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:add">false</shiro:lacksPermission>,
												addicon : 'ace-icon fa fa-plus-circle purple',

												del : <shiro:hasPermission name="${ROLE_KEY}:sysuser:delete">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:delete">false</shiro:lacksPermission>,
												delicon : 'ace-icon fa fa-trash-o red',

												search : <shiro:hasPermission name="${ROLE_KEY}:sysuser:search">false</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:search">false</shiro:lacksPermission>,
												searchicon : 'ace-icon fa fa-search orange',

												refresh : true,
												refreshicon : 'ace-icon fa fa-refresh blue',

												view : <shiro:hasPermission name="${ROLE_KEY}:sysuser:view">true</shiro:hasPermission><shiro:lacksPermission name="${ROLE_KEY}:sysuser:view">false</shiro:lacksPermission>,
												viewicon : 'ace-icon fa fa-search-plus grey'
											},
											{
												// edit record form
												// closeAfterEdit: true,
												// width: 700,
												recreateForm : true,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-titlebar')
															.wrapInner(
																	'<div class="widget-header" />')
													style_edit_form(form);
												},
												errorTextFormat : function(
														response) {
													var result = eval('('
															+ response.responseText
															+ ')');
													return result.message;
												}
											},
											{
												// new record form
												// width: 700,
												closeAfterAdd : true,
												recreateForm : true,
												viewPagerButtons : false,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-titlebar')
															.wrapInner(
																	'<div class="widget-header" />')
													style_edit_form(form);
												},
												errorTextFormat : function(
														response) {
													var result = eval('('
															+ response.responseText
															+ ')');
													return result.message;
												}
											},
											{
												// delete record form
												recreateForm : true,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													if (form.data('styled'))
														return false;
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-titlebar')
															.wrapInner(
																	'<div class="widget-header" />')
													style_delete_form(form);
													form.data('styled', true);
												},
												onClick : function(e) {
													// alert(1);
												}
											},
											{
												// search form
												recreateForm : true,
												afterShowSearch : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-title')
															.wrap(
																	'<div class="widget-header" />')
													style_search_form(form);
												},
												afterRedraw : function() {
													style_search_filters($(this));
												},
												multipleSearch : true
											/**
											 * multipleGroup:true, showQuery: true
											 */
											},
											{
												// view record form
												recreateForm : true,
												beforeShowForm : function(e) {
													var form = $(e[0]);
													form
															.closest(
																	'.ui-jqdialog')
															.find(
																	'.ui-jqdialog-title')
															.wrap(
																	'<div class="widget-header" />')
												}
											})
									.navButtonAdd(
											pager_selector,
											{
												caption : "",
												title : "添加新纪录",
												buttonicon : 'ace-icon fa fa-plus-circle purple',

												onClickButton : function() {
													//$("#projectForm")[0].reset();
													//alert("456");
													$("#modal-table").modal(
															"toggle");

												},
												position : "first"
											})

							function style_edit_form(form) {
								// enable datepicker on "birthday" field and switches for "stock" field
								form.find('input[name=birthday]').datepicker({
									format : 'yyyy-mm-dd',
									autoclose : true,
									language : 'zh-CN'
								})

								form.find('input[name=statusCn]').addClass(
										'ace ace-switch ace-switch-5').after(
										'<span class="lbl"></span>');
								// don't wrap inside a label element, the checkbox value won't be submitted (POST'ed)
								// .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');

								// update buttons classes
								var buttons = form.next().find(
										'.EditButton .fm-button');
								buttons.addClass('btn btn-sm').find(
										'[class*="-icon"]').hide();// ui-icon, s-icon
								buttons.eq(0).addClass('btn-primary').prepend(
										'<i class="ace-icon fa fa-check"></i>');
								buttons.eq(1).prepend(
										'<i class="ace-icon fa fa-times"></i>')

								buttons = form.next().find('.navButton a');
								buttons.find('.ui-icon').hide();
								buttons
										.eq(0)
										.append(
												'<i class="ace-icon fa fa-chevron-left"></i>');
								buttons
										.eq(1)
										.append(
												'<i class="ace-icon fa fa-chevron-right"></i>');
							}

							function style_delete_form(form) {
								var buttons = form.next().find(
										'.EditButton .fm-button');
								buttons.addClass(
										'btn btn-sm btn-white btn-round').find(
										'[class*="-icon"]').hide();// ui-icon, s-icon
								buttons
										.eq(0)
										.addClass('btn-danger')
										.prepend(
												'<i class="ace-icon fa fa-trash-o"></i>');
								buttons.eq(1).addClass('btn-default').prepend(
										'<i class="ace-icon fa fa-times"></i>')
							}

							/* function style_search_filters(form) {
								form.find('.delete-rule').val('X');
								form.find('.add-rule').addClass('btn btn-xs btn-primary');
								form.find('.add-group').addClass('btn btn-xs btn-success');
								form.find('.delete-group').addClass('btn btn-xs btn-danger');
							}
							function style_search_form(form) {
								var dialog = form.closest('.ui-jqdialog');
								var buttons = dialog.find('.EditTable')
								buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
								buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'ace-icon fa fa-comment-o');
								buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'ace-icon fa fa-search');
							} */

							function beforeDeleteCallback(e) {
								var form = $(e[0]);
								if (form.data('styled'))
									return false;
								form.closest('.ui-jqdialog').find(
										'.ui-jqdialog-titlebar').wrapInner(
										'<div class="widget-header" />')
								style_delete_form(form);
								form.data('styled', true);
							}

							function beforeEditCallback(e) {
								var form = $(e[0]);
								form.closest('.ui-jqdialog').find(
										'.ui-jqdialog-titlebar').wrapInner(
										'<div class="widget-header" />')
								style_edit_form(form);
							}

							// it causes some flicker when reloading or navigating grid
							// it may be possible to have some custom formatter to do this as the grid is being created to prevent this
							// or go back to default browser checkbox styles for the grid
							function styleCheckbox(table) {
								/**
								 * $(table).find('input:checkbox').addClass('ace') .wrap('<label />') .after('<span class="lbl align-top" />') $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
								 * .find('input.cbox[type=checkbox]').addClass('ace') .wrap('<label />').after('<span class="lbl align-top" />');
								 */
							}

							// unlike navButtons icons, action icons in rows seem to be hard-coded
							// you can change them like this in here if you want
							function updateActionIcons(table) {
								/**
								 * var replacement = { 'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue', 'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red', 'ui-icon-disk' : 'ace-icon fa fa-check green', 'ui-icon-cancel' :
								 * 'ace-icon fa fa-times red' }; $(table).find('.ui-pg-div span.ui-icon').each(function(){ var icon = $(this); var $class = $.trim(icon.attr('class').replace('ui-icon', '')); if($class in replacement)
								 * icon.attr('class', 'ui-icon '+replacement[$class]); })
								 */
							}

							// replace icons with FontAwesome icons like above
							function updatePagerIcons(table) {
								var replacement = {
									'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
									'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
									'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
									'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
								};
								$(
										'.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon')
										.each(
												function() {
													var icon = $(this);
													var $class = $.trim(icon
															.attr('class')
															.replace('ui-icon',
																	''));

													if ($class in replacement)
														icon
																.attr(
																		'class',
																		'ui-icon '
																				+ replacement[$class]);
												})
							}

							function enableTooltips(table) {
								$('.navtable .ui-pg-button').tooltip({
									container : 'body'
								});
								$(table).find('.ui-pg-div').tooltip({
									container : 'body'
								});
							}

							// var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

							$(document).one('ajaxloadstart.page', function(e) {
								$(grid_selector).jqGrid('GridUnload');
								$('.ui-jqdialog').remove();
							});

						});
					});
</script>
