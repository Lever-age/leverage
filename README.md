[![Stories in Ready](https://badge.waffle.io/BayoAdejare/PhillyDemHack.png?label=ready&title=Ready)](https://waffle.io/BayoAdejare/PhillyDemHack)
# Leverage: Philly Campaign Finance

The goal of Leverage is to empower citizens of Philadelphia to use campaign finance data when making informed decisions about who they donate to, who they support, and who they vote for.

The foundation of Leverage is the campaign finance data published by the City of Philadelphia. We will apply some machine learning techniques to the data to pull out trends and patterns. Finally, we add a layer of simple visualization on top of the analyzed data, allowing any citizen to consume and understand how candidates are funded.

## Our Guiding Principles

* Empower citizens to make informed decisions.
* Don't single out individual donors; don't facilitate punitive actions.
* Design visualizations so they can be consumed by anyone, including non-native English speakers and illiterate citizens.

## Technology

Uses Django web framework for the backend with a postgres database. On the frontend, BackboneJS is used and communicates to the backend via Django Rest Framework.

## Documentation

We'll have some soon. We promise!

## Contributing

Leverage is still in its infancy. We have a great core team but are always looking for folks who want to contribute. Instructions [here](https://github.com/BayoAdejare/PhillyDemHack/blob/master/CONTRIBUTING.md).

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

Please see the [license](https://github.com/BayoAdejare/PhillyDemHack/blob/master/GNU%20Affero%20General%20Public%20License) file.
