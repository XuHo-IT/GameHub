
package Model;


public class Topic {
    private String topicId;
    private String userId;
    private String title;
    private String description;
    private String imageData;
    private String photoUrl;
    private String userName;

    public Topic() {
    }

     public Topic(String topicId, String userId, String title, String description, String imageData, String photoUrl, String userName) {
        this.topicId = topicId;
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.imageData = imageData;
        this.photoUrl = photoUrl;
         this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public String getTopicId() {
        return topicId;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String Description) {
        this.description = Description;
    }

    public String getImageData() {
        return imageData;
    }

    public void setImageData(String imageData) {
        this.imageData = imageData;
    }
    
    
}
