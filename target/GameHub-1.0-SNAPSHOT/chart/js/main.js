// Add hovered class to selected list item
let list = document.querySelectorAll(".navigation li");
function activeLink() {
    list.forEach((item) => item.classList.remove("hovered"));
    this.classList.add("hovered");
}
list.forEach((item) => item.addEventListener("mouseover", activeLink));

// MenuToggle
let toggle = document.querySelector(".toggle");
let navigation = document.querySelector(".navigation");
let main = document.querySelector(".main");
toggle.onclick = function () {
    navigation.classList.toggle("active");
    main.classList.toggle("active");
};

// Chart.js setup
var ctx = document.getElementById("myChart").getContext("2d");
var earning = document.getElementById("earning").getContext("2d");

// Fetch post counts and update polar area chart
fetch('/Web_Trading_Game/getPostCounts')
    .then((response) => response.json())
    .then((data) => {
        const adminPosts = data.adminPostList;
        const memberPosts = data.memberPostList;
        const totalPosts = data.totalPostCount; // Get the total posts from the response
        // Update the chart with member and admin posts
        var myChart = new Chart(ctx, {
            type: "polarArea",
            data: {
                labels: ["Member Post", "Admin Post"],
                datasets: [{
                    label: "Traffic Source",
                    data: [memberPosts, adminPosts],
                    backgroundColor: [
                        "rgba(255, 99, 132, 1)",
                        "rgba(54, 162, 235, 1)"
                    ]
                }]
            },
            options: {
                responsive: true,
            }
        });
        // Display the total posts in the card (Daily Views or Total Posts)
        document.querySelector('.numbers1').textContent = totalPosts;
    })
    .catch((error) => console.error('Error fetching post counts:', error));

// Helper function to parse date strings
function parseDate(dateString) {
    const [datePart, timePart] = dateString.split(' ');
    const [day, month, year] = datePart.split('-');
    const [hours, minutes, seconds] = timePart.split(':');
    return new Date(year, month - 1, day, hours, minutes, seconds);
}

// Helper function to format numbers with commas
function formatNumberWithCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// Function to get the earnings data from the table
function getEarningsData() {
    let earningsPerDate = {};
    // Get all rows from the table
    const rows = document.querySelectorAll("tbody tr");
    if (rows.length === 0) {
        console.log("No rows found.");
        return {}; // Return empty object if no rows are found
    }
    // Process each row to calculate earnings per date
    rows.forEach(row => {
        // Check if the amount cell and date cell exist
        const amountCell = row.querySelector('td:nth-child(2) .status');
        const dateCell = row.querySelector('td:nth-child(4)');
        if (amountCell && dateCell) {
            const amount = parseFloat(amountCell.textContent.replace(/,/g, ''));
            const formattedDate = dateCell.textContent;
            // Parse the date and group earnings by date (dd-mm-yyyy format)
            const parsedDate = parseDate(formattedDate).toLocaleDateString('en-GB');
            // Sum up the amounts for each date
            if (earningsPerDate[parsedDate]) {
                earningsPerDate[parsedDate] += amount;
            } else {
                earningsPerDate[parsedDate] = amount;
            }
        } else {
            console.log('Missing amount or date cell in row:', row); // Log if cells are missing
        }
    });
    return earningsPerDate;
}

// Function to update the earnings chart
function updateChart() {
    const earnings = getEarningsData();
    // Extract dates (keys) and corresponding sums (values)
    const dates = Object.keys(earnings);
    const amounts = Object.values(earnings);
    // If the chart exists, update its data
    if (earningChart) {
        earningChart.data.labels = dates;  // Update labels with dates
        earningChart.data.datasets[0].data = amounts; // Update data with amounts
        earningChart.update();  // Re-render the chart with new data
    } else {
        // Create a new chart if it doesn't exist
        earningChart = new Chart(earning, {
            type: "bar",
            data: {
                labels: dates, // Dates from the table
                datasets: [{
                    label: "Earnings",
                    data: amounts, // Corresponding earnings amounts
                    backgroundColor: [
                        "rgba(255, 99, 132, 1)",
                        "rgba(54, 162, 235, 1)",
                        "rgba(255, 206, 86, 1)",
                        "rgba(75, 192, 192, 1)",
                        "rgba(153, 102, 255, 1)",
                        "rgba(255, 159, 64, 1)"
                    ]
                }]
            },
            options: {
                responsive: true,
            }
        });
    }
}

// Function to fetch and display total earnings
function fetchTotalData() {
    const totalEarningsValue = document.getElementById("totalEarningsValue").value;
    // Convert string to number and format with commas
    const formattedTotal = formatNumberWithCommas(parseFloat(totalEarningsValue));
    // Update the display with formatted total
    document.getElementById("totalEarningsDisplay").innerHTML = `VND${formattedTotal}`;
}

// Global chart variable for the earnings chart
let earningChart = null;

// Call updateChart and fetch total data when the DOM is fully loaded
document.addEventListener("DOMContentLoaded", () => {
    setTimeout(() => {
        updateChart();
        fetchTotalData(); // Fetch total data and update display
    }, 500); // Delay the update to ensure data is loaded
});
