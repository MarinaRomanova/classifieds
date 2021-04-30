# Classifieds

Simple app with MVC architecture

## Tech Specs
- Storyboard, xib, SwiftUI are not allowed. Auto Layout constraints are used instead
- URL session for networking (external libraries are not allowed, so no Alamofire)
- Simple cache management for images
- Compatible iOS 12+

## Overview of app architecture.
Model is represented by `ClassifiedsRepo` class. After `ApiClient` has fetched data, `ClassifiedRepo` maps it and send mapped data to the Controller that updates the view.

## Ameliorations previewed
- Use Core Data to cache fetched data
- Should use observables? (Combine requires iOS 13, NotificationCenter?)
- Localization

## Tests
- Unit tests use Mock data
- UI tests checks navigation

## Screenshots

<img src="https://user-images.githubusercontent.com/36896406/116721796-0401e900-a9de-11eb-93b4-bb6cba8d58ba.png" height="450"/>  <img src="https://user-images.githubusercontent.com/36896406/116721817-06644300-a9de-11eb-8900-7c179926602c.png" height="450"/>  <img src="https://user-images.githubusercontent.com/36896406/116721830-082e0680-a9de-11eb-8524-e68d5576d9ad.png" height="450"/>

