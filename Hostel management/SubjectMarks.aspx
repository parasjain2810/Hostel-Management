<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SubjectMarks.aspx.cs" Inherits="SubjectMarks" EnableEventValidation="false" %>

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
                        <h2>Student Marks</h2>
                        <ol class="breadcrumb">
                            <li>
                                <a href="Dashboard.aspx">Home</a>
                            </li>
                            <li>
                                <a>Entry</a>
                            </li>
                            <li class="active">
                                <strong>Student Marks</strong>
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
                                                                <asp:Label ID="lblSemester" runat="server" CssClass="col-sm-4 control-label" Text="Semester:"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:TextBox ID="txtSemester" runat="server" CssClass="form-control"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvSemester" runat="server" ValidationGroup="A" ControlToValidate="txtSemester" ErrorMessage="Semester is required" CssClass="text-danger"></asp:RequiredFieldValidator>
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
                                                                    <asp:DropDownList ID="ddlsection" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="Section" DataValueField="Sectionid" OnSelectedIndexChanged="StudentnameSelect" AutoPostBack="true">

                                                                        <asp:ListItem Value="0">--Select Section--</asp:ListItem>

                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvSection" runat="server" ValidationGroup="A" ControlToValidate="ddlsection" InitialValue="0" ErrorMessage="Section is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblStudentName" runat="server" CssClass="col-sm-4 control-label" Text="Student Name"></asp:Label>
                                                                <div class="col-sm-5">
                                                                    <asp:DropDownList ID="ddlStudentName" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataTextField="StudentName" DataValueField="StudentId" >
                                                                        <asp:ListItem Value="0">--Select Student--</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvStudentName" runat="server"  InitialValue="0" ControlToValidate="ddlStudentName" ValidationGroup="A" ErrorMessage="Student Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblScience" runat="server" CssClass="col-sm-4 control-label" Text="Science:"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:TextBox ID="txtScience" runat="server" CssClass="form-control" placeholder="Enter Marks"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvScience" runat="server" ValidationGroup="A" ControlToValidate="txtScience" ErrorMessage="Science marks are required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1"  runat="server" ValidChars="0123456789" TargetControlID="txtScience"></cc1:FilteredTextBoxExtender>
                                                                    <asp:RangeValidator ID="rvScience" runat="server" ValidationGroup="A" ControlToValidate="txtScience" MinimumValue="0" MaximumValue="100" Type="Integer" ErrorMessage="Please enter a valid mark between 0 and 100" CssClass="text-danger"></asp:RangeValidator>
                                                                </div>

                                                                <asp:Label ID="lblMath" runat="server" CssClass="col-sm-1 control-label" Text="Math:"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:TextBox ID="txtMath" runat="server" CssClass="form-control" placeholder="Enter Marks"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvMath" runat="server" ValidationGroup="A" ControlToValidate="txtMath" ErrorMessage="Math marks are required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2"  runat="server" ValidChars="0123456789" TargetControlID="txtMath"></cc1:FilteredTextBoxExtender>
                                                                    <asp:RangeValidator ID="rvMath" runat="server" ValidationGroup="A" ControlToValidate="txtMath" MinimumValue="0" MaximumValue="100" Type="Integer" ErrorMessage="Please enter a valid mark between 0 and 100" CssClass="text-danger"></asp:RangeValidator>
                                                                </div>
                                                            </div>


                                                            <div class="form-group">
                                                                <asp:Label ID="lblEnglish" runat="server" CssClass="col-sm-4 control-label" Text="English:"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:TextBox ID="txtEnglish" runat="server" CssClass="form-control" placeholder="Enter Marks"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvEnglish" runat="server" ValidationGroup="A" ControlToValidate="txtEnglish" ErrorMessage="English marks are required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3"   runat="server" ValidChars="0123456789" TargetControlID="txtEnglish"></cc1:FilteredTextBoxExtender>
                                                                    <asp:RangeValidator ID="rvEnglish" runat="server" ValidationGroup="A" ControlToValidate="txtEnglish" MinimumValue="0" MaximumValue="100" Type="Integer" ErrorMessage="Please enter a valid mark between 0 and 100" CssClass="text-danger"></asp:RangeValidator>
                                                                </div>
                                                                <asp:Label ID="lblHindi" runat="server" CssClass="col-sm-1 control-label" Text="Hindi:"></asp:Label>
                                                                <div class="col-sm-2">
                                                                    <asp:TextBox ID="txtHindi" runat="server" CssClass="form-control" placeholder="Enter Marks"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvHindi" runat="server" ValidationGroup="A" ControlToValidate="txtHindi" ErrorMessage="Hindi marks are required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4"  runat="server" ValidChars="0123456789" TargetControlID="txtHindi"></cc1:FilteredTextBoxExtender>
                                                                    <asp:RangeValidator ID="rvHindi" runat="server" ValidationGroup="A" ControlToValidate="txtHindi" MinimumValue="0" MaximumValue="100" Type="Integer" ErrorMessage="Please enter a valid mark between 0 and 100" CssClass="text-danger"></asp:RangeValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <asp:Label ID="lblTotalMarks" runat="server" CssClass="col-sm-4 control-label" Text="Total Marks:"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtTotalMarks" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5"  runat="server" ValidChars="0123456789" TargetControlID="txtTotalMarks"></cc1:FilteredTextBoxExtender>
                                                                    <asp:RequiredFieldValidator ID="rfvTotalMarks" ValidationGroup="A" runat="server" ControlToValidate="txtTotalMarks" ErrorMessage="Total marks are required" CssClass="text-danger"></asp:RequiredFieldValidator>

                                                                </div>

                                                                <asp:Label ID="lblPercentage" runat="server" CssClass="col-sm-1 control-label" Text="Percentage % :"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtPercentage" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvPercentage" runat="server" ValidationGroup="A" ControlToValidate="txtPercentage" ErrorMessage="Percentage is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender6"  runat="server" ValidChars="0123456789" TargetControlID="txtPercentage"></cc1:FilteredTextBoxExtender>
                                                                    <%--   <asp:RangeValidator ID="rvPercentage" runat="server" ControlToValidate="txtPercentage" MinimumValue="0" MaximumValue="100" Type="Double" ErrorMessage="Please enter a valid percentage between 0 and 100" CssClass="text-danger"></asp:RangeValidator>--%>
                                                                </div>

                                                                <asp:Label ID="lblGrade" runat="server" CssClass="col-sm-1 control-label" Text="Grade :"></asp:Label>
                                                                <div class="col-sm-1">
                                                                    <asp:TextBox ID="txtGrade" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvGrade" runat="server" ValidationGroup="A" ControlToValidate="txtGrade" ErrorMessage="Grade is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="form-group">
                                                                <div class="col-sm text-center">
                                                                    <asp:Button ID="ButtonCancel" runat="server" CssClass="btn btn-white" Text="Cancel"  OnClick="cancel"/>
                                                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="A" />
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
                                                                            <asp:BoundField DataField="Semester" HeaderText="Semester" />
                                                                            <asp:BoundField DataField="Class" HeaderText="Class" />
                                                                            <asp:BoundField DataField="Section" HeaderText="Section" />
                                                                            <asp:BoundField DataField="Science" HeaderText="Science" />
                                                                            <asp:BoundField DataField="Math" HeaderText="Math" />
                                                                            <asp:BoundField DataField="English" HeaderText="English" />
                                                                            <asp:BoundField DataField="Hindi" HeaderText="Hindi" />
                                                                            <asp:BoundField DataField="TotalMarks" HeaderText="Total Marks" />
                                                                            <asp:BoundField DataField="Percentage" HeaderText="Percentage" />
                                                                            <asp:BoundField DataField="Grade" HeaderText="Grade" />
                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-primary btn-xs" OnClick="btnEdit_Click" CommandArgument='<%#Eval("AcademicId") %>' />
                                                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-xs" OnClick="btndeleted_click" CommandArgument='<%#Eval("AcademicId") %>' />
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
    function calculateTotalMarks() {
        var science = parseInt(document.getElementById('<%= txtScience.ClientID %>').value) || 0;
        var math = parseInt(document.getElementById('<%= txtMath.ClientID %>').value) || 0;
        var english = parseInt(document.getElementById('<%= txtEnglish.ClientID %>').value) || 0;
        var hindi = parseInt(document.getElementById('<%= txtHindi.ClientID %>').value) || 0;

       
        var totalMarks = science + math + english + hindi;
        document.getElementById('<%= txtTotalMarks.ClientID %>').value = totalMarks;

       
        var percentage = (totalMarks / 400) * 100;
        var formattedPercentage = percentage.toFixed(0) + '%';
        document.getElementById('<%= txtPercentage.ClientID %>').value = formattedPercentage;

        var grade = '';
        if (percentage >= 90) {
            grade = 'A';
        } else if (percentage >= 80) {
            grade = 'B';
        } else if (percentage >= 60) {
            grade = 'C';
        } else if (percentage >= 40) {
            grade = 'D';
        } else {
            grade = 'F';
        }
        document.getElementById('<%= txtGrade.ClientID %>').value = grade;
    }

    window.onload = function() {
        var subjectFields = ['<%= txtScience.ClientID %>', '<%= txtMath.ClientID %>', '<%= txtEnglish.ClientID %>', '<%= txtHindi.ClientID %>'];
        for (var i = 0; i < subjectFields.length; i++) {
            document.getElementById(subjectFields[i]).addEventListener('input', calculateTotalMarks);
        }
    }
    </script>

</body>



</html>



