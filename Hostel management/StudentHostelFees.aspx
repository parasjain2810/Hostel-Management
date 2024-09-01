<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentHostelFees.aspx.cs" Inherits="StudentHostelFees" EnableEventValidation="false" %>





<%@ Register Src="~/footerscript.ascx" TagPrefix="uc1" TagName="footerscript" %>
<%@ Register Src="~/nav.ascx" TagPrefix="uc1" TagName="nav" %>
<%@ Register Src="~/csslinks.ascx" TagPrefix="uc1" TagName="csslinks" %>
<%@ Register Src="~/headerlinks.ascx" TagPrefix="uc1" TagName="headerlinks" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>



<!DOCTYPE html>
<html>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management | Tabs </title>
    <uc1:csslinks runat="server" ID="csslinks" />
    <style>
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
                        <h2>Student Hostel  Fees</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Entry</a>
                            </li>
                            <li class="active">
                                <strong>Student Hostel  Fees</strong>
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
                                                                    <asp:DropDownList ID="ddlClass" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Class" DataValueField="ClassId" AutoPostBack="true" OnTextChanged="classselect">
                                                                        <asp:ListItem Value="0">--Select Class--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvClass" runat="server" InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="A" ErrorMessage="Class is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label ID="lblStudentName" runat="server" CssClass="col-sm-4 control-label" Text="Student Name"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlStudentName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" CssClass="form-control" DataTextField="StudentName" DataValueField="StudentId" OnSelectedIndexChanged="selectroomnumber">
                                                                        <asp:ListItem Value="0">--Select Student--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvStudentName" runat="server" InitialValue="0" ControlToValidate="ddlStudentName" ValidationGroup="A" ErrorMessage="Student Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label ID="lblRoomNumber" runat="server" CssClass="col-sm-4 control-label" Text="Room Number"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList  ID="ddlRoomNumber" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="RoomNo" DataValueField="RoomId">
                                                                        <asp:ListItem Value="0">--Select Room Number--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvRoomNumber" runat="server" InitialValue="0" ControlToValidate="ddlRoomNumber" ValidationGroup="A" ErrorMessage="Room Number is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                                
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label ID="lblReceivedFees" runat="server" CssClass="col-sm-4 control-label" Text="Received Fees"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtReceivedFees" runat="server"  CssClass="form-control" ></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvReceivedFees" runat="server" ControlToValidate="txtReceivedFees" ValidationGroup="A" ErrorMessage="Received Fees is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <asp:Label ID="lblBalanceFees" runat="server" CssClass="col-sm-1 control-label" Text="Total Fees"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtBalanceFees" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                                <asp:Label ID="lblPendingFees" runat="server" CssClass="col-sm-1 control-label" Text="Pending Fees"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtPendingFees" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="col-sm-4 col-sm-offset-4">
                                                                    <asp:Button ID="ButtonCancel" runat="server" CssClass="btn btn-white" Text="Cancel" OnClick="cancel" />
                                                                    <asp:Button ID="btnSubmit" runat="server" ValidationGroup="A" CssClass="btn btn-primary" Text="Save changes" OnClick="btnSubmit_Click" />
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
                                                                            <asp:BoundField DataField="Class" HeaderText="Class" />
                                                                            <asp:BoundField DataField="StudentName" HeaderText="StudentName" />
                                                                            <asp:BoundField DataField="RoomNo" HeaderText="RoomNo" />
                                                                            <asp:BoundField DataField="TotalAmount" HeaderText="TotalAmount" />
                                                                            <asp:BoundField DataField="Advance" HeaderText="Advance" />
                                                                            <asp:BoundField DataField="Pending" HeaderText="Pending" />
                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="Button1" runat="server" Text="Edit" CssClass="btn btn-primary btn-xs" OnClick="btnEdit_Click" CommandArgument='<%#Eval("FeeId") %>' />
                                                                                    <asp:Button ID="Button2" runat="server" Text="Delete" CssClass="btn btn-danger btn-xs" OnClick="btndeleted_click" CommandArgument='<%#Eval("FeeId") %>' />
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
    function calculatePendingFees() {
        var receivedFees = document.getElementById('<%= txtReceivedFees.ClientID %>').value;
        var totalFees = document.getElementById('<%= txtBalanceFees.ClientID %>').value;
        
        receivedFees = parseFloat(receivedFees) || 0;
        totalFees = parseFloat(totalFees) || 0;
        var pendingFees = totalFees - receivedFees;

        document.getElementById('<%= txtPendingFees.ClientID %>').value = pendingFees.toFixed(2);
    }

        document.getElementById('<%= txtReceivedFees.ClientID %>').addEventListener('input', calculatePendingFees);
    
</script>
</body>



</html>



