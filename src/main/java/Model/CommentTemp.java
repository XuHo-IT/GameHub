package Model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class CommentTemp {

    private String commentId;
    private String topicId;
    private String userId;
    private String userName;
    private String photoUrl;
    private String content;
    private String status;
    private Date date;

    public CommentTemp() {
    }

    public CommentTemp(String commentId, String topicId, String userId, String userName, String photoUrl, String content, String status, Date date) {
        this.commentId = commentId;
        this.topicId = topicId;
        this.userId = userId;
        this.userName = userName;
        this.photoUrl = photoUrl;
        this.content = content;
        this.status = status;
        this.date = date;
    }

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
