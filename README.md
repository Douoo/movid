# MOViD

Movid is a Flutter app project that allows users to search for a movie and tv series, see their detail, season & episode, and save watchlist. The API used for the movies and tv series data is obtained from https://www.themoviedb.org/

## Prerequisites
Before begin to install to your local machine and test it, make sure you have met the following requirements:

- You have installed the latest version of Flutter SDK. Install Flutter
- You have installed Android Studio and setup an emulator. Download Android Studio
- You have installed XCode 13 and setup a simulator (if you are using macOS)

## Run for the first time
After load the project to your local machine IDE, follow these steps:

Restore the package
```
flutter pub get
```
Run 
```
flutter run
```

To use your own TMDB API Key, you will need to create a dot env (.env) file and insert your API key like this: `API_KEY='XXXXX'`. Beyond this, you can adjust the URLs for this project under lib/utils/urls.dart.

## Core concepts used in this project
- Clean Architecture  🏗️
- Test Driven Development (TDD) - Unit, Widget, and Integration test 🧪
- Advanced UI
- Modularity  

## Contributing to this project
If you are currently learning Flutter development and want to start contributing to open source, let's get started! To contribute to this project, follow these steps:

- Fork this repository
- Create a new branch: git checkout -b <branch_name>
- Make your changes and commit them: git commit -m '<commit_message>'. Please follow this Commit Style Guide
- Push your changes to the original branch on your repository
- Create the PR (Pull Request)

To contributing to this project, you can explore TMDB API Docs and start add a new feature that intresting and useful for cinephile.

IMPORTANT: You must follow the clean architecture and TDD proccess to add a new feature.

## Contributors
- [@Douoo](https://github.com/Douoo)
- [@Brook Gelila](https://github.com/BGLeee)

Thanks 😊
