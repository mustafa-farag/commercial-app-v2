import 'package:commercialapp/controllers/database_controller.dart';
import 'package:commercialapp/models/add_to_cart.dart';
import 'package:commercialapp/models/product_model.dart';
import 'package:commercialapp/utilities/constants.dart';
import 'package:commercialapp/views/widgets/default_button.dart';
import 'package:commercialapp/views/widgets/drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/main_dialog.dart';

class ProductDetails extends StatefulWidget {
  final Products product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String dropdownValue;

  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        size: dropdownValue,
      );
      database.addToCart(addToCartProduct);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t adding to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    bool isFavorites = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.share),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.55,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        child: DropDownMenuComponent(
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: const ['S', 'M', 'L', 'XL', 'XXL'],
                          hint: 'Size',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorites = !isFavorites;
                          });
                        },
                        child: CircleAvatar(
                          radius: size.width * 0.075,
                          backgroundColor: Colors.white,
                          child: isFavorites == false
                              ? const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          )
                              : const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.product.category,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'this is a dummy description for this product and i will add '
                        'it in the future i wrote this few words to be more than two lines ',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                    onPressed:(){
                      _addToCart(database);
                    },
                    text: 'Add to cart',
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
