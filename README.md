# CAPCO's Flutter Assesment Application

## Introduction
Hi, my name is Chavin Panicharoen. You can call me Loong. I am a developer currently interested in mobile application development. This is my CAPCO's Flutter assesment.

## Brief Project Walkthrough
This application consists of 2 screens in total including<br />

1.) Home Screen<br/>
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
<p align="center">![image](https://user-images.githubusercontent.com/57981346/226172167-c5bfc5a7-f5f3-42b4-a4ef-1fb7aad8bb69.png)<br /></p>
<p align="center">![image](https://user-images.githubusercontent.com/57981346/226172269-2d64bb65-7880-4779-891e-09fd04252e9b.png)</p>

There is some adaptation for the assessment, such as model structure, package name, and JSON Decoding/Encoding, but the rest is the same.

## Installation

1.) Clone this Project into your local directory.<br />
2.) Install all the packages using command <br /><br />
```flutter pub get```<br /><br />
3.) Check Google Map's API Key in android/app/src/main/AndroidManifest.xml<br /><br />
 ```<meta-data android:name="com.google.android.geo.API_KEY" android:value="AIzaSyCyLVblb-ky-5hWlOT7a_vV_EjgQ5W38AY"/>```<br /><br />
 
 4.) Check Google Map's API Key in Runner.xcworkspace/AppDelegate.swift <br /><br />
 ```GMSServices.provideAPIKey("AIzaSyCyLVblb-ky-5hWlOT7a_vV_EjgQ5W38AY")```<br /><br />
 
 After this you should be able to launch the project properly, if you have any problem regarding the functionalities in the detail page please check according to <br /><br />https://pub.dev/packages/url_launcher<br /><br />
