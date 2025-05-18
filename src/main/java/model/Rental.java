package model;

import java.time.LocalDate;

public class Rental {
    private String code;
    private String status;
    private double area;
    private int floor;
    private String type;
    private long price;
    private LocalDate startDate;
    private LocalDate endDate;

    // Getters and setters
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public double getArea() { return area; }
    public void setArea(double area) { this.area = area; }
    public int getFloor() { return floor; }
    public void setFloor(int floor) { this.floor = floor; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
}