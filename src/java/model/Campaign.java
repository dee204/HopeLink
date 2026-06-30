/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author farajuhaimi
 */
public class Campaign {

    private int campaignId;
    private String title;
    private String description;
    private String orgName;
    private double amountGoal;
    private double amountRaised;
    private String status;
    private String image;
    private String createdAt;

    public Campaign() {
    }

    public Campaign(String title, String description, String orgName, double amountGoal) {
        this.title = title;
        this.description = description;
        this.orgName = orgName;
        this.amountGoal = amountGoal;
        this.amountRaised = 0;
        this.status = "PENDING";
    }

    public Campaign(String title, String description, String orgName, double amountGoal, double amountRaised) {
        this.title = title;
        this.description = description;
        this.orgName = orgName;
        this.amountGoal = amountGoal;
        this.amountRaised = amountRaised;
    }

    public int getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(int campaignId) {
        this.campaignId = campaignId;
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

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public double getAmountGoal() {
        return amountGoal;
    }

    public void setAmountGoal(double amountGoal) {
        this.amountGoal = amountGoal;
    }

    public double getAmountRaised() {
        return amountRaised;
    }

    public void setAmountRaised(double amountRaised) {
        this.amountRaised = amountRaised;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}