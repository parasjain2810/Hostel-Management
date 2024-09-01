<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<%@ Register Src="~/footerscript.ascx" TagPrefix="uc1" TagName="footerscript" %>
<%@ Register Src="~/headerlinks.ascx" TagPrefix="uc1" TagName="headerlinks" %>
<%@ Register Src="~/nav.ascx" TagPrefix="uc1" TagName="nav" %>
<%@ Register Src="~/csslinks.ascx" TagPrefix="uc1" TagName="csslinks" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management | Tabs </title>
    <uc1:csslinks runat="server" ID="csslinks" />
    <style>
        .headerqw {
            font-size: 30px;
        }
    </style>
</head>

<body>

    <div id="wrapper">
        <uc1:nav runat="server" ID="nav" />
        <div id="page-wrapper" class="gray-bg">
            <uc1:headerlinks runat="server" ID="headerlinks" />
            <div class="wrapper wrapper-content">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">

                                <h5>No. Of Students</h5>
                            </div>
                            <div class="ibox-content">
                                <asp:Label ID="lblTotalStudents" CssClass="headerqw no-margins" runat="server" Text=""></asp:Label><br />
                                <small>No. Of Students</small>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">

                                <h5>Student Registered For Hostel</h5>
                            </div>
                            <div class="ibox-content">
                                <asp:Label ID="Label1" CssClass="headerqw no-margins" runat="server" Text=""></asp:Label><br />
                                <small>Student Hostel</small>
                            </div>
                        </div>
                    </div>
                    <%--<div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-primary pull-right">Today</span>
                                <h5>Vistits</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">106,120</h1>
                                <div class="stat-percent font-bold text-navy">44% <i class="fa fa-level-up"></i></div>
                                <small>New visits</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <span class="label label-danger pull-right">Low value</span>
                                <h5>User activity</h5>
                            </div>
                            <div class="ibox-content">
                                <h1 class="no-margins">80,600</h1>
                                <div class="stat-percent font-bold text-danger">38% <i class="fa fa-level-down"></i></div>
                                <small>In first month</small>
                            </div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>
    <uc1:footerscript runat="server" ID="footerscript" />
</body>


</html>



