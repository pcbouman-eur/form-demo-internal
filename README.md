# Brief Demo for Webbased forms via Perl and jsonform

This is a brief demo to show how, roughly speaking, a webservice for web based forms could be implemented by combining the Perl Web Framework [Mojolious](https://mojolicious.org/) on the server side, and the frontend framework [JSONForms](https://jsonforms.io/). In this example, Vue is used together with Vuetify, but JSONForms supports other frontend frameworks as well (e.g. React and Angular).

The main purpose of this demo is to show how a modern web framework enables you to:

* Soley define the form specifications using nested hash structures in Perl (see [Data.pl](backend/Data.pl)). In practice you'd want to retrieve/construct these based on data in your Database.
* The perl backend does not perform any HTML rendering, only objects are dynamically rendered (see [WebApp.pl](backend/WebApp.pl)). This means you can fully separate any HTML and presentation development from the bussiness/data development in the backend.
* The frontend application retrieves the relevant data from the server and renders the forms dynamically. This application is static HTML/CSS and JS.

This is primarily meant for internal use to show how modern web frameworks could work. In practice, a lot more features would be needed to make this a viable application.

Note that I never wrote any Perl code before this, so it is quite likely not the nicest Perl ever written.

## How to use

For this to work, you need to have a few things installed: [NodeJS](https://nodejs.org) and [Yarn](https://yarnpkg.com/) to be able to compile/adjust the frontend. To be able to run the backend, you need a new enough version of [Perl](https://www.perl.org/) and [Mojolicious](https://mojolicious.org/).

Since the backend should also serve the static frontend code, it is important to compile the frontend before use. In the `frontend` directory, you should run:

```
yarn install
yarn build
```

The first step will download the necessary dependencies. The second step will compile the frontend and put the result in in the `backend/public` directory.

The application can be started with the `morbo` development server that is part of Mojolicious, by running the following within the `backend` directory:

```
morbo WebApp.pl
```




