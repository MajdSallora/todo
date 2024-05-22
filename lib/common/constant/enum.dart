enum Gender {
  male,
  female;

  static Gender getGender(String gender) {
    switch (gender) {
      case "male":
        return Gender.male;
      default:
        return Gender.female;
    }
  }
}
