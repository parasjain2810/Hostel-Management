<%@ Control Language="C#" AutoEventWireup="true" CodeFile="nav.ascx.cs" Inherits="nav" %>
<div id="wrapper">
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                

                <li class="active">
                    <a href="Dashboard.aspx"><i class="fa fa-edits"></i><span class="nav-label">Dashboards</span></a>

                </li>
                <li>
                    <a href="#"><i class="fa fa-th-large"></i><span class="nav-label">Master</span> <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="studentforms.aspx">Student Registration</a></li>
                        <li><a href="classes.aspx">Class</a></li>
                        <li><a href="section.aspx">Section</a></li>
                        <li><a href="cityies.aspx">City</a></li>
                        <li><a href="Hosteldata.aspx">Hostel</a></li>
                        <li><a href="Warden.aspx">Warden</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fa fa-edit"></i><span class="nav-label">Entry</span> <span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="HostelRegistration.aspx">Hostel Registration</a></li>
                        <li><a href="Room.aspx">Room</a></li>
                        <li><a href="StudentHostelFees.aspx">Student Hostel  Fees</a></li>
                        <li><a href="OverallPerformance.aspx">Overall Performance</a></li>
                        <li><a href="SubjectMarks.aspx">Subject Marks</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="	fa fa-bar-chart"></i><span class="nav-label">Reports</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li>
                            <a href="#"> Hostel Reports <span class="fa arrow"></span></a>
                            <ul class="nav nav-third-level">
                                <li>
                                    <a href="HostelReport.aspx">Hostel Alocated Reports</a>
                                </li>                                
                            </ul>
                        </li>
                        <li><a href="StudentReportsaspx.aspx">Student Reports</a></li>                        
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</div>

