
import 'package:sale_management/share/model/stock_details_model.dart';

final List<StockDetails> stockDetailsData = [
  StockDetails(
      "Stock A",
      [
        ProductStockDetails('P-White',100,50,22.00,1100.00, 100.00),
        ProductStockDetails('TAMARIND Scrub',100,50,10.00,500.00, 50.00),
        ProductStockDetails('ទឹកដោះគោស្តួត',100,50,15.00,750.00, 50.00),
        ProductStockDetails('ទឹកដោះគោស្តួត',100,50,15.00,750.00, 50.00)
      ]
  ),
  StockDetails(
      "Stock B",
      [
        ProductStockDetails('P-White',100,50,22.00,1100.00, 100),
        ProductStockDetails('TAMARIND Scrub',100,50,10.00,500.00, 50),
        ProductStockDetails('ទឹកដោះគោស្តួត',100,50,15.00,750.00, 50)
      ]
  ),
];
