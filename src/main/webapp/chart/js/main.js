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

// my_chart

var ctx = document.getElementById("myChart").getContext("2d");
var earning = document.getElementById("earning").getContext("2d");


fetch('/Web_Trading_Game/getPostCounts')
  .then((response) => response.json())
  .then((data) => {
      
    const adminPosts = data.adminPostList;
    const memberPosts = data.memberPostList;
    
var myChart = new Chart(ctx, {
  type: "polarArea",
  data: {
    labels: ["Admin Post", "Member Post"],
    datasets: [
      {
        label: "Traffic Source",
        data: [adminPosts, memberPosts],
        backgroundColor: [
          "rgba(255 , 99, 132, 1)",
          "rgba(54, 162, 235, 1)",
        ]
        }]
      },
  options: {
    responsive: true,
        }
    });
  }) 
        .catch((error) => console.error('Error fetching post counts:', error));

var myChart = new Chart(earning, {
  type: "bar",
  data: {
    labels: [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ],
    datasets: [
      {
        label: "Earning",
        data: [
          1200, 1090, 3000, 5400, 1220, 3600, 4800
        ],
        backgroundColor: [
          "rgba(255, 99, 132, 1)",
          "rgba(54, 162, 235, 1)",
          "rgba(255, 206, 86, 1)",
          "rgba(75, 192, 192, 1)",
          "rgba(153, 102, 255, 1)",
          "rgba(255, 159, 64, 1)",
          "rgba(255, 99, 132, 1)"
          
        ],
      },
    ],
  },
  options: {
    responsive: true,
  },
});
