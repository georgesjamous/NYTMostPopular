#  NYTimesMostPopular 

XCODE - Version 12.2 (12B45b)

This demo app is for demonstration purposes only and is not intended to be used in production.
This application pulls the latest most popular stories on NYTimes and displays them in a table view. 
Api key for NYT is hardcoded for now and might be expired by the time it is tested.

---

### Notes:
During development of this application several points are taken into consideration to complete it by a reasonable amount of time which is 2-3 hours max.


- VIPER architecture is used to seperate concerns.
- Several important functions have comments, you can check them for explanation.
- API-key for NYT Api is hardcoded. Since there is no server to authenticate, for demo purpose only the API Key and URL are hardcoded as contants. In practice, they should be stored in keychain or injected during a CI stage.
- Layout is fixed. Sizes for cells, text and images is fixes and does not depend on the story received from the api response.
- Custom caching is not implemented. The default URL Session cache in iOS is used for all requests.
- Error codes not checked. Since there is only one request, and error code of "200" is considered a pass, anything else is considered a failed request, and will not be retired automatically. App needs to be restarted.
- First image is picked. Each NYT Article might have multiple images with different sizes. For simplicity, only the first image returned is used in all views.
- Storyboards are no used, custom code programmatically places each component on screen. This allows for better and more precise design.
- Testing is not complete for demo purpose, only a fraction of the functions and UI are tested. (<20% code coverage)
- No external (3d party) libraries were used in this repo. Everything is written in Swift.

---

### Installation & Testing:

- Download, Extract and run in XCode 10.1 or later. (on Mac: Product -> Run)
- Testing can also be done in XCode using the native test command. (on Mac: Product -> Test)
  Coverage report should be generated by Xcode there.

---
