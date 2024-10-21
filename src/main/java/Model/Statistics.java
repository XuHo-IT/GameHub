/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Admin
 */
public class Statistics {
    private long gamePostCount;
    private long topicCount;
    private long memberCount;
    private long adminCount;
    private long userCount;

    public Statistics(long gamePostCount, long topicCount, long memberCount, long adminCount, long userCount) {
        this.gamePostCount = gamePostCount;
        this.topicCount = topicCount;
        this.memberCount = memberCount;
        this.adminCount = adminCount;
        this.userCount = userCount;
    }

    // Getters for all the fields
    public long getPostCount() { return gamePostCount; }
    public long getTopicCount() { return topicCount; }
    public long getMemberCount() { return memberCount; }
    public long getAdminCount() { return adminCount; }
    public long getUserCount() { return userCount; }
}
