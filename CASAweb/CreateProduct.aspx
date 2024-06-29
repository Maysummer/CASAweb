<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateProduct.aspx.cs" Inherits="CASAweb.CreateProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Content/Site.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        function handleCategoryChange() {
            console.log("cat");
            var category = $('#<%= Category.ClientID %>').val();
            console.log(category, "this is cat");
            var otherCategoryDiv = $("#otherCategoryDiv");
            var applyInterestDiv = $("#applyInterestDiv");
            var otherCategoryInput = $('#<%= OtherCategory.ClientID %>');
            var otherCategoryValidator = $('#<%= OtherCategoryValidator.ClientID %>');
            if (category === 'Others') {
                console.log("other")
                otherCategoryDiv.show();
                otherCategoryInput.attr('required', 'required');
            } else {
                otherCategoryDiv.hide();
                otherCategoryInput.val(""); // Clear the input
                otherCategoryInput.removeAttr('required');
            }
            console.log({ category }, applyInterestDiv.css("display"));
            if (category === "CURRENT") {
                console.log("in current");
                //applyInterestDiv.hide();
                applyInterestDiv.find('input, select, textarea').prop('disabled', true);
            } else {
                //applyInterestDiv.show();
                applyInterestDiv.find('input, select, textarea').prop('disabled', false);
            }
        }


        function handleFeeChange() {
            console.log("fee change")
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
            console.log("interest")
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
            }
        })
    </script>

    <style type="text/css">
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
            background-color: #2196F3;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
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
    </style>
</head>
<body>
    <div class="form">
        <form id="form1" runat="server">
            <asp:HiddenField ID="HiddenMessage" runat="server" />
            <div>
                <asp:Label AssociatedControlID="Name" Text="Product name: " runat="server" />
                <asp:TextBox type="text" ID="Name" runat="server" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Name" ErrorMessage="Please enter a product name" ForeColor="Red"></asp:RequiredFieldValidator>
            </div>
            <br />
            <br />

            <div>
                <asp:Label AssociatedControlID="Category" Text="Category: " runat="server" />
                <asp:DropDownList ID="Category" runat="server" onchange="handleCategoryChange()">
                    <asp:ListItem Text="Regular savings" Value="REGULAR SAVINGS"></asp:ListItem>
                    <asp:ListItem Text="Commitment savings" Value="COMMITMENT SAVINGS"></asp:ListItem>
                    <asp:ListItem Text="Current" Value="CURRENT"></asp:ListItem>
                    <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                </asp:DropDownList><br />
                <br />
                <div id="otherCategoryDiv" style="display: none;">
                    <asp:Label AssociatedControlID="OtherCategory" Text="Other category name: " runat="server" />
                    <asp:TextBox ID="OtherCategory" runat="server"></asp:TextBox>
<%--                    <asp:RequiredFieldValidator ID="OtherCategoryValidator" runat="server" ControlToValidate="OtherCategory" ErrorMessage="Please enter a category name" ForeColor="Red" OnServerValidate="ValidateOtherCategory" ></asp:RequiredFieldValidator>--%>
                </div>
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
                    <asp:Label AssociatedControlID="Fees" Text="Fees: " runat="server" />
                    <asp:TextBox ID="Fees" runat="server" /><br />
                    <br />
                    <asp:RegularExpressionValidator ControlToValidate="Fees" runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+" ForeColor="Red">
                    </asp:RegularExpressionValidator>
                </div>
            </div>

            <div id="applyInterestDiv" style="display: block">
                <asp:Label AssociatedControlID="ShouldPayInterest" Text="Do you want to pay interest: " runat="server" />
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

            <div>
                <asp:Label AssociatedControlID="ShouldApplySMS" Text="Do you want to apply SMS notifications? " runat="server" />
                <label class="switch">
                    <asp:CheckBox ID="ShouldApplySMS" runat="server" />
                    <span class="slider round"></span>
                </label>
            </div>

            <div>
                <asp:Label AssociatedControlID="ShouldAccessChannelServices" Text="Do you want to access channels services? " runat="server" />
                <label class="switch">
                    <asp:CheckBox ID="ShouldAccessChannelServices" runat="server" />
                    <span class="slider round"></span>
                </label>
            </div>

            <asp:Button ID="Create" runat="server" Text="Create" OnClick="Create_Click" />

            <br />
            <br />
            <asp:GridView ID="GridView" runat="server"></asp:GridView>

        </form>
    </div>
</body>
</html>
