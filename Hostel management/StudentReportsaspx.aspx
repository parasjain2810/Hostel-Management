<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentReportsaspx.aspx.cs" Inherits="StudentReportsaspx" %>


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
    <link href="css/plugins/dataTables/datatables.min.css" rel="stylesheet">
    <style>
        label {
            margin-left: 4px;
            text-decoration: none;
            font-weight: 500;
        }
        .sectioncss{
                    width: 3.33333333%;
        padding-top: 9px;
    }
        


        .ajax__calendar_container {
            width: 100%;
            z-index: 9999999999 !important;
        }

        div.dataTables_wrapper div.dataTables_filter {
            text-align: right;
        }
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
                        <h2>Student Report</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Reports</a>
                            </li>
                            <li class="active">
                                <strong>Student Report</strong>
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
                                <div class="animated fadeInRight">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="ibox float-e-margins">
                                                <div class="ibox-title" style="border-style: none">
                                                    <h5></h5>
                                                    <div class="ibox-tools">
                                                        <div class="ibox-tools">
                                                            <a class="collapse-link">
                                                                <i class="fa fa-chevron-up"></i>
                                                            </a>
                                                            <a class="close-link">
                                                                <i class="fa fa-times"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="ibox-content" style="border-style: none">
                                                    <div class="form-horizontal">
                                                        <asp:Label runat="server" ID="Label1" Visible="false" Text="0"></asp:Label>
                                                        <div class="form-group">
                                                            <asp:Label ID="lblclass" runat="server" CssClass="col-sm-1 sectioncss" Text="Class"></asp:Label>
                                                            <div class="col-sm-2">
                                                                <asp:DropDownList ID="ddlclass" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Class" DataValueField="ClassId" AutoPostBack="true" OnTextChanged="classselect">
                                                                    <asp:ListItem Value="0">--select class--</asp:ListItem>
                                                                    <asp:ListItem Value="all">All</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="A" ControlToValidate="ddlclass" InitialValue="0" ErrorMessage="Class is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                            </div>
                                                            <asp:Label ID="lblsection" runat="server" CssClass=" col-sm-1 sectioncss" Text="Section"></asp:Label>
                                                            <div class="col-sm-2">
                                                                <asp:DropDownList ID="ddlsection" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Section" DataValueField="SectionId">
                                                                    <asp:ListItem Value="0">--Select Section--</asp:ListItem>
                                                                     
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblError" runat="server"></asp:Label>
                                                            </div>
                                                            <div class="col-sm-0 col-sm-offset-0">
                                                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" ValidationGroup="A" Text="Search" OnClick="btnSubmit_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="table-responsive">
                                                        <asp:GridView ID="GridViewStudents" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover dataTables-example">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sr No.">
                                                                    <ItemTemplate><%# Container.DataItemIndex + 1 %></ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                                                                <asp:BoundField DataField="MobileNo" HeaderText="Mobile No." />
                                                                <asp:BoundField DataField="DOB" HeaderText="Date of Birth" DataFormatString="{0:dd-MMM-yyyy}" />
                                                                <asp:BoundField DataField="RollNo" HeaderText="Roll No." />
                                                                <asp:BoundField DataField="Address" HeaderText="Address" />
                                                                <asp:BoundField DataField="FatherName" HeaderText="Father's Name" />
                                                                <asp:BoundField DataField="MotherName" HeaderText="Mother's Name" />
                                                                <asp:BoundField DataField="Class" HeaderText="Class" />
                                                                <asp:BoundField DataField="Section" HeaderText="Section" />
                                                                <asp:BoundField DataField="Cities" HeaderText="Cities" />
                                                                <asp:BoundField DataField="Gender" HeaderText="Gender" />
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
    </form>

    <uc1:footerscript runat="server" ID="footerscript" />
    <script src="assets/js/plugins/dataTables/datatables.min.js"></script>

</body>


</html>

