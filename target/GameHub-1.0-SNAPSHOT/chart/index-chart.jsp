<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Responsive Admin Dashboard | Redesign</title>
    <link rel="stylesheet" href="css/style.css" />
  </head>
  <body>
    <div class="container">
      <div class="navigation">
        <ul>
          <li>
            <a href="">
              <span class="icon"><ion-icon name="logo-apple"></ion-icon></span>
              <span class="title">Manage Amin</span>
            </a>
          </li>
          <li>
          </li>
          <li>
            <a href="censor.jsp">
              <span class="icon">
                <ion-icon name="people-outline"></ion-icon>
              </span>
              <span class="title">Censor Post</span>
            </a>
          </li>
          <li>
            <a href="index-chart.jsp">
              <span class="icon">
                <ion-icon name="chatbubbles-outline"></ion-icon>
              </span>
              <span class="title">Statistic</span>
            </a>
          </li>
          <li>
            <a href="">
              <span class="icon">
                <ion-icon name="help-outline"></ion-icon>
              </span>
              <span class="title">Manage All User</span>
            </a>
          </li>
          
        </ul>
      </div>
      <!-- main -->
      <div class="main">
        <div class="topbar">
          <div class="toggle">
            <ion-icon name="menu-outline"></ion-icon>
          </div>
          <!-- Search -->
          <div class="search">
            <label>
              <input type="text" placeholder="Search here" />
              <ion-icon name="search-outline"></ion-icon>
            </label>
          </div>
          <!-- UserImg -->
          <div class="user">
            <img src="imgs/user.jpg" alt="" />
          </div>
        </div>
        <!-- Card -->
        <div class="cardBox">
          <div class="card">
            <div>
              <div class="numbers">1,504</div>
              <div class="cardName">Daily Views</div>
            </div>
            <div class="iconBx">
              <ion-icon name="eye-outline"></ion-icon>
            </div>
          </div>
          <div class="card">
            <div>
              <div class="numbers">80</div>
              <div class="cardName">Sales</div>
            </div>
            <div class="iconBx">
              <ion-icon name="cart-outline"></ion-icon>
            </div>
          </div>
          <div class="card">
            <div>
              <div class="numbers">284</div>
              <div class="cardName">Comments</div>
            </div>
            <div class="iconBx">
              <ion-icon name="chatbubbles-outline"></ion-icon>
            </div>
          </div>
          <div class="card">
            <div>
              <div class="numbers">$7,842</div>
              <div class="cardName">Earning</div>
            </div>
            <div class="iconBx">
              <ion-icon name="cash-outline"></ion-icon>
            </div>
          </div>
        </div>
        <!-- Add Charts -->
        <div class="graphBox">
          <div class="box">
            <canvas id="myChart"></canvas>
          </div>
          <div class="box">
            <canvas id="earning"></canvas>
          </div>
        </div>
        <div class="details">
          <!-- order details list -->
          <div class="recentOrders">
            <div class="cardHeader">
              <h2>Recent Orders</h2>
              <a href="#" class="btn">View All</a>
            </div>
            <table>
              <thead>
                <tr>
                  <td>Name</td>
                  <td>Price</td>
                  <td>Payment</td>
                  <td>Status</td>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Star Refrigerator</td>
                  <td>$1200</td>
                  <td>Paid</td>
                  <td><span class="status delivered">Delivered</span></td>
                </tr>
                <tr>
                  <td>Window Coolers</td>
                  <td>$110</td>
                  <td>Due</td>
                  <td><span class="status pending">Pending</span></td>
                </tr>
                <tr>
                  <td>Speakers</td>
                  <td>$620</td>
                  <td>Paid</td>
                  <td><span class="status return">Return</span></td>
                </tr>
                <tr>
                  <td>Hp Laptop</td>
                  <td>$110</td>
                  <td>Due</td>
                  <td><span class="status inprogress">In Progress</span></td>
                </tr>
                <tr>
                  <td>Apple Watch</td>
                  <td>$1200</td>
                  <td>paid</td>
                  <td><span class="status delivered">Delivered</span></td>
                </tr>
                <tr>
                  <td>Wall Fan</td>
                  <td>$110</td>
                  <td>Paid</td>
                  <td><span class="status pending">Pending</span></td>
                </tr>
                <tr>
                  <td>Adidas Shoes</td>
                  <td>$620</td>
                  <td>Paid</td>
                  <td><span class="status return">Return</span></td>
                </tr>
                <tr>
                  <td>Denim Shirts</td>
                  <td>$110</td>
                  <td>Due</td>
                  <td><span class="status inprogress">In Progress</span></td>
                </tr>
                <tr>
                  <td>Casual Shoes</td>
                  <td>$575</td>
                  <td>Paid</td>
                  <td><span class="status pending">Pending</span></td>
                </tr>
                <tr>
                  <td>Wall Fan</td>
                  <td>$110</td>
                  <td>Paid</td>
                  <td><span class="status pending">Pending</span></td>
                </tr>
                <tr>
                  <td>Denim Shirts</td>
                  <td>$110</td>
                  <td>Due</td>
                  <td><span class="status inprogress">In Progress</span></td>
                </tr>
              </tbody>
            </table>
          </div>
          <!-- New Customers -->
          <div class="recentCustomers">
            <div class="cardHeader">
              <h2>Recent Customers</h2>
            </div>
            <table>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img1.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>David<br /><span>Italy</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img2.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Muhammad<br /><span>India</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img3.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Amelia<br /><span>France</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img4.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Olivia<br /><span>USA</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img5.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Amit<br /><span>Japan</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img6.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Ashraf<br /><span>India</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img7.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Diana<br /><span>Malaysia</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img8.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Amit<br /><span>India</span></h4>
                </td>
              </tr>
              <tr>
                <td width="60px">
                  <div class="imgBx"><img src="imgs/img9.jpg" alt="" /></div>
                </td>
                <td>
                  <h4>Amelia<br /><span>China</span></h4>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
    <script
      type="module"
      src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"
    ></script>
    <script
      nomodule
      src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"
    ></script>
    <!-- <script src="https://cdn.jsdelivr.net/npm/chart.js@3.5.1/dist/chart.min.js"></script> -->
    <!-- <script src="js/chart.umd.js"></script> -->
    <script src="js/chart.min.js"></script>
    <script src="js/main.js"></script>
    <style>
        .details {
  position: relative;
  width: 100%;
  padding: 20px;
  display: grid;
  grid-template-columns: 2fr 1fr;
  grid-gap: 30px;
  /* margin-top: 10px; */
}
    </style>
  </body>
</html>