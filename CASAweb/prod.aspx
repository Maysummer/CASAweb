<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="prod.aspx.cs" Inherits="CASAweb.prod" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Content/Site.css" />
</head>
<body>
    <div class="form">
        <h1>Product Creation</h1>
        <form asp-action="CreateProduct" asp-controller="Product" method="post">
            <div>
                <label for="pname">Product name:</label>
                <input type="text" id="pname" name="Name" required /><br /><br />
            </div>
            <div>
                <label for="category">Category</label>
                <select name="Category" id="category" onchange="handleCategoryChange()">
                    <option value="RegularSavings">Regular savings</option>
                    <option value="CommitmentSavings">Commitment savings</option>
                    <option value="Current">Current</option>
                    <option value="Others">Others</option>
                </select><br /><br />
                <div id="otherCategoryDiv" style="display: none;">
                    <label for="otherCategoryName">Others:</label>
                    <input type="text" id="otherCategoryName" name="OtherCategory" />
                </div><br /><br />
            </div>

            <div>
                <label for="applyFees">Do you want to apply fees?</label>
                <div class="button r" id="button-1">
                    <input type="checkbox" class="checkbox" id="applyFees" name="ShouldApplyFees" onchange="handleFeeChange()" />
                    <div class="knobs"></div>
                    <div class="layer"></div>
                </div>
                <div id="feesDiv" style="display: none;">
                    <label for="fees">Fee amount:</label>
                    <input type="number" id="fees" name="Fees" /><br /><br />
                </div>
            </div>

            <div id="applyInterestDiv" style="display: block">
                <label for="applyInterest">Do you want to apply interest?</label>
                <div class="button r" id="button-1">
                    <input type="checkbox" class="checkbox" id="applyInterest" name="ShouldPayInterest" onchange="handleInterestChange()" />
                    <div class="knobs"></div>
                    <div class="layer"></div>
                </div>
                <div id="interestDiv" style="display: none;">
                    <label for="interest">Interest amount:</label>
                    <input type="number" id="interest" name="Interest" /><br /><br />
                </div>

            </div>

            <div>
                <label for="applySMS">Do you want to apply SMS notifications?</label>
                <div class="button r" id="button-1">
                    <input type="checkbox" class="checkbox" id="applySMS" name="ShouldApplySMS" />
                    <div class="knobs"></div>
                    <div class="layer"></div>
                </div>
            </div>

            <div>
                <label for="accessChannels">Do you want to apply channel services?</label>
                <div class="button r" id="button-1">
                    <input type="checkbox" class="checkbox" id="accessChannels" name="ShouldAccessChannelServices" />
                    <div class="knobs"></div>
                    <div class="layer"></div>
                </div>
            </div>


            <button type="submit">Create</button>
        </form>

        <script src="~/js/site.js"></script>
    </div>

</body>
</html>
