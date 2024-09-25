const formPopup = document.querySelector(".form-popup");
const showPopupBtn = document.querySelector(".login-btn");
const hidePopupBtn = formPopup.querySelector(".close-btn");
const signupLoginLink = formPopup.querySelectorAll(".bottom-link a");

// Show login popup
showPopupBtn.addEventListener("click", () => {
    document.body.classList.toggle("show-popup");
});

// Hide login popup
hidePopupBtn.addEventListener("click", () => {
    document.body.classList.remove("show-popup");
});

// Show or hide signup form
signupLoginLink.forEach(link => {
    link.addEventListener("click", (e) => {
        e.preventDefault();
        formPopup.classList[link.id === 'signup-link' ? 'add' : 'remove']("show-signup");
    });
});


const loginBtn = document.querySelector('.login-btn');
const headerSection = document.querySelector('.header-section');

// Toggle fixed position on header when the login button is clicked
loginBtn.addEventListener('click', () => {
    headerSection.classList.toggle('fixed-header');
});
