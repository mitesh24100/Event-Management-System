Event Management System 
======================
Event Management System is created using Ruby on Rails. This is a program 2 assignment for CSC 517. Event Management System enables attendees to explore Events and purchase Tickets. Attendees can also provide Reviews for the events they have attended. Additionally, the Admin has the capability to create events, and access information on all Attendees, Tickets, and Reviews.

**Please update on this email if application is not running on VCL: vgandhi@ncsu.edu**

## Link to the deployed application
http://152.7.177.84:8080/

## Admin credentials
* email : admin@ncsu.edu
* password : thisisadmin

## Sample User credentials
* email : np@gmail.com
* password : 1234

## Setting up

* Installation of Ruby version 3.1.2

```
1. cd $HOME
2. sudo apt-get remove ruby
3. sudo apt update 
4. sudo apt install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev
5. git clone https://github.com/rbenv/rbenv.git ~/.rbenv
6. echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
7. echo 'eval "$(rbenv init -)"' >> ~/.bashrc
8. exec $SHELL
9. git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
10. echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
11. exec $SHELL
12. rbenv install 3.1.2
13. rbenv global 3.1.2
```

* Clone this repository
```
git clone https://github.ncsu.edu/npatil2/CSC517_Program2.git
```
* Go to the directory
```
cd CSC517_Program2
```
* Install required gems
```
bundle install
```
* Run database migration on your system
```
rails db:migrate
```
* Run seed for the setting up required data
```
rails db:seed
```
* Finally, run the rails server
```
rails server
```


## Admin Functionalities:

1. Log In:
Admins can log in using their email and a password.There is "LOGIN" link on the homepage which is common for both users and admin. Admin is preconfigured and credentails are mentioned above.

2. Edit Profile:
Admins can edit their own profiles, but cannot update ID, email, and password. Once logged in with the admin credentials to perform this functionality there is "EDIT MY PROFILE" link on the admin homepage.

3. View All the Events:
Admins can view all the events that are available on the system. This can be done by clicking on the "View Events & Book Tickets" link.

4. List Events by Category/Date/Price/Event Name:
Admins can list events by a specific category, date, price (~ price range to be precise), and event name. There is the option for this once you click "View Events & Book Tickets" link on the admin homepage. The filter requires you to input all the attributes.

5. View All Users:
Admins can view all the attendees signed up on the event management system. For this click on the "Attendees" link on the admin homepage.

6. List Reviews by User:
Admins can list reviews written by a specific user (by name). For this, click on "See Reviews" link present on the admin homepage. We have not displayed user name while showing reviews to keep the reviews anonymous to everyone. So to test this functionality we have pre populated the data so you can check by admin user or you can create your own review and test it.

7. List Reviews for a Specific Event:
Admins can list reviews written for a specific event (with Event name). For this, click on "See Reviews" link present on the admin homepage. 

8. Manage Attendees:
Admins can create, view, edit, and delete attendees. For this, click on "Attendees" link present on the admin homepage.

9. Manage Events:
Admins can create, view, edit, and delete events. For this, click on "View Events & Book Tickets" link present on the admin homepage.

10. Manage Tickets:
Admins can create, view, edit, and delete tickets. For creating the ticket, click on "View Events & Book Tickets" link present on the admin homepage. There option to book tickets can be found under upcoming events. To perform other operations click on "Show/Edit/Delete tickets" present on the admin homepage.

11. Manage Reviews:
Admins can create, view, edit, and delete reviews. For creating the reviews click on "MY BOOKING HISTORY" and there will be "Add reviews" option. 
Please note:- You won't be able to add reviews for all the events. Reviews can only be added for the events that have occurred in the past and tickets were booked. We have pre populated some of the data to test this functionality. 
To perform other operations click on the "See Reviews" link on the admin homepage.

12. Manage Rooms:
Admins can create, view, edit, and delete rooms. For this, click on "Rooms" link present on the admin homepage.

     - Admin is able to search only available rooms in a particular time slot
(If a room is already booked, that it is not visible for the admin as part of his/her event creation during the time slot when the room is booked) For this while creating the event click on "Search Rooms" and that should show only the rooms which are available during that time slot.

13. Admin should also be able to book events like an attendee and attend them. For this, there is an option to book tickets under the "View events & book tickets" link on the admin homepage.

## Attendee Functionalities:

1. Sign Up for a New Account:
Attendees can create a new account on the system. For signing up there is "Signup" link and for login there is "login" link. Login link is common to both user and admin so you can login with the same link.

2. Log In:
Attendees can log in using their email and a password. There is "login" link.

3. Edit Profile:
Attendees can edit their own profiles, except for updating their ID. For this, click on "Edit my profile" link present on the attendee homepage.

4. Delete Account:
Attendees have the option to delete their own accounts. For this, click on "Delete my profile" link present on the attendee homepage.

5. View Available Events:
Attendees can view upcoming events with available seats. For this, click on "View Events & Book Tickets" link present on the attendee homepage.

6. Filter Events by Category/Date/Price:
Attendees can filter events by Category/Date/Price (Price range). For this, click on "View Events & Book Tickets" link present on the attendee homepage.

7. List Events by Event Name:
Attendees can search Events by Event Name. For this, click on "View Events & Book Tickets" link present on the attendee homepage.

8. Book a Event Ticket:
Attendees can book a Event Ticket. For this, click on "View Events & Book Tickets" link present on the attendee homepage.

9. Check Booking History:
Attendees can check their own booking history (Atleast Event Name and Date should be visible). For this, click on "My booking history" link present on the attendee homepage.

10. Write Event Reviews:
Attendees can write reviews for events they have attended, but only for the events with categories of Concerts, Sports, and Arts & Theatre categories. Attendees can review only after the event ends, and by logic, reviews should be visible only after the event ends. So not all the events will see the add review option.

11. Edit Own Reviews:
Attendees can edit the reviews they wrote but cannot edit reviews by other users. For this, click on "See reviews" link present on the attendee homepage.

12. List Reviews by User:
Attendees can list reviews written by a specific user (by Email of the User). For this, click on "See reviews" link present on the attendee homepage. 

13. List Reviews for a Specific Event:
Attendees can list reviews written for a specific event (by Event Name). For this, click on "See reviews" link present on the attendee homepage.

14. Cancel a Ticket:
Attendees can cancel their booked tickets. This can be done by clicking on the "Tickets" on the attendee homepage.

There will be 6 main components in the system:

1.  Admin

2.  Attendee

3.  Room

4.  Event

5.  Event Ticket

6.  Review  


## Bonus (Extra Credit):
  1. This project correctly implemented a search function for the admin to use. The input is the event name; the search result is a list of attendees who booked this event.
  * To access this:  
    -> Log in as admin   
    -> Enter Event Name to get list of attendees who booked that event.

  2. This project implemented a function to allow an attendee to buy a ticket for another attendee (the ticket can be viewed by both the user who pays for the ticket and the user who receives the ticket).

  * To access this:  
  We have created two fields for this functionality. First ticket purchased by and second ticket purchased for. During booking tickets, there is an option to book ticket for and sselecting the user for whom ticket needs to be booked. If nothing is selected by default ticket is booked for the one who is booking it. Now the ticket can be visible in the booking history of both the users the one who has booked the ticket and the one the ticket is purchased for.

## Test Cases

If you face any error that is because while cloning the repository the file is overwritten when you might have entered Y while prompted. Please make sure the below function is present in the spec/spec_helper.rb file at the very start before "RSpec.configure do |config|" line. Than run the commands for tests.
```
def sign_in(user)
  session[:user_id] = user.id
end
```

Run the following command to setup Rspec
```
rails g rspec:install
```
We have added testing for Room. To run the room controller test run:
```
rspec spec/controllers/rooms_controller_spec.rb
```
For the room model test run:
```
rspec spec/models/room_spec.rb
```
  
## Contributors
<table>
  <tr>
    <td align="center">
      <a href="https://github.ncsu.edu/magarwa3"><img src="https://avatars.github.ncsu.edu/u/30727" width="80px;" alt=""/><br />
        <sub><b>Mitesh Agarwal</b></sub></a><br />
    </td>
    <td align="center">
      <a href="https://github.ncsu.edu/vgandhi"><img src="https://avatars.github.ncsu.edu/u/29181" width="80px;" alt=""/><br />
        <sub><b>Vishwa Gandhi</b></sub></a><br />
    </td>
    <td align="center">
      <a href="https://github.ncsu.edu/npatil2"><img src="https://avatars.github.ncsu.edu/u/26456" width="80px;" alt=""/><br />
        <sub><b>Neha Patilv </b></sub></a><br />
    </td>
  </tr>
</table>


