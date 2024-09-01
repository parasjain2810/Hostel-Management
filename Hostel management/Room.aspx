<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Room.aspx.cs" Inherits="Room" EnableEventValidation="False" %>






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
                        <h2>Rooms</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Entry</a>
                            </li>
                            <li class="active">
                                <strong>Rooms</strong>
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
                                                                <asp:Label ID="lblhostelwings" runat="server" CssClass="col-sm-4 control-label" Text="Hostel Wings"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlWingName" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="HostelName" DataValueField="HostelId">
                                                                        <asp:ListItem Value="0">--Select Hostel Wing--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvHostelName" runat="server" ControlToValidate="ddlWingName" InitialValue="0" ValidationGroup="A" ErrorMessage="Hostel Wing is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblroom" runat="server" CssClass="col-sm-4 control-label" Text="Room"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtroom" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvReceivedFees" runat="server" ControlToValidate="txtroom" ValidationGroup="A" ErrorMessage="Room is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblFloor" runat="server" CssClass="col-sm-4 control-label" Text="Floor"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:DropDownList ID="DDLFloor" runat="server" AppendDataBoundItems="true" CssClass="form-control">
                                                                        <asp:ListItem Value="0">--Select Floor--</asp:ListItem>
                                                                        <asp:ListItem Value="1st Floor">1st Floor</asp:ListItem>
                                                                        <asp:ListItem Value="2nd Floor">2nd Floor</asp:ListItem>
                                                                        <asp:ListItem Value="3rd Floor">3rd Floor</asp:ListItem>
                                                                       
                                                                       
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" ControlToValidate="DDLFloor" ValidationGroup="A" ErrorMessage="Floor is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>



                                                                <asp:Label ID="lblroomtype" runat="server" CssClass="col-sm-1 control-label" InitialValue="0" Text="Room Type"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:DropDownList ID="ddlRoomtype" runat="server" AppendDataBoundItems="true" CssClass="form-control">
                                                                        <asp:ListItem Value="0">--Select Room Type--</asp:ListItem>
                                                                        <asp:ListItem Value="1 Seater">1 Seater</asp:ListItem>
                                                                        <asp:ListItem Value="2 Seater">2 Seater</asp:ListItem>
                                                                        
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" InitialValue="0" ControlToValidate="ddlRoomtype" ValidationGroup="A" ErrorMessage="Room type is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>

                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblReceivedFees" runat="server" CssClass="col-sm-4 control-label" Text="Rent"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtrent" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtrent" ValidationGroup="A" ErrorMessage="Rent is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblFacilities" runat="server" CssClass="col-sm-4 control-label" Text="Facilities"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlfacilities" runat="server" AppendDataBoundItems="true" CssClass="form-control">
                                                                        <asp:ListItem Value="0">--Select Facilities--</asp:ListItem>
                                                                        <asp:ListItem Value="Attacher Washroom">Attacher Washroom</asp:ListItem>
                                                                        <asp:ListItem Value="Comman Washroom">Comman Washroom</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" InitialValue="0" ControlToValidate="ddlfacilities" ValidationGroup="A" ErrorMessage="Facilities is required" CssClass="text-danger"></asp:RequiredFieldValidator>
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
                                                                            <asp:BoundField DataField="HostelName" HeaderText="Hostel" />
                                                                            <asp:BoundField DataField="RoomNo" HeaderText="Room No." />
                                                                            <asp:BoundField DataField="Floor" HeaderText="Floor" />
                                                                            <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                                                                            <asp:BoundField DataField="Facilities" HeaderText="Facilities" />
                                                                            <asp:BoundField DataField="Rent" HeaderText="Rent" />

                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-primary btn-xs" OnClick="btnEdit_Click" CommandArgument='<%#Eval("RoomId") %>' />
                                                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-xs" OnClick="btndeleted_click" CommandArgument='<%#Eval("RoomId") %>' />
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



