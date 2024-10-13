// add hovered class in selected list item
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

fetch('/Web_Trading_Game/StatisticController')
  .then(response => response.json())
  .then(data => {
    console.log(data);
    const adminPostsCount = data.adminPostsCount;
    const memberPostsCount = data.memberPostsCount;
    console.log(adminPostsCount, memberPostsCount);
    // Update the polarArea chart with the fetched data
    var ctx = document.getElementById("myChart").getContext("2d");
    var myChart = new Chart(ctx, {
      type: "polarArea",
      data: {
        labels: ["AdminPost", "MemberPost"],
        datasets: [
          {
            label: "Post Counts",
            data: [adminPostsCount, memberPostsCount],
            backgroundColor: [
              "rgba(255 , 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
            ],
          },
        ],
      },
      options: {
        responsive: true,
      },
    });
  })
  .catch(error => console.error('Error fetching data:', error));


// Function to fetch post data from the server
async function fetchAndUpdateChart() {
    try {
        const response = await fetch('/getGamePostStatistics');  // Ensure this URL matches your backend endpoint
        const data = await response.json();

        // Extract labels (days) and data (admin and member post counts)
        const labels = data.map(item => item.day);
        const adminCounts = data.map(item => item.adminCount);
        const memberCounts = data.map(item => item.memberCount);

        // If myChart already exists, destroy it
        if (myChart) {
            myChart.destroy();
        }

        // Create a new chart instance
        const ctx = document.getElementById('myChart').getContext('2d');
        myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels.reverse(),  // Reverse to show oldest day first
                datasets: [
                    {
                        label: 'Admin Posts',
                        data: adminCounts.reverse(),  // Admin post data
                        backgroundColor: 'rgba(54, 162, 235, 1)',
                    },
                    {
                        label: 'Member Posts',
                        data: memberCounts.reverse(),  // Member post data
                        backgroundColor: 'rgba(255, 99, 132, 1)',
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    } catch (error) {
        console.error('Error fetching post data:', error);
    }
}

// Call the function periodically to update the chart (e.g., every 5 seconds)
setInterval(fetchAndUpdateChart, 5000);