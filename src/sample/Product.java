package sample;

public class Product {
    private String prodcode;
    private String category;
    private String SKU;
    private String Title;
    private Float BIN;
    private Float RRP;
    private String Description;
    private String Image1;
    private String Image2;
    private String Image3;
    private String Image4;
    private String Image5;
    private String Image6;
    private String Image7;
    private String Image8;
    private String Image9;
    private String Image10;
    private String Image11;
    private String Image12;
    private Integer QTY;
    private String deliveryName1;
    private Float deliveryPrice1;
    private Float deliveryAddPrice1;
    private String deliveryName2;
    private Float deliveryPrice2;
    private Float deliveryAddPrice2;
    private String deliveryName3;
    private Float deliveryPrice3;
    private String tag;
    private Integer EAN;

    public Integer getEAN() {
        return EAN;
    }

    public void setEAN(Integer EAN) {
        this.EAN = EAN;
    }

    public Product(String prodcode, String SKU, String title, Float BIN, Float RRP, String description) {
        this.prodcode = prodcode;
        this.SKU = SKU;
        Title = title;
        this.BIN = BIN;
        this.RRP = RRP;
        Description = description;
    }

    public Product(String prodcode, String category, String SKU, String title, Float BIN, Float RRP, String description,
                   String image1, String image2, String image3, String image4, String image5, String image6,
                   String image7, String image8, String image9, String image10, String image11, String image12, Integer QTY,
                   String deliveryName1, Float deliveryPrice1, Float deliveryAddPrice1, String deliveryName2, Float deliveryPrice2,
                   Float deliveryAddPrice2, String deliveryName3, Float deliveryPrice3, String tag, Integer EAN) {
        this.prodcode = prodcode;
        this.category = category;
        this.SKU = SKU;
        Title = title;
        this.BIN = BIN;
        this.RRP = RRP;
        Description = description;
        Image1 = image1;
        Image2 = image2;
        Image3 = image3;
        Image4 = image4;
        Image5 = image5;
        Image6 = image6;
        Image7 = image7;
        Image8 = image8;
        Image9 = image9;
        Image10 = image10;
        Image11 = image11;
        Image12 = image12;
        this.QTY = QTY;
        this.deliveryName1 = deliveryName1;
        this.deliveryPrice1 = deliveryPrice1;
        this.deliveryAddPrice1 = deliveryAddPrice1;
        this.deliveryName2 = deliveryName2;
        this.deliveryPrice2 = deliveryPrice2;
        this.deliveryAddPrice2 = deliveryAddPrice2;
        this.deliveryName3 = deliveryName3;
        this.deliveryPrice3 = deliveryPrice3;
        this.tag = tag;
        this.EAN = EAN;
    }

    public Product() {
    }

    public String getProdcode() {
        return prodcode;
    }

    public void setProdcode(String prodcode) {
        this.prodcode = prodcode;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSKU() {
        return SKU;
    }

    public void setSKU(String SKU) {
        this.SKU = SKU;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public Float getBIN() {
        return BIN;
    }

    public void setBIN(Float BIN) {
        this.BIN = BIN;
    }

    public Float getRRP() {
        return RRP;
    }

    public void setRRP(Float RRP) {
        this.RRP = RRP;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public String getImage1() {
        return Image1;
    }

    public void setImage1(String image1) {
        Image1 = image1;
    }

    public String getImage2() {
        return Image2;
    }

    public void setImage2(String image2) {
        Image2 = image2;
    }

    public String getImage3() {
        return Image3;
    }

    public void setImage3(String image3) {
        Image3 = image3;
    }

    public String getImage4() {
        return Image4;
    }

    public void setImage4(String image4) {
        Image4 = image4;
    }

    public String getImage5() {
        return Image5;
    }

    public void setImage5(String image5) {
        Image5 = image5;
    }

    public String getImage6() {
        return Image6;
    }

    public void setImage6(String image6) {
        Image6 = image6;
    }

    public String getImage7() {
        return Image7;
    }

    public void setImage7(String image7) {
        Image7 = image7;
    }

    public String getImage8() {
        return Image8;
    }

    public void setImage8(String image8) {
        Image8 = image8;
    }

    public String getImage9() {
        return Image9;
    }

    public void setImage9(String image9) {
        Image9 = image9;
    }

    public String getImage10() {
        return Image10;
    }

    public void setImage10(String image10) {
        Image10 = image10;
    }

    public String getImage11() {
        return Image11;
    }

    public void setImage11(String image11) {
        Image11 = image11;
    }

    public String getImage12() {
        return Image12;
    }

    public void setImage12(String image12) {
        Image12 = image12;
    }

    public Integer getQTY() {
        return QTY;
    }

    public void setQTY(Integer QTY) {
        this.QTY = QTY;
    }

    public String getDeliveryName1() {
        return deliveryName1;
    }

    public void setDeliveryName1(String deliveryName1) {
        this.deliveryName1 = deliveryName1;
    }

    public Float getDeliveryPrice1() {
        return deliveryPrice1;
    }

    public void setDeliveryPrice1(Float deliveryPrice1) {
        this.deliveryPrice1 = deliveryPrice1;
    }

    public Float getDeliveryAddPrice1() {
        return deliveryAddPrice1;
    }

    public void setDeliveryAddPrice1(Float deliveryAddPrice1) {
        this.deliveryAddPrice1 = deliveryAddPrice1;
    }

    public String getDeliveryName2() {
        return deliveryName2;
    }

    public void setDeliveryName2(String deliveryName2) {
        this.deliveryName2 = deliveryName2;
    }

    public Float getDeliveryPrice2() {
        return deliveryPrice2;
    }

    public void setDeliveryPrice2(Float deliveryPrice2) {
        this.deliveryPrice2 = deliveryPrice2;
    }

    public Float getDeliveryAddPrice2() {
        return deliveryAddPrice2;
    }

    public void setDeliveryAddPrice2(Float deliveryAddPrice2) {
        this.deliveryAddPrice2 = deliveryAddPrice2;
    }

    public String getDeliveryName3() {
        return deliveryName3;
    }

    public void setDeliveryName3(String deliveryName3) {
        this.deliveryName3 = deliveryName3;
    }

    public Float getDeliveryPrice3() {
        return deliveryPrice3;
    }

    public void setDeliveryPrice3(Float deliveryPrice3) {
        this.deliveryPrice3 = deliveryPrice3;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }
}
