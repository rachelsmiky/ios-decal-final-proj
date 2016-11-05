# Grubuddy
## Authors
- Ruijiao Song
- Van Xu
- Dongjie Zhu
- Junyan Kang

## Purpose
Grubuddy is an app that allows users to find someone to eat with, either a friend or a stranger based on user’s selection. 
It is location based with different check-in points covering different areas on the map. 

## Features
- Users can choose to check in the status, including location, available time and a description of what food he/she prefers
- A map will show all the check-in points around the campus. The user can view the check-in posted by people at each 
check-in point and contact them
- The check in post could either be shown to friend only or public. 

## Control Flow
- The initial page is a login page
- After logging in, users will see a map with check-in points
- Users can move around the map and select preferred restaurants.
- When users select a check-in point, details of the restaurant and the contact information will be shown.

## Implementaion
### Model
- CheckInPoint, an object that contains location, description and contacts
- User, an object that can post checkin points

### View Controller
- LoginViewController
- MapViewController
- CheckInDetailViewController

### View
- LoginView
- MapView
- CheckInDetailView
