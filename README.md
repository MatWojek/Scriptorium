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

- Ruby 3.2.3
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
bin/rails db:seed
```

Install Action Text and Active Storage tables (if not already present):

```bash
bin/rails action_text:install
bin/rails db:migrate
```

Start the development server:

```bash
bin/dev
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
