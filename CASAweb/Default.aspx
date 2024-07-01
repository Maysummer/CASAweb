<%@ Page Title="CreateProduct" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CASAweb.CreateProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Content/Site.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        function handleCategoryChange() {
            var category = $('#<%= Category.ClientID %>').val();
            var otherCategoryDiv = $("#otherCategoryDiv");
            var applyInterestDiv = $("#applyInterestDiv");
            var otherCategoryInput = $('#<%= OtherCategory.ClientID %>');
            if (category === 'Others') {
                console.log("other")
                otherCategoryDiv.show();
                otherCategoryInput.attr('required', 'required');
            } else {
                otherCategoryDiv.hide();
                otherCategoryInput.val(""); // Clear the input
                otherCategoryInput.removeAttr('required');
            }
            if (category === "CURRENT") {
                console.log("in current");
                applyInterestDiv.find('input').prop('disabled', true).prop('checked', false);
            } else {
                applyInterestDiv.find('input').prop('disabled', false);
            }
        }


        function handleFeeChange() {
            var applyFees = $('#<%= ShouldApplyFees.ClientID %>');
            var feesDiv = $("#feesDiv");
            var feesInput = $('#<%= Fees.ClientID %>');
            if (applyFees.is(':checked')) {
                feesDiv.show();
                feesInput.attr('required', 'required');
            } else {
                feesDiv.hide();
                feesInput.removeAttr('required');
                feesInput.val('');
            }

        }

        function handleInterestChange() {
            var applyInterest = $('#<%= ShouldPayInterest.ClientID %>');
            var interestDiv = $("#interestDiv");
            var interestInput = $('#<%= Interest.ClientID %>')
            if (applyInterest.is(':checked')) {
                interestDiv.show();
                interestInput.attr("required", "required");
            } else {
                interestDiv.hide();
                interestInput.removeAttr("required");
                interestInput.value = "";
            }
        }

        $(document).ready(function () {
            $('#<%= Category.ClientID %>').change(handleCategoryChange);
            $('#<%= ShouldPayInterest.ClientID %>').change(handleInterestChange);
            $('#<%= ShouldApplyFees.ClientID %>').change(handleFeeChange);

            var message = $('#<%= HiddenMessage.ClientID %>').val();
            if (message) {
                alert(message);
                $('#<%= HiddenMessage.ClientID %>').val(''); // Clear the hidden field
                handleCategoryChange();
            }
        })
    </script>

    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-size: 1.5em;
            display: flex;
            justify-content: center;
            background-color: #f5e7de;
            padding: 2em;
        }

        .form {
            border: 2px solid #D64105;
            padding: 2em;
            max-width: fit-content;
            border-radius: 1.5em;
        }

        h2 {
            text-align: center;
        }

        .inputBox {
            font-size: .7em;
            text-indent: 2px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

            .switch input {
                opacity: 0;
            }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

            .slider:before {
                position: absolute;
                content: "";
                height: 16px;
                width: 16px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

        input:checked + .slider {
            background-color: #D64105;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #D64105;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

            .slider.round:before {
                border-radius: 50%;
            }

        .button {
            background-color: #D64105;
            border-radius: 7px;
            padding: 9px;
            border: none;
            color: white;
            font-size: 18px;
        }

        .btnContainer {
            display: flex;
            gap: 2em;
            justify-content: center;
        }

            .btnContainer a {
                text-decoration: none;
            }
    </style>
</head>
<body>
    <div class="form">
        <form id="form1" runat="server">
            <asp:HiddenField ID="HiddenMessage" runat="server" />
            <h2>Create New Product</h2>
            <br />
            <div>
                <asp:Label AssociatedControlID="Name" Text="Product name: " runat="server" />
                <asp:TextBox CssClass="inputBox" type="text" ID="Name" runat="server" placeholder="Enter product name" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Name" ErrorMessage="Please enter a product name" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <br />

            <div>
                <asp:Label AssociatedControlID="Category" Text="Category: " runat="server" />
                <asp:DropDownList CssClass="inputBox" ID="Category" runat="server" onchange="handleCategoryChange()">
                    <asp:ListItem Text="Regular savings" Value="REGULAR SAVINGS"></asp:ListItem>
                    <asp:ListItem Text="Commitment savings" Value="COMMITMENT SAVINGS"></asp:ListItem>
                    <asp:ListItem Text="Current" Value="CURRENT"></asp:ListItem>
                    <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <div id="otherCategoryDiv" style="display: none;">
                    <asp:Label AssociatedControlID="OtherCategory" Text="Other category name: " runat="server" />
                    <asp:TextBox CssClass="inputBox" ID="OtherCategory" runat="server" placeholder="Specify other category"></asp:TextBox>
                </div>
                <br />
            </div>

            

            <div>
                <%--<asp:Label AssociatedControlID="GLs" Text="General Ledger: " runat="server" />--%>
                <p>Select applicable general ledgers:</p>
                    <asp:CheckBox runat="server" Text="Interest payable" ID="InterestPayable"></asp:CheckBox><br />
                    <asp:CheckBox runat="server" Text="Interest expense" ID="InterestExpense"></asp:CheckBox><br />
                    <asp:CheckBox runat="server" Text="General fee income" ID="GeneralFeeIncome"></asp:CheckBox><br />
                    <asp:CheckBox runat="server" Text="Maintenance fee" ID="MaintenanceFee"></asp:CheckBox><br />
                <br />
                <br />
            </div>




            <div>
                <asp:Label AssociatedControlID="ShouldApplyFees" Text="Do you want to apply fees? " runat="server" />
                <label class="switch">
                    <asp:CheckBox ID="ShouldApplyFees" runat="server" />
                    <span class="slider round"></span>
                </label>
                <div id="feesDiv" style="display: none;">
                    <asp:Label AssociatedControlID="Fees" Text="Fees amount: " runat="server" />
                    <asp:TextBox CssClass="inputBox" ID="Fees" runat="server" /><br />
                    <br />
                    <asp:RegularExpressionValidator ControlToValidate="Fees" runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+" ForeColor="Red">
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <br />

            <div id="applyInterestDiv" style="display: block">
                <asp:Label AssociatedControlID="ShouldPayInterest" Text="Do you want to pay interest? " runat="server" />
                <label class="switch">
                    <asp:CheckBox ID="ShouldPayInterest" runat="server" />
                    <span class="slider round"></span>
                </label>
                <div id="interestDiv" style="display: none;">
                    <asp:Label AssociatedControlID="Interest" Text="Interest: " runat="server" />
                    <asp:TextBox ID="Interest" runat="server" /><br />
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="Interest" runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+" ForeColor="Red">
                    </asp:RegularExpressionValidator>
                </div>
            </div>
            <br />

            <div>
                <asp:Label AssociatedControlID="ShouldApplySMS" Text="Do you want to apply SMS notifications? " runat="server" />
                <label class="switch">
                    <asp:CheckBox ID="ShouldApplySMS" runat="server" />
                    <span class="slider round"></span>
                </label>
            </div>
            <br />

            <div>
                <asp:Label AssociatedControlID="ShouldAccessChannelServices" Text="Do you want to access channels services? " runat="server" />
                <label class="switch">
                    <asp:CheckBox ID="ShouldAccessChannelServices" runat="server" />
                    <span class="slider round"></span>
                </label>
            </div>
            <br />
            <br />

            <div class="btnContainer">
                <asp:Button ID="Create" runat="server" Text="Create" OnClick="Create_Click" CssClass="button" />
                <a class="button" runat="server" href="~/ViewProducts.aspx" target="_blank">View products</a>
            </div>

        </form>
    </div>
</body>
</html>
