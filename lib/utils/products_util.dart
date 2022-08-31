import 'package:ecommerce_app/data/mock_data.dart';
import 'package:ecommerce_app/data/enums/category.dart';

class ProductsUtil {
  static Category getProductCategory({required String id}) {
    Category foundCategory = Category.hoodies;
    for (var entry in MockData.productsMockData.entries) {
      if (entry.value.any((element) => element.id == id)) {
        return foundCategory = entry.key;
      }
    }
    return foundCategory;
  }
}

// class ProductsUtil2 {
//   static Category getProductIndex({required String id, required int index}) {
//     Category foundIndex = Category.hoodies;
//     for (var entry in MockData.productsMockData.entries) {
//       if (entry.value.any((element) {
//         return element.id == id;
//       })) {
//         return foundIndex = entry.key;
//       }
//     }
//     return foundIndex;
//   }
// }
