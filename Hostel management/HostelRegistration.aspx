<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HostelRegistration.aspx.cs" Inherits="HostelRegistration" EnableEventValidation="false" %>



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
                        <h2>Hostel Registration</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Entry</a>
                            </li>
                            <li class="active">
                                <strong>Hostel Registration</strong>
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
                                                            <asp:Label runat="server" ID="Label1" Visible="false" Text="0"></asp:Label>
                                                            <div class="form-group">
                                                                <asp:Label ID="lblClass" runat="server" CssClass="col-sm-4 control-label" Text="Class"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlClass" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Class" DataValueField="ClassId" AutoPostBack="true" OnTextChanged="classselect">
                                                                        <asp:ListItem Value="" Text="Select Class"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvRoomCategory" runat="server" ControlToValidate="ddlClass" InitialValue="0" ValidationGroup="A" ErrorMessage="Class is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label runat="server" ID="lblId" Text="0" Visible="false"></asp:Label>
                                                                <asp:Label ID="lblStudentName" runat="server" CssClass="col-sm-4 control-label" Text="Student Name"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlStudentName" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="StudentName" DataValueField="StudentId">
                                                                        <asp:ListItem Value="0">--Select Student Name--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvStudentName" runat="server" InitialValue="0" ControlToValidate="ddlStudentName" ValidationGroup="A" ErrorMessage="Student Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <asp:Label ID="lblhostelwings" runat="server" CssClass="col-sm-4 control-label" Text="Hostel Wings"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlWingName" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="HostelName" DataValueField="HostelId" AutoPostBack="true" OnTextChanged="roomno">
                                                                        <asp:ListItem Value="0">--Select Hostel Wing--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvHostelName" runat="server" ControlToValidate="ddlWingName" InitialValue="0" ValidationGroup="A" ErrorMessage="Hostel Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblRoomNumber" runat="server" CssClass="col-sm-4 control-label" Text="Room Number"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlroomno" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="RoomNo" DataValueField="RoomId">
                                                                        <asp:ListItem Value="" Text="Select Room Number"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlroomno" InitialValue="0" ValidationGroup="A" ErrorMessage="Room Number is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="col-sm-4 col-sm-offset-4">
                                                                    <asp:Button ID="ButtonCancel" runat="server" CssClass="btn btn-white" Text="Cancel" OnClick="cancel"/>
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
                                                                            <asp:BoundField DataField="HostelName" HeaderText="HostelName" />
                                                                            <asp:BoundField DataField="Class" HeaderText="Class" />
                                                                            <asp:BoundField DataField="RoomNo" HeaderText="RoomNo" />
                                                                            <asp:BoundField DataField="Floor" HeaderText="Floor" />
                                                                            <asp:BoundField DataField="Rent" HeaderText="Rent" />
                                                                            <asp:BoundField DataField="Facilities" HeaderText="Facilities" />
                                                                            <asp:BoundField DataField="RoomType" HeaderText="RoomType" />
                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-primary btn-xs" OnClick="btnEdit_Click" CommandArgument='<%#Eval("StudentHostelId") %>' />
                                                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-xs" OnClick="btndeleted_click" CommandArgument='<%#Eval("StudentHostelId") %>' />
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
</body>



</html>


