String? nameValidator(String? value) {
  if(value == null || value.isEmpty) {
    return 'Please enter your full name.';
  }
  if(value.contains(RegExp(r'\d'))) {
    return 'Please enter a valid full name.';
  }
  return null;
}