<%@ Page Language="C#" AutoEventWireup="true" CodeFile="section.aspx.cs" Inherits="section" EnableEventValidation="False" %>


<%@ Register Src="~/footerscript.ascx" TagPrefix="uc1" TagName="footerscript" %>
<%@ Register Src="~/nav.ascx" TagPrefix="uc1" TagName="nav" %>
<%@ Register Src="~/csslinks.ascx" TagPrefix="uc1" TagName="csslinks" %>
<%@ Register Src="~/headerlinks.ascx" TagPrefix="uc1" TagName="headerlinks" %>

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
        <div id="wrapper">
            <uc1:nav runat="server" ID="nav" />
            <div id="page-wrapper" class="gray-bg">
                <uc1:headerlinks runat="server" ID="headerlinks" />
                <div class="row wrapper border-bottom white-bg page-heading">
                    <div class="col-lg-10">
                        <h2>Section</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Masters</a>
                            </li>
                            <li class="active">
                                <strong>Section</strong>
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

                                                        <div class="ibox-tools">
                                                        </div>
                                                    </div>
                                                    <div class="ibox-content" style="border-style: none">
                                                        <div class="form-horizontal">
                                                            <asp:Label runat="server" ID="lblId" Visible="false" Text="0"></asp:Label>
                                                            <div class="form-group">
                                                                <asp:Label ID="lblClass" runat="server" CssClass="col-sm-4 control-label" Text="Class"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlclass" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Class" DataValueField="ClassId">
                                                                        <asp:ListItem Value="0">--select class--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlclass" ValidationGroup="A" InitialValue="0" ErrorMessage="Class is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblsection" runat="server" CssClass="col-sm-4 control-label" Text="New Section"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtsection" runat="server" CssClass="form-control" Placeholder="Enter new section"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvsection" runat="server" ControlToValidate="txtsection" ValidationGroup="A" ErrorMessage="Section Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="col-sm-4 col-sm-offset-4">
                                                                    <asp:Button ID="ButtonCancel" runat="server" CssClass="btn btn-white" Text="Cancel" OnClick="cancel" />
                                                                    <asp:Button ID="ButtonSaveChanges" runat="server" CssClass="btn btn-primary" Text="Save changes " ValidationGroup="A" OnClick="btnSubmit_Click" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div id="tab-2" class="tab-pane">
                                        <div class=" animated fadeInRight">
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
                                                               
                                                                    <asp:GridView ID="GridViewCities" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover dataTables-example">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Sr No.">
                                                                                <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                                                                            </asp:TemplateField>

                                                                            <asp:BoundField DataField="Class" HeaderText="Class" />
                                                                            <asp:BoundField DataField="Section" HeaderText="Section" />

                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" CommandArgument='<%#Eval("SectionId") %>' CssClass="btn btn-primary btn-xs" />
                                                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-xs" OnClick="btndeleted_click" CommandArgument='<%#Eval("SectionId") %>' />
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
            <uc1:footerscript runat="server" ID="footerscript" />
    </form>
</body>

</html>

