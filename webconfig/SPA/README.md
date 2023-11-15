# SPA web.config

## Introduction

SPA applications need specific routing instructions to prevent complications with complex routing systems. One noteable issues can be refreshing your SPA at a subroute and being directed to a 404 page. You need to change the servers routing to rewrite these paths back to the root path to ensure the proper files are downloaded.


## web.config settings

- `<match url="(.*)" />`: Captures all requested routes
- `<add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />`: Ignores file requests to ensure assets, pictures, font, .css files, etc. can be properly downloaded
- `<add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />`: Ignores file directories to ensure they can be properly downloaded
- `<action type="Rewrite" url="./" appendQueryString="true" />`: All other paths will be rewritten to the root url.