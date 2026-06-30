/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author farajuhaimi
 */
public class Donation {
    private int donationId;
    private int campaignId;
    private String donorName;
    private double amount;
    private String campaignTitle;
    private String donationDate;

    public int getDonationId() { return donationId; }
    public void setDonationId(int donationId) { this.donationId = donationId; }

    public int getCampaignId() { return campaignId; }
    public void setCampaignId(int campaignId) { this.campaignId = campaignId; }

    public String getDonorName() { return donorName; }
    public void setDonorName(String donorName) { this.donorName = donorName; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
   

public String getCampaignTitle() { return campaignTitle; }
public void setCampaignTitle(String campaignTitle) { this.campaignTitle = campaignTitle; }

public String getDonationDate() { return donationDate; }
public void setDonationDate(String donationDate) { this.donationDate = donationDate; }
}
