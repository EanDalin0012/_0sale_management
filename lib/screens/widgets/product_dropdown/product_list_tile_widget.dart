
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sale_management/share/model/product.dart';
import 'package:sale_management/screens/widgets/product_dropdown/FlagImageWidget.dart';

class ProductListTileWidget extends StatelessWidget {
  final ProductModel productModel;
  final bool isNative;
  final bool isSelected;
  final ValueChanged<ProductModel> onSelectedProduct;

  const ProductListTileWidget({
    Key key,
    @required this.productModel,
    @required this.isNative,
    @required this.isSelected,
    @required this.onSelectedProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    return ListTile(
        onTap: () => onSelectedProduct(productModel),
        leading: FlagImageWidget(
          width: 40,
          height: 40,
          url: productModel.url,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            border: Border.all(color: Colors.grey, width: 2),
          ),
        ),
        title: Text(productModel.name),
         trailing: isSelected ? _buildCheckIcon() : null,
    );
  }

  Widget _buildCheckIcon() {
    return Container(
      width: 40,
      height: 40,
      // margin: EdgeInsets.only(
      //     left: 10
      // ),
      child: Center(child: FaIcon(FontAwesomeIcons.checkCircle, size: 25 , color: Colors.deepPurple)),
    );
  }
}
