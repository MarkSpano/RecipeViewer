RecipeViewer App


### Summary: Include screen shots or a video of your app highlighting its features

![Simulator Screenshot - iPhone 16 Pro - 2025-01-07 at 14 18 18](https://github.com/user-attachments/assets/19b409f0-55ec-4a77-a205-8f340b804b5b)
![Simulator Screenshot - iPhone 16 Pro - 2025-01-07 at 14 18 28](https://github.com/user-attachments/assets/6bd23b8d-c066-4df1-8538-bfd42ce7c7e5)


The app starts with a list of recipes, including each recipe's name, cuisine and small image.  Clicking on any recipe brings up a video viewer.  If the video is available, it will play the video after clicking on the start button.  

To close the video, click the X in the upper left hand corner and then close the popup by dragging down on it. (This is a bit clunky at present.)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

Getting the basics done was the focus.  When I had some additional time, I added the videos.  

The main issue was caching the images so that the scrolling was smooth.  Here I decided to trade off space for speed in scrolling.



### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

Unsure exactly, but it is around 8-10 hours.


### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

The URL calls likely should have been part of a app data model rather than a view model but it would have been overkill here.


### Weakest Part of the Project: What do you think is the weakest part of your project?

The video code was added last and the error checking is less there than complete.


### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

The testing gives a good coverage number but, looking at the things that should have been tested, it is a bit sparse.
