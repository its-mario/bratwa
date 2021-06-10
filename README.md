# Bratwava

 ***under development***

*don't pay attention to name. it's the first thing that came to my friend's mind.*

This is a mesanging app built using [flutter](https://flutter.dev/) and [getStream](https://getstream.io/).  The app consits of two main parts **back-end**(node.js) and the app properly.  

<div>
<img src = "assets/structure.png"/>
</div>

*id and username are equals*

- **NodeJS Server** - is an express app that handle logIn/register requests and  generate tokens for accesing **getStream Servers**. Also it make connection with Mongo DB for processing LogIns and SingUps.

- **MongoDB** - store all ids, passwords and some specific information such as mail, and name of the user

- **getStream Servers** - are servers from [getStream.io](https://getstream.io/) to save chats messages and it handle the most logic of messanging. 

- **App** - flutter app or front-end for all that stuff. 

### App

*here might be descritption of app and how it works but unffortunetly the app right now is just a garbadge of code that somehow work* 😑

 



| ![a](assets/logIn.jpg) | ![a](assets/singUp.jpg) |
| ---------------------- | ----------------------- |
| ![a](assets/menu1.jpg) | ![a](assets/menu2.jpg)  |
| ![a](assets/chat1.jpg) | ![a](assets/chat2.jpg)  |
