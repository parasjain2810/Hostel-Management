<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Management | Login</title>

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="assets/css/animate.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>
                <div> <img src="123.jpg" style=" width: 200px;height: auto;border-radius: 50%;"/></div>
            </div>
            <h3>Welcome to Student Management</h3>

            
            <form class="m-t" role="form" runat="server">
                <div class="form-group">
                    <asp:TextBox ID="txtUsername" runat="server"  CssClass="form-control" Placeholder="Username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtUsername"  ErrorMessage="Email is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvpassword" runat="server" ControlToValidate="txtPassword"  ErrorMessage="Password is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                </div>
                 <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary block full-width m-b" Text="Login" OnClick="btnLogin_Click" />

                 <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>
               
                
            </form>
           
        </div>
    </div>

    
    <script src="assets/js/jquery-2.1.1.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

</body>


</html>
