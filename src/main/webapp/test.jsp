<%@page import="Model.Topic"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="com.mongodb.client.MongoClients"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoClient"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="org.bson.Document" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forum Page</title>
    </head>
    <body>
        <!-- Button to create new topic -->
        <button class="cTopic-btn forum-button" onclick="showCreateTopicPopup()">Create New Topic</button>

        <!-- Create Topic Popup -->
        <div class="blur-bg-overlay" id="createTopicBlurOverlay" style="display: none;"></div>
        <div class="form-popup cTopic-btn" id="createTopicPopup">
            <span class="close-btn material-symbols-rounded" onclick="hideCreateTopicPopup()">close</span>
            <div class="form-box create-topic">
                <div class="form-details">
                    <h2>Create New Topic</h2>
                    <p>Please enter topic details below to share with the community.</p>
                </div>
                <div class="form-content">
                    <form action="TopicCreateController" method="post" enctype="multipart/form-data">
                        <div class="input-field">
                            <label>Topic Title</label>
                            <input type="text" name="topicTitle" required>
                        </div>
                        <div class="input-field">
                            <label>Topic Content</label>
                            <textarea name="topicContent" rows="4" required></textarea>
                        </div>
                        <div class="input-field">
                            <label>Upload Image (Optional)</label>
                            <input type="file" name="topicImage" accept="image/*">
                        </div>
                        <button type="submit">Create Topic</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Button to update a topic -->
        <button class="cTopic-btn forum-button" onclick="openUpdatePopup()">Update</button>

        <!-- Update Topic Popup -->
        <div class="blur-bg-overlay" style="display:none;" id="updateBlurOverlay"></div>
        <div class="form-popup update-topic-popup" id="updateTopicPopup" style="display:none;">
            <span class="close-btn material-symbols-rounded" onclick="closeUpdatePopup()">close</span>
            <div class="form-box update-topic">
                <div class="form-details">
                    <h2>Update Topic</h2>
                </div>
                <div class="form-content">
                    <form id="updateTopicForm">
                        <div class="input-field">
                            <label for="updateTopicTitle">Topic Title</label>
                            <input type="text" id="updateTopicTitle" name="topicTitle" required>
                        </div>
                        <div class="input-field">
                            <label for="updateTopicContent">Topic Content</label>
                            <textarea id="updateTopicContent" name="topicContent" rows="4" required></textarea>
                        </div>
                        <div class="input-field">
                            <label for="updateTopicImage">Upload Image</label>
                            <input type="file" id="updateTopicImage" name="topicImage">
                        </div>
                        <button type="button" onclick="submitUpdate()">Update Topic</button>
                        <button type="button" onclick="closeUpdatePopup()">Cancel</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function showCreateTopicPopup() {
                document.getElementById("createTopicPopup").classList.add("show");
                document.getElementById("createTopicBlurOverlay").style.display = "block";
            }

            function hideCreateTopicPopup() {
                document.getElementById("createTopicPopup").classList.remove("show");
                document.getElementById("createTopicBlurOverlay").style.display = "none";
            }

            function openUpdatePopup(topicId, currentTitle, currentContent) {
                document.getElementById("updateTopicPopup").classList.add("show");
                document.getElementById("updateBlurOverlay").style.display = "block";
                document.getElementById("updateTopicTitle").value = currentTitle;
                document.getElementById("updateTopicContent").value = currentContent;
                document.getElementById("updateTopicForm").dataset.topicId = topicId;
            }

            function closeUpdatePopup() {
                document.getElementById("updateTopicPopup").classList.remove("show");
                document.getElementById("updateBlurOverlay").style.display = "none";
            }

            function submitUpdate() {
                const topicId = document.getElementById("updateTopicForm").dataset.topicId;
                const topicTitle = document.getElementById("updateTopicTitle").value;
                const topicContent = document.getElementById("updateTopicContent").value;

                const formData = new FormData();
                formData.append("topicId", topicId);
                formData.append("topicTitle", topicTitle);
                formData.append("topicContent", topicContent);

                const topicImageFile = document.getElementById("updateTopicImage").files[0];
                if (topicImageFile) {
                    formData.append("topicImage", topicImageFile);
                }

                fetch('/TopicCreateController', {
                    method: 'PUT',
                    body: formData
                })
                        .then(response => {
                            if (response.ok) {
                                alert("Topic updated successfully!");
                                closeUpdatePopup();
                                location.reload();
                            } else {
                                alert("Failed to update topic. Please try again.");
                            }
                        })
                        .catch(error => console.error("Error updating topic:", error));
            }
        </script>

    </body>
</html>
