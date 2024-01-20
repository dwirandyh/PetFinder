# Introduction
PetFinder is a user-friendly mobile application designed to help pet lovers find lovely pet

## Task Approach

I start from breaking the task into several key steps, here the list of my approach to solve this challange
1. **Requirement Analysis:**
- Read carefully about task from attachment file and ask about what i doubt
- Break down the requirement into smaller and managable task
2. **Swift:**
- I use Swift 5.9.2 for this project and use async await for the concurrency task
- I use SwiftUI to designing the interface that works well in iOS 13
3. **CoreD ata:**
- I use Core Data to handle data persistece in this case i use it to create animal category and also to save favorite animal picture
- I create 3 table which are AnimalCategory, FavoritePhoto and Photo Source
- AnimalCategory has relationship with many FavoritePhoto, then FavoritePhoto as relationship to 1 Photo Source
3. **Architecture:**
- I implemented Clean Architecture to separate concern and improve code organization
- Make sure a clear separation of data representation, business logic and user interface
4. **Unit Testing:** 
- I write unit test to validate correctness of business logic

## Assumtion
1. I assume user has a reliable connection and the backend has great up time 
2. I did not implement complex eror handling for network issue
3. I use Swift Package Manager for dependency manager
4. I limit the use of external library and only use SDWebImage for loading image from network
5. I assume the user has higher iOS version to make sure the UI works better than iOS 13

## Project Requirement
- iOS 13.0
- Xcode 15.1.0

## Running Project
#### Clone the Repository:
```bash
git clone git@github.com:dwirandyh/PetFinder.git
cd PetFinder
```
### Open the Proejct
Open Project in Xcode:
```bash
open PetFinder.xcodeproj
```

### Build and Run:
- Select the target device or simulator from the top left drop-down menu.
- Click the "Run" button (or press Cmd + R) to build and run the application.

### Test
- Select the target device or simulator from the top left drop-down menu. 
- Click the "Product" menu then select "Test" menu (or press Cmd + U)