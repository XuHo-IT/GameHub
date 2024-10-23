const formPopup = document.querySelector(".form-popup");
const showPopupBtn = document.querySelector(".login-btn");
const hidePopupBtn = formPopup.querySelector(".close-btn");
const signupLoginLink = formPopup.querySelectorAll(".bottom-link a");
const showLoginFromComment = document.getElementById("show-login-from-comment");

// Show login popup
showPopupBtn.addEventListener("click", () => {
    document.body.classList.toggle("show-popup");
});

// Show login popup when click letter "Be the first to comment!"
showLoginFromComment.addEventListener("click", (e) => {
    e.preventDefault();
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

