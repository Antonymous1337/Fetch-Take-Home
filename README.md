### Summary: Include screenshots or a video of your app highlighting its features
<img src="https://github.com/user-attachments/assets/c4e8534a-463a-4233-8bb0-9467aebb0a60" width="200px" image-resolution="1dpi">
<img src="https://github.com/user-attachments/assets/c9535c68-2b1d-4939-9349-489d6e1cb1b9" width="200px" image-resolution="1dpi">
<img src="https://github.com/user-attachments/assets/7f31dbf0-67b6-4df1-980d-96feb6bbcc3f" width="200px" image-resolution="1dpi">
<img src="https://github.com/user-attachments/assets/32b01281-34ac-4815-9154-df077e2b0594" width="200px" image-resolution="1dpi">
<img src="https://github.com/user-attachments/assets/b3c18dd0-8009-41e0-afbb-c2bba4ee3130" width="200px" image-resolution="1dpi">
<img src="https://github.com/user-attachments/assets/24bfb4a1-56fc-4c13-9986-7bae280ebc23" width="200px" image-resolution="1dpi">


<br><br>

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

Outside of prioritizing the requirements I was given (such as implementing my own Cache and handling different possible API inputs), I put considerable thought on ***UX (User Experience)***. I focused on this because a good UX is one of the most beneficial qualities that a commercial product can have. I did this by:
1. Ensuring all recipes are organized by their cuisine, with each cuisine and recipe organized alphabetically for easy searching.
2. Structuring the RecipeIslandView so that users can see all cuisines and recipes at the same time, to minimize extra taps and swipes to navigate all the recipes.
3. Adding a Search feature so that users can filter the available recipes, without having to find the "needle in the haystack" that would be their desired recipe.
4. Adding a RecipeDetailView so that users can see all the possible data I could retrieve from the API calls, without holding anything back.

A few other areas I focused on were ***Scalability*** and ***Efficiency***. Scalability is important for all projects because it's easier to add to the project later on. Code decay is a serious issue in both startups and in more successful businesses with a mature product, and it can take the work of many engineers to offset it if code quality and code scalability aren't given the care they deserve.

Efficiency is also important, especially when it comes to mobile development. Phones have less processing power than computers, and from my experience, users have a shorter attention span on their phone than on their computer. Fast, reactive apps are essential to meet the bare minimum of user expectations; so the app mustn't lag or waste time when it doesn't have to.

<br><br>



### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent 8 hours total. Most of my time was spent brainstorming the UI and UX, learning Image Caching, and releasing XCTest. I simply never learned how to manually cache images before, but I'm proud that I got it working. And XCTest is something I dabbled in previously for the sake of learning it, but never really needed it in my indie app projects. Relearning XCTest was also a lot of fun!

<br><br>



### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

One trade-off I made was to decide NOT to create a priority queue implementation for processing Recipe data, which could improve the speed of processing. I decided against this as it would take extra development time for marginal improvement.

Same goes with limiting Dynamic Type, as it can take a lot of time to ensure the app looks good with many (or all) of the dynamic fonts.

An annoying trade-off I had to make was to extend the availability (from fileprivate to public) of some classes so that I could test them. I could have likely spent more time to figure out how to keep the fileprivate classes while also testing them, but I didn't want to spend more development time on something that will likely not bare any fruit.

Furthermore, I wanted to create the app in iOS 16.0, since that is the version that Fetch works on. This led to some small limitations on what iOS developer features I could use.

<br><br>



### Weakest Part of the Project: What do you think is the weakest part of your project?

UI. I don't think the UI is bad, but I'm sure there are some UI elements that could be improved upon. The biggest one is when a user tries to refresh the RecipeIslandView while they are using the search feature. It pushes the loading icon beyond the screen, and I couldn't find a way to fix that. However, it seems to be a relatively inconsequential bug so I let it slide.

<br><br>



### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I'm just thankful I got the opportunity to work on this take-home project because it was a lot of fun! XCTest makes more sense to me now, I learned how to read JSON objects with optional data, Image Caching isn't as bad as I thought, and I learned how to add a search feature to my apps now.
