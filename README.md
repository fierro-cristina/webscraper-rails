# Rails webscraper

This is a simple application that scrapes information from the website 'https://news.ycombinator.com/' and filters the scraped information.

## Rails and ruby versions
Rails: 7.2.1

Ruby: 3.1.2

## To get this project up and running in your local environment
Clone the repository locally by running

```
git clone https://github.com/fierro-cristina/webscraper-rails.git
``` 

Make sure to have ruby version 3.1.2 in your machine. If you do not, see this page for instructions on how to install it: https://www.ruby-lang.org/en/documentation/installation/

This app runs on rails v7.2.1, so make sure to have that installed as well. See this page for installation instructions: https://guides.rubyonrails.org/v5.0/getting_started.html

Once you have everything set up, install the necessary gems and dependendies by running the following command in your root directory

```
bundle install
```

If no errors popped up, you are good to go! 

## Start the server and navigate to the correct route
To start the server run

```
rails s
```

Once that is running, go to the host url your project is running on.

The scraper route is the following

```
<server-route>/scraper
```
## Request logs will be saved

Requests are considered filter requests, so everytime you apply a filter, a log will be written in a CSV file called

```
resquest_log.csv
```

## Run the tests

```
rspec
```

