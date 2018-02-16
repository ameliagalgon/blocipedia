# Bloccipedia

[View project](https://damp-shelf-75006.herokuapp.com/)

**Rails 5.1.4**

**SQLite 3**

**Bloccipedia** is a Rails application that allows it's users to create public Markdown-based wikis. Users can update to a premium account to create private wikis. Premium users can add collaborators to their private wikis.

### Installation
Clone the repository
```
git clone https://github.com/ameliagalgon/blocipedia.git
```
Run bundle install to install all of the gems
```
bundle install --without production
```
Create and migrate an SQLite database
```
rake db:create
rake db:migrate
```
Start the rails server
```
rails server
```
Go to [localhost:3000](http://localhost:3000) to view the application in your local environment

### Gem dependencies
| Gem | Use |
| --- | --- |
| Bootstrap SASS | Style the application |
| [Stripe](https://stripe.com/) | Accept subscription payments from user |
| Figaro | Configure Stripe keys for the Heroky deployment |
| Devise | Authenticating users at log in and sign up |
| Pundit | Authorize user permissions |
| Faker | Seeding fake data |
| Redcarpet | Process wiki as Markdown text |

### Using Stripe
`config/initializers/stripe.rb` is configured to use a test key. The test variables were configured to Heroku using [Figaro](https://github.com/laserlemon/figaro). These keys can be found on your Stripe account.

#### Notes
Made with my mentor at [Bloc](http://www.bloc.io/).
