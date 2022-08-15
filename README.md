# gskinner

This app is a null safe implementation of
https://blog.gskinner.com/archives/2020/09/flutter-state-management-with-mvcs.html#comments

## App flow

1. A `LoginPage` with a button that triggers `LoginCommand`
1. `LoginCommand` makes `UserService.login` call.
1. If `UserService.login` is successful, `LoginCommand` sets
   `AppModel.currentUser` and initiates the `RefreshUserPostsCommand`. 
1. `RefreshUserPostsCommand` fetches latest posts and sets (if
   successful) `UserModel.userPosts`
1. Our `AppScaffold` is bound to `currentUser` and will show
   `HomePage` whenever `currentUser != null` 
1. `HomePage` is bound to `userPosts` and will display a list of posts
   if there are any.
1. `HomePage` will also have a "refresh" button that triggers the
   `RefreshUserPostsCommand` each time it is pressed.

### Few patterns that we can abstract from the flow above are:

1. `Services` have the task of returning the data they're asked to the
   caller.
1. The caller of any `Service` shall be a `Command`. The command after
   getting data from `Service` sets the `Model` as needed.
1. `Model` notifies the `View`
1. `View` displays data.
1. `Views` are **bound** to `Models`
1. `Views` also have buttons that can trigger `Commands`
1. `Commands` can be changed. A `Command` can trigger other `Commands`. 

### Patterns mentioned:

1. Initiating a Command directly from a View
1. Using a Service inside a Command and then updating the Model.
1. Spawning a Command within another (chaining)
1. Same command could be used in multiple places.
1. View:Model binding.

### Models

1. `AppModel` (`currentUser`, `currentTheme`, etc.)
1. `UserModel` (`userPosts`, `userSettings`, etc.??)


