# LoremPicsumPhoto
I approached this challenge using MVVM to keep the code clean, organized, and easy to maintain. I used dependency injection in the ViewModel so I can quickly switch between the real network service and mock services, which makes testing much simpler.

For networking, I used Swift’s modern async/await model and marked the ViewModel with @MainActor to ensure UI updates happen safely on the main thread. This keeps the code clear and avoids the complexity of callbacks.

To support testing, I built two mock services:

One that returns sample data

One that simulates a network failure

I also added basic accessibility support and built the UI entirely with SwiftUI.
