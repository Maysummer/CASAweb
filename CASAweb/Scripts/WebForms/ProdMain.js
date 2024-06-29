//CdnPath=http://ajax.aspnetcdn.com/ajax/4.5.1/1/WebForms.js
function handleCategoryChange() {
    var category = document.getElementById("category").value;
    var otherCategoryDiv = document.getElementById("otherCategoryDiv");
    var applyInterestDiv = document.getElementById("applyInterestDiv");
    var otherCategoryInput = document.getElementById("otherCategoryName");
    if (category === "Others") {
        otherCategoryDiv.style.display = "block";
        otherCategoryInput.setAttribute("required", "required");
    } else {
        otherCategoryDiv.style.display = "none";
        otherCategoryInput.removeAttribute("required");
        otherCategoryInput.value = ""; // Clear the input
    }
    console.log({ category }, applyInterestDiv.style.display)
    if (category === "Current") {
        console.log("in current")
        applyInterestDiv.style.display = "none";
    } else {
        applyInterestDiv.style.display = "block"
    }
}

function handleFeeChange() {
    var applyFees = document.getElementById("applyFees");
    var feesDiv = document.getElementById("feesDiv");
    var feesInput = document.getElementById("fees");
    if (applyFees.checked) {
        feesDiv.style.display = "block";
        feesInput.setAttribute("required", "required");
    } else {
        feesDiv.style.display = "none";
        feesInput.removeAttribute("required");
        document.getElementById("fees").value = "";
    }
}

function handleInterestChange() {
    var applyInterest = document.getElementById("applyInterest");
    var interestDiv = document.getElementById("interestDiv");
    var interestInput = document.getElementById("interest")
    if (applyInterest.checked) {
        interestDiv.style.display = "block";
        interestInput.setAttribute("required", "required");
    } else {
        interestDiv.style.display = "none";
        interestInput.removeAttribute("required");
        document.getElementById("interest").value = "";
    }
}

document.addEventListener("DOMContentLoaded", function () {
    handleCategoryChange();
    handleFeeChange();
    handleInterestChange();
})