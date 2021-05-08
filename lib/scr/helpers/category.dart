import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class CategoryServices {
  String collection = "categories";
  Firestore _firestore = Firestore.instance;

  Future<List<CategoryModel>> getCategories() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        print(result.documents);
        List<CategoryModel> categories = [];
        for(DocumentSnapshot category in result.documents){
            categories.add(CategoryModel.fromSnapshot(category));
        }
        return categories;
      });
}