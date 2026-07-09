# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ...

Add images, and use text files
Add generating the pdf files
Add language

# After reset database

bin/rails db:drop db:create db:migrate

# Install foreman

gem install foreman --user-install

# Create the category data

bin/rails db:seed

# Run program

bin/dev

# Install to use image

sudo apt install libvips

Panel Administracyjny
localhost:3000/admin

Add likes to show comment
Add likes to articles
Add searchbar add filters 
Add change password content to put old password and then change

Posty - admin/post
Commentarze admin/post/:id/comments
routes.rb namespace:
who, when, from what ip
action ban - after ip

user public profile

Add private articles for groups of user

avatar to user
and galery.js for more images

Filters (article filters from category, tags, likes and something like that)

tiny.pl/bn74t0q-d - click
https://admin.shopify.com/store/dev-matt-x0hwu1rq

# Scriptorium

A blogging platform built with Ruby on Rails 8, featuring user authentication, rich text articles (Action Text), comments, likes, and tagging. Styled with Tailwind CSS and powered by Hotwire (Turbo) for a fast, app-like feel.

## Features

- User registration and authentication (secure password hashing with bcrypt)
- Article creation and editing with a rich text editor (Action Text)
- Commenting system
- Article likes
- Tagging system for organizing articles
- User profiles
- Responsive UI built with Tailwind CSS

## Tech Stack

- **Ruby on Rails 8**
- **SQLite** as the database
- **Action Text** for rich text content
- **Active Storage** for file attachments
- **Hotwire (Turbo, Stimulus)** for interactive frontend behavior without heavy JavaScript
- **Tailwind CSS** for styling
- **bcrypt** for password hashing

## Data Model

The application is built around the following core models:

- **User** — has one profile, has many articles, comments, and likes
- __Article__ — belongs to a user and a category, has rich text content, has many comments, likes, and tags (through article_tags)
- **Comment** — belongs to a user and an article
- **Like** — belongs to a user and an article
- __Tag__ — has many articles (through article_tags)
- **Category** — has many articles
- **Profile** — belongs to a user

## Getting Started

### Prerequisites

- Ruby (see `.ruby-version` for the exact version)
- Bundler
- SQLite3

### Installation

Clone the repository:

```bash
git clone https://github.com/your-username/scriptorium.git
cd scriptorium
```

Install dependencies:

```bash
bundle install
```

Set up the database:

```bash
bin/rails db:create
bin/rails db:migrate
```

Install Action Text and Active Storage tables (if not already present):

```bash
bin/rails action_text:install
bin/rails db:migrate
```

Start the development server:

```bash
bin/rails server
```

Visit `http://localhost:3000` in your browser.

## Running Tests

```bash
bin/rails test
```

## Project Structure

```rb
app/
  controllers/    # Application controllers (sessions, users, articles, comments)
  models/         # ActiveRecord models and associations
  views/          # ERB views, styled with Tailwind CSS
db/
  migrate/        # Database migrations
config/
  routes.rb       # Application routes
```

## License

This project is licensed under the MIT License.
