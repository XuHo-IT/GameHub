// Select elements for the Add Post popup
const formAddPopup = document.querySelector(".form-add-popup");
const showAddPostBtn = document.querySelector(".create-btn");
const hideAddPostBtn = formAddPopup.querySelector(".close-btn");

// Show Add Post popup
showAddPostBtn.addEventListener("click", () => {
    formAddPopup.classList.toggle("show-popup");
});

// Hide Add Post popup
hideAddPostBtn.addEventListener("click", () => {
    formAddPopup.classList.remove("show-popup");
});
