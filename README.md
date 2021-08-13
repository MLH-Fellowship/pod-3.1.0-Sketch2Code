<p align="center" width="100%">
 
 <img width="800" alt="S2C" src="https://user-images.githubusercontent.com/56252259/129200700-7dc994cb-7503-456a-a8cf-ad7a9abfb02f.png"> 

</p>

![Forks](https://img.shields.io/github/forks/MLH-Fellowship/pod-3.1.0-Sketch2Code?style=social)
![Stars](https://img.shields.io/github/stars/MLH-Fellowship/pod-3.1.0-Sketch2Code?style=social) 
![Watchers](https://img.shields.io/github/watchers/MLH-Fellowship/pod-3.1.0-Sketch2Code?style=social) 
![Issues](https://img.shields.io/github/issues/MLH-Fellowship/pod-3.1.0-Sketch2Code) 
![PRs](https://img.shields.io/github/issues-pr-raw/MLH-Fellowship/pod-3.1.0-Sketch2Code) 
![MIT License](https://img.shields.io/github/license/MLH-Fellowship/pod-3.1.0-Sketch2Code) 
![Top Language](https://img.shields.io/github/languages/top/pod-3.1.0-Sketch2Code/FellowStories) 
![Languages](https://img.shields.io/github/languages/count/MLH-Fellowship/pod-3.1.0-Sketch2Code)
![activity](https://img.shields.io/github/commit-activity/m/MLH-Fellowship/FellowStories) 
![contributors](https://img.shields.io/github/contributors-anon/MLH-Fellowship/pod-3.1.0-Sketch2Code)
![size](https://img.shields.io/github/languages/code-size/MLH-Fellowship/pod-3.1.0-Sketch2Code)
![lines](https://img.shields.io/tokei/lines/github/MLH-Fellowship/pod-3.1.0-Sketch2Code)
[![Maintenance](https://img.shields.io/maintenance/yes/2021?color=green&logo=github)](https://github.com/MLH-Fellowship/pod-3.1.0-Sketch2Code)
![Badge](https://img.shields.io/badge/Xcode-12.0-green)
![badge](https://img.shields.io/badge/Swift-5.1-red)
![Badge](https://img.shields.io/badge/Python-3.9-brown)
![badge](https://img.shields.io/badge/Core-ML-yellow)

# Sketch2Code🚀
Sketch-2-Code is a project which focuses on making coding easier and simpler. When it comes to coding in Swift, if we have any* doubts we refer to tutorials, blogs, etc, that was the usual way, But no more old procedures. Sketch-2-Code is the new & faster method to find help. Provide your UI Sketch or Text down your requirements and get instant output snippets with ready-to-use implementations of UIElements by S2C(Sketch 2 Code).

# Inspiration❤️

Our core mission is to increase the efficiency of the typical App development workflow & removing the redundant & time-consuming bits from the process by providing an easily accessible & automated solution where user can just provide a Sketch of UI and code will be autogenerated. This is how Sketch 2 Code came into existence. 

When we thought of something like this we were clueless on how to start and build this product. But later with the flow we tried various techniques, various languages and got one which would suit our requirements. Eventually with time we made the normal procedure more easy and user friendly to developers by integrating Machine Learning models into S2C. 

We also realised that it wasn't convenient for all to draw a Sketch of UI and hence also added another feature called Text 2 Code which is an even easier way where user can just type-in their requirements and the code wil be generated.

# Architecture
The Sketch2Code solution uses the following elements:

<p align="center" width="100%">
<img width="800" alt="Screenshot 2021-08-12 at 4 12 58 PM" src="https://user-images.githubusercontent.com/56252259/129193965-49ad8078-8976-442d-a3cd-e505724210d8.png"> 
</p>

# How to run ?⚙️

* Clone or download the app from this repository. 👩‍💻
* Open project file in terminal. 💻
* Open ```Swift Co-Pilot.xcodeproj``` in the app folder. 💾
* Change the bundle identifier. ⚙️
* Press Ctrl + R to run the app. 📲
* Do star this repo and/or contribute if you like it.🙂 

# How to Generate Code ?
In total we have 2 types of code generators:

## Sketch 2 Code✏️
Rigt now we have two type of Sketch 2 Code conversion:

### 1. Single Elelemnt Detecion

- In this we have concentrated on single UIElelement detection. There are times when developers need code of a specific type of UIElement.
- So in such cases users can go on with using the Single Element Detection.

#### Rules
- While using this feature developer need to provide the name of the element above and its shape.
- Providing name is really important
- And for elements like Buttons, TextFields user need to provide its shape too.

<!-- #### Elements which can be detected
| Elements  | Sketch |
| -- | -- |
| Buttons | ✅ |
| TextFields | ✅ |
| TextView | ✅ |
| Segment Control | ❌ |
| Labels | ❌ |
| Switches | ❌ | -->

### Quick Demo

<img width="400" alt="Screenshot 2021-08-12 at 4 12 58 PM" src="https://user-images.githubusercontent.com/56252259/129183908-d19ece27-27f3-41d0-98f5-25aa8ea90350.png">

Make sure you spell the element type correctly🪄

### 2. UI Screen Detection

- As the project tite suggests our prior motve was to ease the work of coding UI stuffs.
- If you want to get code of a particular UI screen then you can use this feature.

<!--#### Elements which can be detected
1. ImageView(I)
2. Buttons(BUTTONS)
3. TextField(TF)-->

### Quick Demo

<img width="400" height = "600" alt="Screenshot 2021-08-12 at 4 12 48 PM" src="https://user-images.githubusercontent.com/56252259/129183943-449e816e-d150-4f9e-b53d-97422cdce342.png"> <img width="400" height = "600" alt="Screenshot 2021-08-12 at 4 15 22 PM" src="https://user-images.githubusercontent.com/56252259/129184212-4ca9c45c-74de-40f9-8210-8115512d4d44.png">

Make sure you draw a rectangle box and add your UIElements inside it.

Make sure you spell the element type correctly🪄. 

You need to follow the naming type as given above.

## Text 2 Code 💬
- Text 2 Code is an additional feature which we have added for people who are not good in sketching😅. 
- Using Text 2 Code is really easy and simple, just start writing the element type and the suggestion box in the app will show you the order of writing.
- While writing the text you need to follow a set of order, which will be provided automatically by the App.

<!--#### Elements which can be detected
1. Buttons
2. Labels-->

# Snapshots of App 📸

# Features ⚡️
- ```Sketch to Code``` provides code snippet for UIElements in Swift & SwiftUI.
- ```Text to Code``` generates code snippet based on text provided.
- ```Save Snippet``` saves code snippets to our backend.

# Sponsor Technology

# Tech Stacks 🖥

<table>
<tr><td>

| Tech Stacks | Logo |
| -- | -- |
| Xcode | ![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white) |
| Swift | ![Swift](https://img.shields.io/badge/swift-%23FA7343.svg?style=for-the-badge&logo=swift&logoColor=white) |
| IBM Annotations| <img width="70" height = "30" alt="IBM" src="https://user-images.githubusercontent.com/56252259/128967971-8f6d853c-d56f-459d-8707-ee8ec89c9014.png"> |
| CreateML| <img width="70" height = "30" alt="CreateML" src="https://user-images.githubusercontent.com/56252259/128967854-50a9455c-b9e5-44bf-beda-2d6d2f57a7f9.png"> |
| Python | ![Python](https://img.shields.io/badge/python-%2314354C.svg?style=for-the-badge&logo=python&logoColor=white) |

 </td><td> 
 
| Tech Stacks | Logo |
| -- | -- | 
| PyCharm | ![PyCharm](https://img.shields.io/badge/pycharm-143?style=for-the-badge&logo=pycharm&logoColor=black&color=black&labelColor=green) |
| HTML | ![html](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white) |
| Heroku | ![Heroku](https://img.shields.io/badge/heroku-%23430098.svg?style=for-the-badge&logo=heroku&logoColor=white) |
| CockroachDB | ![CockroachLabs](https://img.shields.io/badge/Cockroach%20Labs-6933FF?style=for-the-badge&logo=Cockroach%20Labs&logoColor=white) |
| Postman| ![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=red) |
 
</td></tr> </table>
 
# Libraries📒
- UIKit
- SwiftUI
- VisionKit
- CoreML
- ImageIO
- [Loafjet](https://github.com/Loafjet/Loafjet)
- [Alamofire](https://github.com/Alamofire/Alamofire)

# What's next? 📱

With the upcoming releases we have thought of bringing various new features like:

I.   Multiple Coding Language Support

II.  Add more UIElements

III. Adding enhanced NLP in Text2Code, to make it more versatile

IV.  Make object detection more enhanced

V.   Release Sketch2Code as a Beta release to know user feedback

# Warnings ⚠️
- Right now S2C is not powerful enough to support all the UIElements that come with Xcode but, we are working on a top-down approach of covering the most used UIElements with the best possible accuracy.
- When we say provide Sketch and Text you do need to follow a few practices with your inputs to use S2C.
- With upcoming versions we focus on making S2C more powerful and more versatile

## Requirements to Run 🚩
- Xcode 12+
- Swift 5+
- PyCharm


## MLH Pre-Fellowship( Summer 2021)

> This is a hackathon project made by MLH Fellows - Pod 3.1.0 i.e. Recursive Rhinos - Team 4
<img width="1180" alt="Screenshot 2021-08-12 at 3 51 30 PM" src="https://user-images.githubusercontent.com/56252259/129181301-b8ed8da0-e6b4-4147-a2ee-ba4aeeddde7d.png">

# Project Maintainers 👨🏻‍💻

|                                                                                         <a href="https://github.com"><img src="https://user-images.githubusercontent.com/56252259/128824753-e1a60390-c0be-449f-ac89-62e6c016a11a.png" width=150px height=160px /></a>                                                                                         | <a href="https://gokulnair2001.wixsite.com/mysite"><img src="https://user-images.githubusercontent.com/56252259/115108512-83c79680-9f8e-11eb-837c-b0cf9a20560c.png" width=150px height=160px /></a>    | <a href="https://github.com/prabal4546"><img src="https://user-images.githubusercontent.com/56252259/115042145-d488b200-9ef0-11eb-922e-1dfc389db3e6.jpeg" width=150px height=160px /></a>|
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
|                                                                                                                                        **[Alex](https://github.com/amin-codes)**                                                                                                                                        |**[Gokul Nair](https://www.linkedin.com/in/gokul-r-nair/)**            | **[Prabaljit Walia](https://www.linkedin.com/in/prabaljit-walia-5800571a0/)**            |
| <img src="https://user-images.githubusercontent.com/56252259/114969025-24d22680-9e95-11eb-848d-b20e73269c4c.png" width="32px" height="32px"></a> <img src="https://user-images.githubusercontent.com/56252259/114967867-d6bc2380-9e92-11eb-8f89-c437f39a45de.png" width="32px" height="32px"></a>  <img src="https://user-images.githubusercontent.com/56252259/114967871-d7ed5080-9e92-11eb-8781-cd7cf9bb52db.png" width="32px" height="32px"></a> | <a href="https://www.instagram.com/_gokul_r_nair_/"><img src="https://user-images.githubusercontent.com/56252259/114969025-24d22680-9e95-11eb-848d-b20e73269c4c.png" width="32px" height="32px"></a> <a href="https://twitter.com/itIsGokulNair"><img src="https://user-images.githubusercontent.com/56252259/114967867-d6bc2380-9e92-11eb-8f89-c437f39a45de.png" width="32px" height="32px"></a>  <a href="https://www.linkedin.com/in/gokul-r-nair/"><img src="https://user-images.githubusercontent.com/56252259/114967871-d7ed5080-9e92-11eb-8781-cd7cf9bb52db.png" width="32px" height="32px"></a> |<a href="https://instagram.com/prabal4546?igshid=hq0bl8q25kur"><img src="https://user-images.githubusercontent.com/56252259/114969025-24d22680-9e95-11eb-848d-b20e73269c4c.png" width="32px" height="32px"></a> <a href="https://twitter.com/PrabaljitW"><img src="https://user-images.githubusercontent.com/56252259/114967867-d6bc2380-9e92-11eb-8f89-c437f39a45de.png" width="32px" height="32px"></a>  <a href="https://www.linkedin.com/in/prabaljit-walia-5800571a0/"><img src="https://user-images.githubusercontent.com/56252259/114967871-d7ed5080-9e92-11eb-8781-cd7cf9bb52db.png" width="32px" height="32px"></a> |

## Team
| GitHub Usernames                                      | Domain                     |
| ----------------------------------------------------- | -------------------------- |
| [@gokulNair](https://github.com/gokulnair2001)      | iOS App  + Documentation |
| [@prabaljitWalia](https://github.com/prabal4546)        |  iOS App + Documentation |
| [@Alex](https://github.com/amin-codes) | Backend |

- Feel free to contribute 💪🏼 

<p align="center" width="100%">
   Made with ❤️ By Developers   
</p>

