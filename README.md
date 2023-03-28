# GitHubTrends Application

### Arhitecture
+ Project is splited on *modules* (packages) with use of SPM. This helps to *isolate code* in specific modules that can be *tested*, *previewed* using SwiftUI previews. Additionaly this *reduces recompilation* of the project and makes it easy to *reuse* such modules in future.
+ We can split application even more with *feature* modules, which may represent screens or some noticable features. However, this adds complexity of using resources, assets, localization, etc. and requires additional time.

### Navigation
+ Each screen's model has it's own `Destination` enum in order to clearly represent *navigation paths* and makes navigation to be *data driven*.
+ This appoarch allows of using deep links, from pushes, external links or even easily navigate to deep screen while testing/debugging.
+ [SwiftUINavigation](https://github.com/pointfreeco/swiftui-navigation) is a lightweight framework, it hides all hassle of connecting destination enum cases and SwiftUI navigation APIs  
+ Repository details screen decided to be pushed, since this is a better choice when using iPad.

### Network
+ All requests and responses are containing *GH* prefix to indicate resource they are belonging too (*G*it*H*ub) 


### Unimplemented
+ Using R.swift for generating staticly available resources (assets, colors, fonts, localization, etc)
+ Using SwiftLint for code linting
