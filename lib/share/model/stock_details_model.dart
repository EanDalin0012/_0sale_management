class StockDetails {
  final String stockName;
  final List<ProductStockDetails> products;
  StockDetails(this.stockName, this.products);
}

class ProductStockDetails {
  final String productName;
  final int totalQuantity;
  final int soldQuantity;
  final num price;
  final num total;
  final num netIncome;
  ProductStockDetails(this.productName, this.totalQuantity, this.soldQuantity, this.price,this.total, this.netIncome);
}
