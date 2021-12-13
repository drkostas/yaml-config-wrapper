# YAML Config Wrapper

[![CircleCI](https://circleci.com/gh/drkostas/yaml-config-wrapper/tree/master.svg?style=svg)](https://circleci.com/gh/drkostas/yaml-config-wrapper/tree/master)
[![GitHub license](https://img.shields.io/badge/license-Apache-blue.svg)](https://raw.githubusercontent.com/drkostas/yaml_config_wrapper/master/LICENSE)

## About <a name = "about"></a>

A YAML configuration wrapper.

## Table of Contents

+ [Using the library](#using)
    + [Installing and using the library](#install_use)
    + [Creating a config file](#configuration)
    + [Set the required environment variables](#env_variables)
+ [Manually install the library](#manual_install)
    + [Prerequisites](#configuration)
    + [Install the requirements](#installing_req)
    + [Run the Unit Tests](#unit_tests)
+ [Continuous Integration](#ci)
+ [License](#license)

## Using the library <a name = "using"></a>

### Installing and using the library <a name = "install_use"></a>

First, you need to install the library either using pip or conda:

```shell
$ pip install yaml_config_wrapper
# or
$ conda install yaml_config_wrapper
```

Then, import it and use it like so:

```python
from yaml_config_wrapper import Configuration

# The `config_schema_path` argument is optional
conf = Configuration(config_src='confs/template_conf.yml',
                     config_schema_path='yml_schemas/default_schema.json')
```

### Creating a config file <a name = "configuration"></a>

There are two already example yml configs under [confs](confs). An example structure is the following:

```yaml
tag: production
cloudstore:
  config:
    api_key: !ENV ${DROPBOX_API_KEY}
  type: dropbox
datastore:
  config:
    hostname: !ENV ${MYSQL_HOST}
    username: !ENV ${MYSQL_USERNAME}
    password: !ENV ${MYSQL_PASSWORD}
    db_name: !ENV ${MYSQL_DB_NAME}
    port: 3306
  type: mysql
email_app:
  config:
    email_address: !ENV ${EMAIL_ADDRESS}
    api_key: !ENV ${GMAIL_API_KEY}
  type: gmail
```

The `!ENV` flag indicates that you are passing an environmental value to this attribute. You can change
the values/environmental var names as you wish.

There is also the option to create a validation schema the enforces a specific yaml structure. The
default dummy version is the [default_schema.json](yaml_config_wrapper/default_schema.json) file.

### Set the required environment variables <a name = "env_variables"></a>

In order to use the `!ENV` flag in you config, you need to set the corresponding environment variables
like so:

```shell
$ export DROPBOX_API_KEY=123
$ export MYSQL_HOST=foo.rds.amazonaws.com
$ export MYSQL_USERNAME=user
$ export MYSQL_PASSWORD=pass
$ export MYSQL_DB_NAME=Test_schema
$ export EMAIL_ADDRESS=Gmail Bot <foobar@gmail.com>
$ export GMAIL_API_KEY=123
```

The best way to do that, is to create a .env file ([example](env_example)), and source it before
running the code.

## Manually install the library <a name = "manual_install"></a>

These instructions will get you a copy of the project up and running on your local machine for
development and testing purposes. See deployment for notes on how to deploy the project on a live
system.

### Prerequisites <a name = "prerequisites"></a>

You need to have a machine with
[anaconda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) installed and
any Bash based shell (e.g. zsh) installed.

```ShellSession

$ conda -V
conda 4.10.1

$ echo $SHELL
/usr/bin/zsh

```

### Install the requirements <a name = "installing_req"></a>

All the installation steps are being handled by the [Makefile](Makefile). First, create a file
called `~/.pypirc` with your pypi login details, as follows:

```
[pypi]
username = your_pypi_username
password = your_pypi_password
```

Then, modify the python version and everything else you need in the [settings.ini](settings.ini).

Finally, execute the following commands:

```ShellSession
$ make create_env
$ conda activate yaml_config_wrapper
$ make release
```

### Run the Unit Tests <a name = "unit_tests"></a>

If you want to run the unit tests, execute the following command:

```ShellSession
$ make tests
```

## Continuous Integration <a name = "ci"></a>

For the continuous integration, the <b>CircleCI</b> service is being used. For more information you can
check the [setup guide](https://circleci.com/docs/2.0/language-python/).

Again, you should set
the [above-mentioned environmental variables](#env_variables) ([reference](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-context))
and for any modifications, edit the [circleci config](/.circleci/config.yml).

## License <a name = "license"></a>

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

