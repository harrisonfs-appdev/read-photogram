# Photogram READ

In this project, you'll synthesize everything you've learned about

 - Relational database design
 - Ruby programming
 - Querying
 - HTML
 - RCAV
 - ERB
 - params

to create a dynamic, database-backed web application. Here is our target:

[https://photogram-read-target.herokuapp.com/](https://photogram-read-target.herokuapp.com/)

I've already created these tables for you:

![Domain Model](erd.png?raw=true "Domain Model")

But, so far, there's no interface whatsoever.

## Setup

 1. From [your Cloud9 repositories list](https://c9.io/account/repos), set up a workspace [as usual](https://guides.firstdraft.com/starting-on-a-project-in-cloud9).
 1. Set up the project: `bin/setup`
 1. Start the web server by clicking "Run Project".
 1. Navigate to your live application preview. You should see the "Yay! You're on Rails" page.
 1. Run `rails dummy:reset` to pre-populate your tables with some dummy development data.
 1. As you work, remember to navigate to `/git` and **always be committing**.

> Note that if for some reason later you want to reset the database again, you need to first destroy it:
>
> ```bash
> rails db:drop
> ```
>
> and then re-create and re-populate it:
>
> ```bash
> rails db:migrate
> rails dummy:reset
> ```

## Tasks

Ultimately, your task is: make your app's behavior match the target (ignoring styling).

But, here's a broken out list of tasks:

- Build support for `/recent`, which should show the photos in the table ordered from newest to oldest. Show only the 25 photos.
- Build support for `/popular`, which should show the photos in the table ordered from most liked to least liked. Show only 25 photos.
- Build support for `/photos/42`, `/photos/123`, etc — where `42`, `123`, etc, are the ID numbers of photos. These pages should show the details of individual photos, including the caption, owner's username, how long ago it was posted, the usernames of the photo's fans, and the comments left on the photo.
- Build support for `/users`, which should show all of the users ordered by username.
- Build support for `/users/42`, `/users/123`, etc — where `42`, `123`, etc, are the ID numbers of users.
- Build support for `/users/42/liked`.
- Build support for `/users/42/feed`.
- Build support for `/users/42/discover`.

## Hints

 - Navigate to `/git` and **commit often**; in particular, after you complete a task and before you start the next.
 - The big black banner at the top of the error page is the most important part. Don't ignore it. **Read The Error Message.**
 - Let Ruby's error messages guide you. They are trying to be helpful; they just have poor social skills. Try to make sense of their overly formal wording.
 - There's a whole `rails console`, frozen at the moment in time that the error occurred, in the middle of the error pages. You can use it to poke at the variables and see what their values were at that moment, and experiment with fixes.
 - The error pages also display helpful information like what controller and action were being routed to, and what was in the `params` hash, near the bottom.
 - Refer to your past work. This isn't a memorization competition. In particular, **remember the instance methods you wrote in the Photogram Queries project** — if you define them in your models here, writing your interface will become a lot easier!
 - You don’t have to worry about CSS styling at all; just get the app to do the right thing. However if you want your CSS to be slightly better than the browser defaults, you can add

    ```html
    <link rel="stylesheet" href="/light.css">
    ```

    to the `<head>` of your documents, which you'll find in your `app/views/layouts/application.html.erb` file.
 - In your browser, don’t get confused between the target app and your development app. Make sure you are refreshing your own app to test your work.
