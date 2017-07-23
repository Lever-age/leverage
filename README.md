[![Stories in Ready for Work](https://badge.waffle.io/Lever-age/leverage.png?label=ready%20for%20work&title=Ready%20for%20Work)](https://waffle.io/Lever-age/leverage)
[![Stories in Ready for Review](https://badge.waffle.io/Lever-age/leverage.png?label=ready%20for%20review&title=Ready%20for%20Review)](https://waffle.io/Lever-age/leverage)
# Leverage: Philly Campaign Finance

The goal of Leverage is to empower citizens of Philadelphia to use campaign finance data when making informed decisions about who they donate to, who they support, and who they vote for.

The foundation of Leverage is the campaign finance data published by the City of Philadelphia. We apply machine learning techniques to the data to pull out trends and patterns. Finally, we add a layer of simple visualization on top of the analyzed data, allowing any citizen to consume and understand how candidates are funded.

## Our Guiding Principles

* Empower citizens to make informed decisions.
* Don't single out individual donors; don't facilitate punitive actions.
* Design visualizations so they can be consumed by anyone, including non-native English speakers and illiterate citizens.

## Technology

Uses Django web framework for the backend with a postgres database. On the frontend, BackboneJS is used and communicates to the backend via Django Rest Framework.

## Documentation

We'll have some soon. We promise!

## Contributing

Leverage started at the [Code for Philly](https://www.codeforphilly.org) [DemHack 2016](https://codeforphilly.org/blog/apps_for_philly_democracy--hackathon-2016). The group has evolved over time, as most volunteer projects do. We have a great core team but are always looking for folks who want to contribute. Communication is done mostly through Slack and [Code for Philly hack nights](https://www.meetup.com/Code-for-Philly/). Instructions to contribute can be found [here](https://github.com/Lever-age/leverage/blob/master/CONTRIBUTING.md).

### Starting a development server

First, create a virtualenv and install the package (this will install dependencies, too).

```
cd path/to/this/repo
virtualenv env
source ./env/bin/activate
python setup.py develop
```

Now, you can create a database:

```
cd leverage
python manage.py migrate --settings=settings.dev
```

Now start the dev server:

```
python manage.py runserver --settings=settings.dev
```

## License

Please see the [license](https://github.com/Lever-age/leverage/blob/master/GNU%20Affero%20General%20Public%20License) file.
