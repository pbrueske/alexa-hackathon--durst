# alexa-hackathon--durst

## Deploy to Heroku
```
heroku create
heroku buildpacks:add --index 1 heroku/ruby
heroku buildpacks:add --index 2 https://github.com/stomita/heroku-buildpack-phantomjs
git push heroku master
```
