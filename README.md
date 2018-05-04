# Mobile Developer Coding Challenge

## Updates:
500px - Mobile Challange
By: Illya Gordiyenko
Date: May 3rd, 2018

#### General
- Version: iOS 10.0 +
- Swift 4.0 (NOTE: This is one above the required Swift 3, but the doc seems a bit outdated)
- Using Cocoapods - most are helper UI functions + Alamofire

#### Dev Notes
I've tried a slightly different approach on this coding challange compared to a few other ones I've done. Mainly I've been trying to focus on the project setup, so it follows a more detail MVVM design patern for the PhotoCollection and the PhotoDetail; which are easily scaled to include Unit Tests(only a basic one done). This approach worked well but I've seemingly ran out of time for final polish of the UI and the transitions. 

#### Bugs and Future Improvements:
There is a number of TODO for future improvements:
- Animations:
  - TBD: Pop back is done wrong, always goes through a black screen before poping. 
  - TBD: Animations are lacking the precision, always spans from the middle of the screen rather than the the individual cell. Will have to be adjusted for this
- UI: 
  - PhotoCollection -> this should have a more detailed custom FlowLayout that would take in account the different photo sizes and position then accordingly; as to avoid the massive white space between each cell. 


This is a coding challenge for prospective mobile developer applicants applying through https://about.500px.com/jobs/ 

## Goal:

#### Develop a simple app that allows viewing and interacting with a grid of currently popular 500px photos

- [ ] Fork this repo. Keep it public until we have been able to review it.
- [ ] Android: _Java_ | iOS: _Swift 3_
- [ ] 500px API docs are here: https://github.com/500px/api-documentation. Please don't use **deprecated** [iOS](https://github.com/500px/500px-iOS-api) and [Android](https://github.com/500px/500px-android-sdk) SDKs.
- [ ] Grid of photos should preserve the aspect ratio of the photos it's displaying. Optionally: exclude nude images.
- [ ] Grid should work in both portrait and landscape orientations of the device.
- [ ] Grid should support pagination, i.e. you can scroll on grid of photos infinitely.
- [ ] When user taps on a photo on the grid she should show the photo in full screen with more information about the photo.
- [ ] When user swipes on a photo in full screen, preserve it's location on the grid, so when she dismisses the full screen, grid of photos should contain the last photo she saw.

### Evaluation:
- [ ] Solution compiles. If there are necessary steps required to get it to compile, those should be covered in README.md.
- [ ] No crashes, bugs, compiler warnings
- [ ] App operates as intended
- [ ] Conforms to SOLID principles
- [ ] Code is easily understood and communicative
- [ ] Commit history is consistent, easy to follow and understand
