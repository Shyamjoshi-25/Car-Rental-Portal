// booking.js

// Calculate Total Amount
function calculateAmount() {

    let pickup = document.getElementsByName("pickupDate")[0].value;
    let returnDate = document.getElementsByName("returnDate")[0].value;
    let pricePerDay = document.getElementsByName("pricePerDay")[0].value;

    if (pickup === "" || returnDate === "" || pricePerDay === "") {
        return;
    }

    let start = new Date(pickup);
    let end = new Date(returnDate);

    let difference = end - start;

    let days = difference / (1000 * 60 * 60 * 24);

    if (days < 1) {
        alert("Return date must be after pickup date.");
        document.getElementsByName("totalAmount")[0].value = "";
        return;
    }

    let total = days * pricePerDay;

    document.getElementsByName("totalAmount")[0].value = total;
}

// Confirm Booking
function confirmBooking() {

    return confirm("Do you want to confirm this booking?");
}

// Clear Booking Form
function clearBookingForm() {

    document.getElementById("bookingForm").reset();
}