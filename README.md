<a href="https://travis-ci.org/mike-vascelli/rubeetup"><img src="https://travis-ci.org/mike-vascelli/rubeetup.svg?branch=master"/></a>
<a href="https://codeclimate.com/github/mike-vascelli/rubeetup"><img src="https://codeclimate.com/github/mike-vascelli/rubeetup/badges/gpa.svg" /></a>
<a href='https://gemnasium.com/mike-vascelli/rubeetup'><img src="https://gemnasium.com/mike-vascelli/rubeetup.svg" alt="Dependency Status" /></a>
<a href='https://coveralls.io/r/mike-vascelli/rubeetup'><img src='https://coveralls.io/repos/mike-vascelli/rubeetup/badge.svg' alt='Coverage Status' /></a>
<a href="https://inch-ci.org/github/mike-vascelli/rubeetup"><img src="http://inch-ci.org/github/mike-vascelli/rubeetup.svg?branch=master"/></a>


# Rubeetup

## Overview

This gem allows you to interact with the `Meetup.com` API in a simple and direct way. It gives you access to all of the available API methods (full `CRUD`), and it also makes sure that all the required parameters are provided with each request.

For more information on the Meetup API itself, visit: http://www.meetup.com/meetup_api


### Requests' Naming Convention

They begin with the action to perform on a resource: (i.e. `create`, `get`, `edit`, `delete`) and are followed by underscore, and then the name of the resource requested (as in the Meetup API).
#### Eg.
    http://www.meetup.com/meetup_api/docs/2/open_events/

    resource:       open_events

    action:         get

    request name:   get_open_events


## Supported Requests

get_open_events,   get_concierge,   get_events,   create_event,   get_event,   edit_event,   delete_event,   get_event_comments,   create_event_comment,   get_event_comment,   delete_event_comment,   create_event_comment_flag,   create_event_comment_subscribe,   delete_event_comment_subscribe,   create_event_comment_like,   delete_event_comment_like,   get_event_comment_likes,   get_event_ratings,   create_event_rating,   create_attendance,   get_attendance,   create_event_payments,   create_watchlist,   delete_watchlist,   get_boards,   get_discussions,   get_discussion_posts,   get_categories,   get_cities,   get_dashboard,   get_activity,   get_groups,   get_comments,   create_group_photo,   get_find_groups,   get_group,   edit_group,   create_group_topics,   delete_group_topics,   get_recommended_groups,   create_recommended_groups_ignores,   get_similar_groups,   get_members,   get_member,   edit_member,   delete_member_photo,   create_member_photo,   get_status,   get_notifications,   create_notifications_read,   get_oembed,   delete_photo,   get_photo_comments,   create_photo_comment,   get_photo_albums,   get_photos,   create_photo_album,   create_photo,   get_profiles,   create_profile,   edit_profile,   get_profile,   delete_profile,   create_member_approvals,   delete_member_approvals,   get_rsvps,   create_rsvp,   edit_rsvp,   get_rsvp,   get_topic_categories,   get_topics,   get_recommended_group_topics,   get_open_venues,   get_venues,   get_group_venues,   get_recommended_venues,   create_venue

### Authorization
Rubeetup will need a Meetup api key to successfully perform the requests. This can be obtained by signing-up at http://www.meetup.com, and by requesting a key for your account.
Note that in order to `edit`, `create`, or `delete` any resource in the API, you must first obtain the privileges to do those actions. This usually means becoming an organizer for a group. This can be achieved by either starting a meetup group, or by being granted the authorization by a current organizer of a group. If you want to experiment with the API or simply do some live testing, then you can request to become an organizer for the <tt>Meetup API Testing Sandbox Group</tt>.

Visit this link http://www.meetup.com/Meetup-API-Testing for more information.

## Usage

```ruby
auth = key: 'val'

# If you wish to provide auth data for each instance,
# then pass it to the Rubeetup.setup call as an argument:
#
requester = Rubeetup.setup(auth)

# Otherwise you can pass default auth data once and be done with it:
#
Rubeetup.default_auth(auth)
requester = Rubeetup.setup


# Each request will take a Hash of options.
# Check in rubeetup/requests_lib/meetup_catalog.rb, or in the
# MeetupCatalog documentation, or at: http://www.meetup.com/meetup_api
# for a list of required and available parameters for your specific request.
#
# Rubeetup will raise an Error if any request is attempted without
# providing all the required parameters.
#
events = requester.get_events(group_urlname: 'Meetup-API-Testing')


# Every request returns an array of results, and you can safely iterate over them.
# Furthermore, each result stored in the array is a symbol-keyed Hash.
#
events.each do |event|
  # Each element is a Hash, so you can simply do:
  puts event[:name]

  # But Rubeetup also allows you to access elements' keys in OO-style:
  puts event.name
       .
       .
       .
  puts event.time
  puts event.duration

  venue = event.venue
  puts venue[:address_1]
  puts venue[:city]
end
```
To check each request's own required parameters:
Look in `lib/rubeetup/requests_lib/meetup_catalog.json`, or at: http://www.meetup.com/meetup_api

To find out about all the available response attributes visit the Meetup API documentation:
http://www.meetup.com/meetup_api

For example, for the `events` API request in the `Usage` example above, check this link:
http://www.meetup.com/meetup_api/docs/2/events






## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubeetup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubeetup

## Ruby Interpreter Compatibility

Rubeetup has been tested on the following ruby interpreters:

- 2.2.1
- 2.2
- 2.1
- 2.0.0
- 1.9.3
- 1.9.2

## Runtime Dependencies

- multipart-post

## Development

After checking out the repo, run `bin/setup`, or `bundle install` to install dependencies. Then, run `rake` or `rspec` to run the tests. You can also run `bin/console` or `bundle console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports are more than welcome! Here's the link: https://github.com/mike-vascelli/rubeetup/issues


## License

The MIT License (MIT)

Copyright (c) 2015 Mike Vascelli

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

