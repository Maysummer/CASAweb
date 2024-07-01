<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewProducts.aspx.cs" Inherits="CASAweb.ViewProducts" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>List Products</title>
    <link rel="stylesheet" type="text/css" href="Content/Site.css" />
    <style>
        body {
            padding: 1em;
        }

        form {
            width: 100%;
        }

        .gridview {
            border-collapse: separate;
            border-spacing: 0 15px;
            width: 100%;
        }

            .gridview th, .gridview td {
                border: 1px solid #D64105;
                padding: 8px;
            }

            .gridview th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #f5e7de;
                color: black;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView" runat="server" CssClass="gridview"></asp:GridView>
        </div>
    </form>
</body>
</html>
