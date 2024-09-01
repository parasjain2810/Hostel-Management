<%@ Page Language="C#" AutoEventWireup="true" CodeFile="studentforms.aspx.cs" Inherits="assets_forms" EnableEventValidation="False" %>



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
                        <h2>Student Registration Form</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Masters</a>
                            </li>
                            <li class="active">
                                <strong>Student Registration Form</strong>
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
                                                                <asp:Label ID="lblId" runat="server" CssClass="  control-label" Visible="false" Text="0"></asp:Label>
                                                                <asp:Label ID="lblStname" runat="server" CssClass=" col-sm-4 control-label" Text="Name"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtStname" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <%--   <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtStname"
                                                                        ForeColor="Red" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                                                                        Display="Dynamic" ErrorMessage="Invalid email" ValidationGroup="f1" />--%>
                                                                    <asp:RequiredFieldValidator ID="rfvStname" runat="server" ValidationGroup="A" ControlToValidate="txtStname" ErrorMessage="Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblDOb" runat="server" CssClass=" col-sm-4 control-label" Text="Date of birth"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtDOB" runat="server" AutoComplete="off" CssClass="form-control"></asp:TextBox>
                                                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server"
                                                                        Enabled="True" Format="dd MMM yyyy" TargetControlID="txtDOB">
                                                                    </cc1:CalendarExtender>
                                                                    <asp:RequiredFieldValidator ID="rfvDOB" runat="server" ValidationGroup="A" ControlToValidate="txtDOB" ErrorMessage="Date of Birth is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblmobileno" runat="server" CssClass="col-sm-4 control-label" Text="Mobile No."></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtmobileno" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" ValidChars="0123456789" TargetControlID="txtmobileno">
                                                                    </cc1:FilteredTextBoxExtender>
                                                                    <asp:RequiredFieldValidator ID="rfvmobileno" runat="server" ValidationGroup="A" ControlToValidate="txtmobileno" ErrorMessage="Mobile no. is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblclass" runat="server" CssClass="col-sm-4 control-label" Text="Class"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:DropDownList ID="ddlclass" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Class" DataValueField="ClassId" AutoPostBack="true" OnTextChanged="classselect">
                                                                        <asp:ListItem Value="0">--select class--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="A" ControlToValidate="ddlclass" InitialValue="0" ErrorMessage="Class is required" CssClass="text-danger"></asp:RequiredFieldValidator>

                                                                </div>
                                                                <asp:Label ID="lblsection" runat="server" CssClass="col-sm-1 control-label" Text="Section"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:DropDownList ID="ddlsection" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Section" DataValueField="SectionId">
                                                                        <asp:ListItem Value="0">--Select Section--</asp:ListItem>

                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvSection" runat="server" ValidationGroup="A" ControlToValidate="ddlsection" InitialValue="0" ErrorMessage="Section is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblrollno" runat="server" CssClass="col-sm-4 control-label" Text="Roll No."></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtrollno" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" ValidChars="0123456789" TargetControlID="txtrollno">
                                                                    </cc1:FilteredTextBoxExtender>
                                                                    <asp:RequiredFieldValidator ID="rfvrolblno" runat="server" ValidationGroup="A" ControlToValidate="txtrollno" ErrorMessage="Roll No. is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblcity" runat="server" CssClass="col-sm-4 control-label" Text="City"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlcity" runat="server" AppendDataBoundItems="true" CssClass="form-control " DataTextField="Cities" DataValueField="Cityid">
                                                                        <asp:ListItem Value="0">--Select City--</asp:ListItem>


                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvcity" runat="server" ValidationGroup="A" ControlToValidate="ddlcity" InitialValue="0" ErrorMessage="City is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lbladdress" runat="server" CssClass="col-sm-4 control-label" Text="Address"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfv" runat="server" ValidationGroup="A" ControlToValidate="txtaddress" ErrorMessage="Address is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblFNAME" runat="server" CssClass="col-sm-4 control-label" Text="Father's Name"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:TextBox ID="txtfname" runat="server" CssClass="form-control"></asp:TextBox>

                                                                    <asp:RequiredFieldValidator ID="rfvfname" runat="server" ValidationGroup="A" ControlToValidate="txtFNAME" ErrorMessage="Father Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>

                                                                <asp:Label ID="lblMNAME" runat="server" CssClass="col-sm-1 control-label" Text="Mother's Name"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:TextBox ID="txtmname" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvmname" runat="server" ValidationGroup="A" ControlToValidate="txtmname" ErrorMessage="Mother Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="LblGender" runat="server" CssClass="col-sm-4 control-label" Text="Gender"></asp:Label>
                                                                <div class="col-sm-2" style="">
                                                                    <asp:RadioButtonList ID="RDOGender" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="radio-group">
                                                                        <asp:ListItem style="margin-right: 10px;" Text="Male" Value="1"></asp:ListItem>
                                                                        <asp:ListItem style="margin-right: 10px;" Text="Female" Value="2"></asp:ListItem>
                                                                        <asp:ListItem style="margin-right: 10px;" Text="Others" Value="3"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                    <asp:RequiredFieldValidator ID="rfvGender" runat="server" ValidationGroup="A" ControlToValidate="RDOGender" ErrorMessage="Gender is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                                <asp:Label ID="lblfile" runat="server" CssClass="col-sm-1 control-label" Text="Student Image"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                                                                    <asp:Label ID="lblphoto" runat="server" CssClass="control-label" Text=""></asp:Label>
                                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="FileUpload1" Display="Dynamic" ErrorMessage="Only jpg/png are allowed" ValidationExpression="^.+(.jpg|.JPG|.JPEG|.jpeg|.png|.PNG)$" Font-Bold="True"
                                                                        Font-Italic="True" ForeColor="#CC3300" ValidationGroup="f1" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                                    <asp:RequiredFieldValidator ID="rfvfile" runat="server" ValidationGroup="A" ControlToValidate="FileUpload1" ErrorMessage="Student Image is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-2">
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="col-sm-4 col-sm-offset-4">
                                                                    <asp:Button ID="btncancel" runat="server" CssClass="btn btn-white" Text="Cancel" OnClick="cancel" />
                                                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" OnClick="btnSubmit_Click" ValidationGroup="A" Text="Save changes" />
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

                                                                            <asp:TemplateField HeaderText="Photo">
                                                                                <ItemTemplate>
                                                                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# ResolveUrl("~/Uploads/" + Eval("StudentImg")) %>' Height="80px" Width="80px" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" CommandArgument='<%#Eval("StudentId") %>' CssClass="btn btn-primary btn-xs" />
                                                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-xs" OnClick="btndeleted_click" CommandArgument='<%#Eval("StudentId") %>' />
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
 <script src="assets/js/plugins/dataTables/datatables.min.js"></script>
</body>


</html>

