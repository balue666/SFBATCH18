public with sharing class EcomWrapper {

    public List<ProductWrapper> products;
    public Integer total;
    public Integer skip;

    public class ProductWrapper {
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

    public class ProductUpdateWrapper {
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
