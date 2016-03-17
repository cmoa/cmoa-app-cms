# Carnegie Museum of Art
## CMS

This CMS is meant to provide an efficient way to manage exhibitions, artists, artworks and related artwork media and metadata. There's a simple API layer to enable syncing functionality for mobile applications.

### Installation guide:

#### Ruby version

Ruby v2.0+ is recommended.

#### System dependencies

A robust server isn't required as API calls are cached via Redis. Use your favorite web and application server for Ruby on Rails.

Other system dependencies:

* PostgreSQL
* ImageMagick
* ffmpegthumbnailer
* Redis
* RubyGems
* Bundler gem (`sudo gem install bundler`)
* `bundle install` in the app directory for all required RubyGems to be installed

#### Configuration

Copy/rename **application.sample.yml** to **application.yml** in **/config** directory. Edit the following settings in the file:

* S3 configuration: **s3_bucket**/**s3_key**/**s3_secret** are self-explanatory. **s3_hash_secret** is a salt hash used to encode uploaded file names. Generate any long hash you prefer (eg. md5).
* **api_token**/**api_secret**: used to secure API calls. Generate any hashes you'd like here (eg. md5). Both of these will need to be implemented by your mobile applications for safe communication.
* MailChimp configuration: Enter your MailChip account API key and mailbox id to add submitted email addresses. End users are subscribed via an API call. Mobile applications need to implement this API call for this to function.

#### Database creation

Copy/rename **database.sample.yml** to **database.yml** in **/config** directory. Edit the file to reflect your database settings.

#### Database initialization

Run `rake db:migrate` once database configuration is complete.

#### Cron Jobs

Run `whenever -w` to generate and write the required crontab for you. Simply run `whenever` to see the output without automatic crontab edit.

#### Admin user account

There's currently no UI to create and manage the users. To create the first user, enter the Rails console and manually create the user entry. Example:

* `rails c` - to enter the Rails console
* `admin = Admin.new` - create a new Admin entry
* `admin.email = 'your@email.com'` - configure email
* `admin.password = 'password'` - configure password
* `admin.save` - save new Admin entry
* `exit` - exit the console
