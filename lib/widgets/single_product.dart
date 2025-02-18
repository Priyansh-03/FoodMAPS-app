import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodmaps_flutter/pages/provider/Favorite_provider.dart';
import 'package:provider/provider.dart';

import '../pages/home/home_page.dart';

class SingleProduct extends StatefulWidget {
  final productId;
  final productCategory;
  final productRate;
  final productOldPrice;
  final productPrice;
  final productImage;
  final productName;
  final Function()? onTap;
  const SingleProduct({
    Key? key,
    required this.onTap,
    required this.productId,
    required this.productCategory,
    required this.productRate,
    required this.productOldPrice,
    required this.productPrice,
    required this.productImage,
    required this.productName,
  }) : super(key: key);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserFavorite")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      isFavorite = value.get("productFavorite");
                    }),
                  }
              }
          },
        );

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            alignment: Alignment.topRight,
            height: size!.height * 0.3,
            width: size!.width / 2 - 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.productImage),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                setState(
                  () {
                    isFavorite = !isFavorite;

                    if (isFavorite == true) {
                      favoriteProvider.favorite(
                        productId: widget.productId,
                        productCategory: widget.productCategory,
                        productRate: widget.productRate,
                        productOldPrice: widget.productOldPrice,
                        productPrice: widget.productPrice,
                        productImage: widget.productImage,
                        productFavorite: true,
                        productName: widget.productName,
                      );
                    } else if (isFavorite == false) {
                      favoriteProvider.deleteFavorite(
                          productId: widget.productId);
                    }
                  },
                );
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.productName,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${widget.productPrice} ₹",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}











// class SingleProduct extends StatefulWidget {
//   final productId;
//   final productCategory;
//   final productRate;
//   final productOldPrice;
//   final productPrice;
//   final productImage;
//   final productName;
//   final Function()? onTap;

//   const SingleProduct({
//     Key? key,
//     required this.onTap,
//     this.productId,
//     this.productCategory,
//     this.productOldPrice,
//     this.productPrice,
//     this.productImage,
//     this.productRate,
//     this.productName,
//   }) : super(key: key);

//   @override
//   State<SingleProduct> createState() => _SingleProductState();
// }

// class _SingleProductState extends State<SingleProduct> {
//   bool isFavorite = false;

//   @override
//   Widget build(BuildContext context) {
//     FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Column(
//         children: [
//           Container(
//             alignment: Alignment.topRight,
//             margin: EdgeInsets.all(12.0),
//             height: 200,
//             width: 150,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(widget.productImage),
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: IconButton(
//               highlightColor: Colors.transparent,
//               splashColor: Colors.transparent,
//               onPressed: () {
//                 setState(
//                   () {
//                     isFavorite = !isFavorite;

//                     if (isFavorite == true) {
//                       favoriteProvider.favorite(
//                         productId: widget.productId,
//                         productCategory: widget.productCategory,
//                         productRate: widget.productRate,
//                         productOldPrice: widget.productOldPrice,
//                         productPrice: widget.productPrice,
//                         productImage: widget.productImage,
//                         productName: widget.productName,
//                         productFavorite: true,
//                       );
//                     } else if (isFavorite == false) {}
//                   },
//                 );
//               },
//               icon: Icon(
//                 isFavorite ? Icons.favorite : Icons.favorite_border,
//                 color: Colors.red,
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 widget.productName,
//                 style: TextStyle(
//                   fontWeight: FontWeight.normal,
//                   fontSize: 20,
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 "${widget.productPrice} ₹",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
