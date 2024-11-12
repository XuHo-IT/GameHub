/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author OS
 */
public class GamePostEdit {
     private String postID;
    private String title;
    private String gamePlay;
    private String description;
    private String dateRelease;
    private String author;
    private String genre;
    private String adminId;
    private String linkGame;
    private String price;

    public GamePostEdit(String postID, String title, String gamePlay, String description, String dateRelease, String author, String genre, String adminId, String linkGame, String price) {
        this.postID = postID;
        this.title = title;
        this.gamePlay = gamePlay;
        this.description = description;
        this.dateRelease = dateRelease;
        this.author = author;
        this.genre = genre;
        this.adminId = adminId;
        this.linkGame = linkGame;
        this.price = price;
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

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getLinkGame() {
        return linkGame;
    }

    public void setLinkGame(String linkGame) {
        this.linkGame = linkGame;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
    
}
