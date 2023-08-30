import 'package:cloud_firestore/cloud_firestore.dart';

import '../../base_response.dart';

class ServiceRepository {
  /// get all trips
  Future<BaseResponse<List<ServiceModel>>> getServices() async {
    try {
      final firebaseServices = await FirebaseFirestore.instance.collection('services').get();
      final services = List<ServiceModel>.from((firebaseServices.docs).map(
        (e) => ServiceModel.fromJson(e.data()),
      ));

      return BaseResponse.success(services);
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message);
    } catch (err) {
      return BaseResponse.error(message: err.toString());
    }
  }

  Future<BaseResponse<List<ServiceModel>>> searchService({required String queryParam}) async {
    try {
      final firebaseServices = await FirebaseFirestore.instance.collection('services').where(
        'categories',
        arrayContainsAny: [queryParam],
      ).get();
      final services = List<ServiceModel>.from(
        (firebaseServices.docs).map(
          (e) => ServiceModel.fromJson(e.data()),
        ),
      );
      return BaseResponse.success(services);
    } on FirebaseException catch (err) {
      return BaseResponse.error(message: err.message);
    } catch (err) {
      return BaseResponse.error(message: err.toString());
    }
  }
}

class ServiceModel {
  const ServiceModel({
    required this.serviceName,
    required this.serviceId,
    required this.serviceImage,
    required this.description,
    required this.phoneNumber,
    required this.rating,
    required this.location,
    required this.categories,
  });
  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        serviceName: json['service_name'],
        serviceId: json['service_id'],
        serviceImage: json['service_image'],
        description: json['description'],
        phoneNumber: json['phone_number'],
        rating: double.parse(json['ratings'].toString()),
        location: json['location'],
        categories: List<String>.from(json['categories']),
      );

  final String serviceName;
  final String serviceId;
  final String serviceImage;
  final String description;
  final String phoneNumber;
  final double rating;
  final String location;
  final List<String> categories;
}
