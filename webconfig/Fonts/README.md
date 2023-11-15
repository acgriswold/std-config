# Font web.config

## Introduction

Some applications may use custom fonts that are hosted on the server. If that file type and mimetype is not given up front they must be specifically mapped in the web.config file.

## web.config settings

- `<remove fileExtension =".otf"/>`: Ensures no overlapping mimetype is mapped for the `.otf` file type
- `<mimeMap fileExtension=".otf" mimeType="font/otf" />`: Adds a new mime type match for the `.otf` file type
