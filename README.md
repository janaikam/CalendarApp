Original App Design Project - README Template
===

# Calendar Finder

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app is designed to find events occuring around the user with data on location, amount of people, and date and time and add it to the users calendar.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social/Productivity
- **Mobile:** This app allows users to have a map where events are happening, so they can see it on their phone. It’s more than a wbesite because it connects to your calendar, so you can see potential conflicts. It walso allows for you to see how many people will be there.
- **Story:** The app is meant for users to easily find things to do either around their home or in a new area, which is helpful in meeting new people. 
- **Market:** This app is meant for anyone who wants to go out and do soemthing in their area.
- **Habit:** Because people would be wanting to find things to do in their free time, this app would be used frequently as a way to find events. 
- **Scope:** This app would include getting data from maps and calendars in order to work properly. It would also include creating events and pushing that data to the database it came from. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User can Login/Sign up
- [X] User can Logout
- [X] User is able to create an account to log in
- [ ] User can access their calendar in month form
- [ ] User can see/scroll through events from their Facebook feed
- [ ] User can add events to their calendar
- [ ] User can click on an event to see a detailed page with location, number of confirmed attendees, a picture, and a map
- [ ] User can create events

**Optional Nice-to-have Stories**

- [ ] User can see indicator where there is an activity for the day
- [ ] User can change how the calendar looks
- [ ] User can see events that are near their current location
- [ ] User can respond saying they are going to an event
- [ ] User can share events with friends
- [ ] User can see a map of an event's location if it is in person
- [ ] User can search for events in specific locations
- [ ] User can login as a Guest but that prevents them from creating/adding events to their calendar
- [ ] User can click on the map to expand it

### 2. Screen Archetypes

* Login
   * User can Login
* Register
   * User is able to create an account to log in
* Stream
    * User can see/scroll through events from their Facebook feed
    * User can add events to their calendar
* Detail
    * User can click on an event to see a detailed page with location, number of confirmed attendees, a picture, and a map
    * User can respond saying they are going to an event
    * User can share events with friends
    * User can see a map of an event's location if it is in person
* Creation
    * User can create events
* Settings
    * User can change how the calendar looks
    * User can Logout
* Calendar
    * User can access their calendar in month form
    * User can add events to their calendar
    * User can see indicator where there is an activity for the day

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Calendar
* Stream

**Flow Navigation** (Screen to Screen)

* Login 
   * Stream
* Register
   * Stream
* Stream
    * Detail
    * Creation
* Detail
    * Calendar (after adding the event to the calendar)
* Creation
    * Calendar (after creating the event)
* Settings
    * None
* Calendar
    * Settings
    * Detail

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://github.com/janaikam/CalendarApp/blob/master/updated_wireframes_713.jpg?raw=true" width=600>


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
Calendar Event

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | eventName     | String   | Name of the event a user created |
   | eventImage    | File     | image that the user posts with an event |
   | eventDescription | String   | Description of what the event is |
   | attendeeCount | Number   | number of attendees at an event |
   | startTime     | DateTime | time and date the event begins |
   | endTime       | DateTime | time and date the event ends |
   
### Networking
- [Add list of network requests by screen ]

* Stream Screen
  * (Read/GET) Query all events from the user's feed
  * (Read/GET) Location of events in the area
  * (Create/POST) Confirming that you are going to an event
* Creation Screen
  * (Create/POST) Create a new event
* Calendar 
  * (Read/GET) User's calendar

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
Base URL - https://developers.facebook.com/docs/graph-api/reference/event/

```

// For more complex open graph stories, use `FBSDKShareAPI`
// with `FBSDKShareOpenGraphContent`
/* make the API call */
FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                               initWithGraphPath:@"/{event-id}"
                                      parameters:params
                                      HTTPMethod:@"GET"];
[request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                      id result,
                                      NSError *error) {
    // Handle the result
}];

```

| Property      | Type     | Description | 
| ------------- | -------- | ------------|
| id       | numeric string | event id   |
| attendingCount  | Integer | number of people attending |
| cover    | File | event photo |
| description | String      | event description |
| is_online | Boolean | is the event online or not |
| end_time | string | time when the event ends if given |
| name     | String | event name |
| place    | Place | place where event is occurring (includes name and location) |
| start_time | string | time when the event starts |





