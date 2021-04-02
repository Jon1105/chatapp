# Chat App
## Firestore Structure
Collection Users | Document user.uid | Fields: [name]

Collection PublicMessages | Document auto-id | Fields: [text, sender: User, seenBy[]User, MediaURL, edited]

Collection Rooms | Document (5 digit id) | Fields[name], Collection messages | Document auto-id | Fields: [text, sender: User, seenBy[]User, MediaURL, edited]

## Authentication
- First query name and sign in anonymously
- Upon Exiting the app, or signing out, warn the user that any messages previously made will be unaccessible unless they link their email and password
- If you want, you can sing in with Email/Password
  - Still query displayName of User
  - 

## Web Navigation
- Support for routing from urls


## User interface
Login Page -> HomePage -> Public Chat Room
                       -> Private Chat Room



## Improvements
- Add media functionality and host on [firebase cloud storage](https://firebase.google.com/docs/storage/)
- More Sign in Options
- Use flutter Navigator 2.0 *if you can understand it* 😥
- Add theming
  - user preferred theme in firebase
- Fix Text Alignment for messages
- 


# TODO
- map FirebaseAuthException error codes to more homogenous and human-readable strings.