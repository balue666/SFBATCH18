public with sharing class EcomProductWrapper {
    public List<EcomProduct> products;
    public Integer total;
    public Integer skip;

    public class EcomProduct {
        public Integer id;
        public String title;
        public String description;
        public Integer price;
        public Decimal discountPercentage;
        public Decimal rating;
        public Integer stock;
        public String brand;
        public String category;
        public String thumbnail;
    }
}