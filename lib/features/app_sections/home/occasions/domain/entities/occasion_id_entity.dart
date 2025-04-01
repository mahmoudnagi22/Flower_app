class OccasionsIdEntity {
  OccasionsIdEntity({
      this.message,
      this.occasion,});


  String? message;
  OccasionByIdEntity? occasion;



}

class OccasionByIdEntity {
  OccasionByIdEntity({
      this.id,
      this.name,
      this.slug,
      this.image,
      this.createdAt,
      this.updatedAt,});


  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;



}