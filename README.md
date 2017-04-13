# URL Shortener
This application is designed to shorten the original URL.
It is written in Ruby on Rails 5 with Angular Material v1.1.3 and AngularJS v1.6.3 and is a modern single page application(SPA)
## How to use:
You insert the original URL in the << Enter the original URL >> field, if you want, you can specify your preferred URL in the << Enter your preferred short URL >> field and click the << Get a short URL >> button.

The application checks the entered original URL for accessibility and shows an error if something went wrong.

If you enter your preferred short URL, then the application will check it for busy other users that will also inform you of the corresponding message.

If everything went well, you will get a short URL in the appeared << Your shortened URL >> field which is available for copying but not for editing.

You can share a shortcut with anyone, when pasted into the address bar of the browser, it automatically sends you to the original URL.
## Limitations:
Short URL is valid for 15 days from the date of receipt at the end of this period, this URL will forward you to the page for receiving a new link until it is taken by other users or you will not receive it again in the field << Enter your preferred short URL >>.
## API
The application provides JSON (JavaScript Object Notation) API (Application Programming Interface).

The POST(HTTP) request method for the relative URL '/ url_shorts' with the following JSON format body:
```
{
  "url_short":{
    "original_url":"original URL",
    "short_url":"preferred short URL"
  }
}
```
If successful, create a record in the database and return the JSON object in the following format:
```
{
  "url_short":"your shortened URL",
  "error":false
}
```
In case of a failure, JSON returns in the following format:
```
{
  "description": "error text", 
  "whose": "original_url or short_url or common", 
  "error": true
}
```
Also, the API provides information on all records in the database described with JSON. 

This is achieved by sending a GET(HTTP) request method to the relative URL 'url_shorts.json. 

The information obtained is a collection of the following format:
```
[
  {
    "original_url":"original URL entered by the user",
    "short_url":"URL truncated automatically or entered by the user",
    "hits_short_url":"number of visits through a short URL",
    "created_at":"date and time of creating records in the database in the format y-m-dTh:m:s.msZ"
  },
  ...
]
```
The working project is located at <https://url-shortener-aacmpdesigner.herokuapp.com/>
