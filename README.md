terasology_mods
===============

Terasology mods database.

## Getting started

1. Copy sample omniauth config file and set Client ID and Secret ID in it.
       
        cp config/initializers/omniauth.rb.sample config/initializers/omniauth.rb

2. Install gems

        bundle install

3. Create dev. database

        rake db:migrate

4. Start server

        rails s
    
5. Go to http://localhost:3000
