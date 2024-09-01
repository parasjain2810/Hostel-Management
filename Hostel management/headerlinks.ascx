<%@ Control Language="C#" AutoEventWireup="true" CodeFile="headerlinks.ascx.cs" Inherits="headerlinks" %>

<div class="row border-bottom">
    <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i></a>
            <a href="#" style="display: flex; color: black; margin-top: 17px; font-size: 19px">Student Management</a>
        </div>
        <ul class="nav navbar-top-links navbar-right" style="display: flex; align-items: center; font-size:16px; font-weight:500">
            <li>
                <span class="m-r-sm text-muted welcome-message">
            Welcome ,<%= Session["Username"].ToString() %>
        </span>
            </li>

            <li>
                <a href="Logout.aspx" style="display: flex; align-items: center;">
                    <i class="fa fa-sign-out"></i>Log out
                </a>
            </li>
        </ul>

    </nav>
</div>

