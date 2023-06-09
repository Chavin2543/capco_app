# CAPCO's Flutter Assesment Application

## Introduction
Hi, my name is Chavin Panicharoen. You can call me Loong. I am a developer currently interested in mobile application development. This is my CAPCO's Flutter assesment.

## Brief Project Walkthrough

<video src='https://user-images.githubusercontent.com/57981346/226173219-9bd29edf-5ad7-4501-810a-2f53c2ae90f4.mov'/><br/>

This application consists of 2 screens in total including<br />

1.) Home Screen (Master Screen)<br/>
  This screen shows a scrollable list of all users from the provided API (https://jsonplaceholder.typicode.com/users). The application's user can tap on each user's card to navigate to the Detail page or swipe to refresh the list for some API Updates.
  
2.) Detail Screen<br/>
  This screen shows a detail of a specific user, including their username, full name, address information, and business information. There's an action bar that which Application's user can use to perform a pre-defined action from target user information, including
  
   2.1) Visit target user's website<br />
   2.2) Call target user<br />
   2.3) Email to target user<br />
   2.4) See target user's location<br /><br />
  
## Architecture
This project is built using Clean Architecture. Based on Mr.Andreas Velounias's Flutter-news<br />

These are the diagram of the project's architecture<br />
![image](https://user-images.githubusercontent.com/57981346/226172167-c5bfc5a7-f5f3-42b4-a4ef-1fb7aad8bb69.png)<br />
![image](https://user-images.githubusercontent.com/57981346/226172269-2d64bb65-7880-4779-891e-09fd04252e9b.png)

There is some adaptation for the assessment, such as model structure, package name, and JSON Decoding/Encoding, but the rest is the same.

## Unit Test
There are some unit tests in the repository, the code coverage is around 50% because of the timeframe and also I haven't been using TDD from the start. Of course this is based on Andres's Flutter-news as well. 

## Installation

1.) Clone this Project into your local directory.<br />
2.) Install all the packages using command <br /><br />
```flutter pub get```<br /><br />
3.) Check Google Map's API Key in android/app/src/main/AndroidManifest.xml<br /><br />
 ```<meta-data android:name="com.google.android.geo.API_KEY" android:value="AIzaSyCyLVblb-ky-5hWlOT7a_vV_EjgQ5W38AY"/>```<br /><br />
 
 4.) Check Google Map's API Key in Runner.xcworkspace/AppDelegate.swift <br /><br />
 ```GMSServices.provideAPIKey("AIzaSyCyLVblb-ky-5hWlOT7a_vV_EjgQ5W38AY")```<br /><br />
 
 After this you should be able to launch the project properly, if you have any problem regarding the functionalities in the detail screen please check according to <br /><br />https://pub.dev/packages/url_launcher<br /><br /> or you can contact me directly

 
 ## Contact
If you have any problem installing, building, cloning or running the project, feel free to contact me on any platform.<br/>
Phone: +6682-704-7606<br/>
Email: chavinrung2543@hotmail.com<br/>
LinkedIn: https://www.linkedin.com/in/chavin-panicharoen-76219614a<br/>
