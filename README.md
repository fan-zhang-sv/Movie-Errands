# Movie Errands

Movie Errands is a todo list app for movies, providing details about movies from The Movie Database API. This app is built using both UIKit and SwiftUI, and SwiftUI is the future!

This app is a prototype app to test the limit of SwiftUI. The only reason it's not a pure SwiftUI app is because by the time I started this app, there was still no proper alternative for UISearchController, by which I can have the elegant builtin animation.

There is another team who actually implemented a more aggressive app that achieved the same functionality but was built entirely using SwiftUI. [Dimillian/MovieSwiftUI](https://github.com/Dimillian/MovieSwiftUI)

## Preview

This is a todo list app that shows movies in columns, and once you click on the movie poster, a movie detail page would pop up providing more detailed infomration about the movie and recommendate related movies. Users can use the search page to search for movies to add into the list.

<center class="half">
    <img src="https://github.com/fan-zhang-sv/Movie-Errands/blob/master/images/6.5-inch%20screenshots.png?raw=true" height="400"><img src="https://github.com/fan-zhang-sv/Movie-Errands/blob/master/images/6.5-inch%20screenshots%20copy.png?raw=true" height="400"><img src="https://github.com/fan-zhang-sv/Movie-Errands/blob/master/images/6.5-inch%20screenshots%20copy%202.png?raw=true" height="400"><img src="https://github.com/fan-zhang-sv/Movie-Errands/blob/master/images/6.5-inch%20screenshots%20copy%203.png?raw=true" height="400">
</center>



This app also optimized for 5.5 inch devices and 12.9 inch devices. And with the update on SwiftUI released on WWDC 2020 this year, cross plartform (iOS, iPadOS, macOS) appliucation user experience would be more unified and effitient for users, and as a developer, I love this update very much!

<center class="half">
    <img src="https://github.com/fan-zhang-sv/Movie-Errands/blob/master/images/5.5-inch%20screenshots%20copy.png?raw=true" height="400"><img src="https://github.com/fan-zhang-sv/Movie-Errands/blob/master/images/12.9-inch%20iPad%20Pro%20copy.png?raw=true" height="400">
</center>


## Installation

Clone this project and create your own keys.plist that contains your apiKey from TMDB, and run it.
