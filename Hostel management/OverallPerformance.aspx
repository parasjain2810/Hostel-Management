<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OverallPerformance.aspx.cs" Inherits="OverallPerformance" EnableEventValidation="false" %>




<%@ Register Src="~/nav.ascx" TagPrefix="uc1" TagName="nav" %>
<%@ Register Src="~/footerscript.ascx" TagPrefix="uc1" TagName="footerscript" %>
<%@ Register Src="~/headerlinks.ascx" TagPrefix="uc1" TagName="headerlinks" %>
<%@ Register Src="~/csslinks.ascx" TagPrefix="uc1" TagName="csslinks" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>
<html>


<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management | Tabs </title>
    <uc1:csslinks runat="server" ID="csslinks" />
    <style>
        label {
            margin-left: 4px;
            text-decoration: none;
            font-weight: 500;
        }

        .ajax__calendar_container {
            width: 100%;
            z-index: 9999999999 !important;
        }
            div.dataTables_wrapper div.dataTables_filter {
text-align: right;}
    </style>
</head>

<body>
    <form runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div id="wrapper">
            <uc1:nav runat="server" ID="nav" />
            <div id="page-wrapper" class="gray-bg">
                <uc1:headerlinks runat="server" ID="headerlinks" />
                <div class="row wrapper border-bottom white-bg page-heading">
                    <div class="col-lg-10">
                        <h2>Overall Performance</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Entry</a>
                            </li>
                            <li class="active">
                                <strong>Overall Performance</strong>
                            </li>
                        </ol>
                    </div>
                    <div class="col-lg-2">
                    </div>
                </div>
                <div class="wrapper wrapper-content animated fadeIn">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="tabs-container">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="#tab-1">Entry</a></li>
                                    <li class=""><a data-toggle="tab" href="#tab-2">List</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="ibox float-e-margins">
                                                    <div class="ibox-title" style="border-style: none">
                                                        <h5></h5>
                                                        <div class="ibox-tools">
                                                        </div>
                                                    </div>
                                                    <div class="ibox-content" style="border-style: none">
                                                        <div class="form-horizontal">
                                                            <asp:Label runat="server" ID="lblId" Visible="false" Text="0"></asp:Label>



                                                            <div class="form-group">
                                                                <asp:Label ID="lblClass" runat="server" CssClass="col-sm-4 control-label" Text="Class"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlclass" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Class" DataValueField="ClassId" OnTextChanged="classselect" AutoPostBack="true">
                                                                        <asp:ListItem Value="0">--select class--</asp:ListItem>
                                                                    </asp:DropDownList>

                                                                    <asp:RequiredFieldValidator ID="rfvClass" runat="server" InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="A" ErrorMessage="Class is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>


                                                            <div class="form-group">
                                                                <asp:Label ID="lblsection" runat="server" CssClass="col-sm-4 control-label" Text="Section"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlsection" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Section" DataValueField="Sectionid" OnTextChanged="StudentnameSelect" AutoPostBack="true">
                                                                        <asp:ListItem Value="0">--Select Section--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvSection" runat="server" InitialValue="0" ValidationGroup="A" ControlToValidate="ddlsection" ErrorMessage="Section is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label ID="lblStudentName" runat="server" CssClass="col-sm-4 control-label" Text="Student Name"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlStudentName" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="StudentName" DataValueField="StudentId">
                                                                        <asp:ListItem Value="0">--Select Student--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvStudentName" runat="server" InitialValue="0" ControlToValidate="ddlStudentName" ValidationGroup="A" ErrorMessage="Student Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblSem1Percent" runat="server" CssClass="col-sm-4 control-label" Text="Semester 1 %"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtSem1Percent" runat="server" CssClass="form-control" onkeyup="calculateOverallPercent()"></asp:TextBox>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" ValidChars="0123456789" TargetControlID="txtSem1Percent"></cc1:FilteredTextBoxExtender>
                                                                    <asp:RangeValidator ID="rvMath" runat="server" ValidationGroup="A" ControlToValidate="txtSem1Percent" MinimumValue="0" MaximumValue="100" Type="Integer" ErrorMessage="Please enter a valid mark between 0 and 100" CssClass="text-danger"></asp:RangeValidator>
                                                                </div>



                                                                <asp:Label ID="lblSem2Percent" runat="server" CssClass="col-sm-1 control-label" Text="Semester 2 %"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtSem2Percent" runat="server" CssClass="form-control" onkeyup="calculateOverallPercent()"></asp:TextBox>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" ValidChars="0123456789" TargetControlID="txtSem2Percent"></cc1:FilteredTextBoxExtender>
                                                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ValidationGroup="A" ControlToValidate="txtSem2Percent" MinimumValue="0" MaximumValue="100" Type="Integer" ErrorMessage="Please enter a valid mark between 0 and 100" CssClass="text-danger"></asp:RangeValidator>
                                                                </div>



                                                                <asp:Label ID="lblOverallPercent" runat="server" CssClass="col-sm-1 control-label" Text="Overall %"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtOverallPercent" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="col-sm-4 col-sm-offset-4">
                                                                    <asp:Button ID="btncancel" runat="server" CssClass="btn btn-white" Text="Cancel" OnClick="cancel" />
                                                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" ValidationGroup="A" Text="Save changes" OnClick="btnSubmit_Click" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div id="tab-2" class="tab-pane">
                                        <div class="animated fadeInRight">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="ibox float-e-margins">
                                                        <div class="ibox-title" style="border-style: none">
                                                            <h5></h5>
                                                            <div class="ibox-tools">
                                                            </div>
                                                        </div>
                                                        <div class="ibox-content" style="border-style: none">
                                                            <div class="table-responsive">
                                                                
                                                                    <asp:GridView ID="GridViewStudents" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover dataTables-example">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sr No.">
                                                                                <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                                                                            <asp:BoundField DataField="Class" HeaderText="Class" />
                                                                            <asp:BoundField DataField="Section" HeaderText="Section" />
                                                                            <asp:BoundField DataField="Per1" HeaderText="Percent in 1 Sem" />
                                                                            <asp:BoundField DataField="Per2" HeaderText="Percent in 2 Sem" />
                                                                            <asp:BoundField DataField="Overallper" HeaderText="Oveerall percemt" />

                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-primary btn-xs" OnClick="btnEdit_Click" CommandArgument='<%#Eval("OverallResultId") %>' />
                                                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-xs" OnClick="btndeleted_click" CommandArgument='<%#Eval("OverallResultId") %>' />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <uc1:footerscript runat="server" ID="footerscript" />
    <script type="text/javascript">
        function calculateOverallPercent() {
            var sem1 = parseFloat(document.getElementById('<%= txtSem1Percent.ClientID %>').value) || 0;
            var sem2 = parseFloat(document.getElementById('<%= txtSem2Percent.ClientID %>').value) || 0;
            var overall = (sem1 + sem2) / 2;
            document.getElementById('<%= txtOverallPercent.ClientID %>').value = overall.toFixed(2);
        }
        
    </script>
</body>


</html>


