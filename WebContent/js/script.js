// script.js

// Welcome Message
function showWelcome() {
    alert("Welcome to Car Rental Portal!");
}

// Logout Confirmation
function confirmLogout() {
    return confirm("Are you sure you want to logout?");
}

// Delete Confirmation
function confirmDelete() {
    return confirm("Are you sure you want to delete this record?");
}

// Booking Confirmation
function confirmBooking() {
    return confirm("Do you want to confirm this booking?");
}

// Payment Confirmation
function confirmPayment() {
    return confirm("Proceed with payment?");
}

// Display Current Date
function showCurrentDate() {
    const today = new Date();
    document.getElementById("currentDate").innerHTML =
        today.toDateString();
}

// Search Cars
function searchCars() {

    let input = document.getElementById("searchCar").value.toLowerCase();

    let table = document.getElementById("carTable");

    let rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {

        let name = rows[i].cells[1].innerText.toLowerCase();

        if (name.indexOf(input) > -1) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
}

// Reset Form
function resetForm(formId) {
    document.getElementById(formId).reset();
}

// Mobile form reliability: prevent accidental double submits while keeping normal browser navigation.
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("form").forEach(function (form) {
        form.addEventListener("submit", function () {
            var submit = form.querySelector('button[type="submit"], input[type="submit"]');
            if (submit && !form.dataset.submitting) {
                form.dataset.submitting = "true";
                window.setTimeout(function () {
                    if (submit) submit.disabled = false;
                    delete form.dataset.submitting;
                }, 2500);
            }
        });
    });
});

/* Modern mobile navigation */
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".navbar, .nav, .main-nav").forEach(function (nav) {
        if (nav.querySelector(".mobile-menu-toggle")) return;
        var button = document.createElement("button");
        button.type = "button";
        button.className = "mobile-menu-toggle";
        button.setAttribute("aria-label", "Open navigation");
        button.setAttribute("aria-expanded", "false");
        button.innerHTML = "☰";
        nav.insertBefore(button, nav.firstChild);
        button.addEventListener("click", function () {
            var open = nav.classList.toggle("mobile-open");
            button.setAttribute("aria-expanded", open ? "true" : "false");
            button.setAttribute("aria-label", open ? "Close navigation" : "Open navigation");
            button.innerHTML = open ? "×" : "☰";
        });
    });
});
