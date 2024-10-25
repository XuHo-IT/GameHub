/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author OS
 */
public class GamePost {
    private String postID;
    private String title;
    private String gamePlay;
    private String description;
    private String dateRelease;
    private String author;
    private String genre;
    private String userId;
    private String fileName;
    private String fileData;

    public GamePost(String postID, String title, String gamePlay, String description, String dateRelease, String author, String genre, String adminId, String fileName, String fileData) {
        this.postID = postID;
        this.title = title;
        this.gamePlay = gamePlay;
        this.description = description;
        this.dateRelease = dateRelease;
        this.author = author;
        this.genre = genre;
        this.userId = adminId;
        this.fileName = fileName;
        this.fileData = fileData;
    }

    public GamePost() {
    }

    public String getPostID() {
        return postID;
    }

    public void setPostID(String postID) {
        this.postID = postID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGamePlay() {
        return gamePlay;
    }

    public void setGamePlay(String gamePlay) {
        this.gamePlay = gamePlay;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDateRelease() {
        return dateRelease;
    }

    public void setDateRelease(String dateRelease) {
        this.dateRelease = dateRelease;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileData() {
        return fileData;
    }

    public void setFileData(String fileData) {
        this.fileData = fileData;
    }

    @Override
    public String toString() {
        return "GamePost{" + "postID=" + postID + ", title=" + title + ", gamePlay=" + gamePlay + ", description=" + description + ", dateRelease=" + dateRelease + ", author=" + author + ", genre=" + genre + ", adminId=" + userId + ", fileName=" + fileName + ", fileData=" + fileData + '}';
    }
    
}
