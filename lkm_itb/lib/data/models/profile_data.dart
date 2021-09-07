class ProfileData {
  String userID;
  String name;
  String email;
  String? gender;
  String? nim;
  String? faculty;
  String? major;
  String? organizationType;
  String? organization;
  String? photo;
  String? role;
  String? group;

  ProfileData(
      {
        required this.email,
        required this.userID,
      required this.name,
      this.photo,
      this.nim,
      this.faculty,
      this.gender,
      this.major,
      this.organizationType,
      this.organization,
      this.role,
      this.group});
}
