class OnboardingModel{

  final String lottieURL;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieURL, this.title, this.subtitle);  
}

List<OnboardingModel> onboardintItems = [
  OnboardingModel(
    'assets/jsonfiles/first.json',
     'Nutritious Recipe',
     'Say goodbye to recipe frustration! Nutritious Recipe brings you a world of delicious Filipino dishes, all filtered for your dietary needs and food allergens.'),

  OnboardingModel(
    'assets/jsonfiles/photo.json',
    'Take a Picture',
    'Take a picture of your ingredients'),

  OnboardingModel(
    'assets/jsonfiles/pick.json',
    'Choose Your Dietary Restrictions',
    'Choose your allergies and different diets that are suitable for you'),
  
  OnboardingModel(
    'assets/jsonfiles/recommendation.json',
    'Get Recommendations',
    'Get recommendations based on your dietary restrictions'),

  OnboardingModel(
    'assets/jsonfiles/start.json',
    'Lets Get Started',
    ''),
];