.ONESHELL:
SHELL:=/bin/bash
PYTHON_VERSION:=3.8
# You can use either venv (virtualenv) or conda env
# by specifying the correct argument (env=<conda, venv>)
ifeq ($(env),virtualenv)
	# Use Conda
	BASE=~/anaconda3/envs/starter
	BIN=$(BASE)/bin
	CLEAN_COMMAND="conda env remove -p $(BASE)"
	CREATE_COMMAND="conda create --prefix $(BASE) python=$(PYTHON_VERSION) -y"
	SETUP_FLAG=
	DEBUG=False
else
	# Use Conda
	BASE=~/anaconda3/envs/starter
	BIN=$(BASE)/bin
	CLEAN_COMMAND="conda env remove -p $(BASE)"
	CREATE_COMMAND="conda create --prefix $(BASE) python=$(PYTHON_VERSION) -y"
	DEBUG=True
endif

all:
	$(MAKE) help
help:
	@echo
	@echo "-----------------------------------------------------------------------------------------------------------"
	@echo "                                              DISPLAYING HELP                                              "
	@echo "-----------------------------------------------------------------------------------------------------------"
	@echo "Run: make <make recipe> [env=<conda|venv>]"
	@echo
	@echo "make help"
	@echo "       Display this message"
	@echo "make release [env=<conda|venv>]"
	@echo "       Run pypi conda_release fastrelease_bump_version"
	@echo "make pypi [env=<conda|venv>]"
	@echo "       Run dist and upload using twine"
	@echo "make dist [env=<conda|venv>]"
	@echo "       Clean and create bdist and wheel"
	@echo "make clean [env=<conda|venv>]"
	@echo "       Delete all './build ./dist ./*.pyc ./*.tgz ./*.egg-info' files"
	@echo "make tests [env=<conda|venv>]"
	@echo "       Run all tests"
	@echo "make create_env [server=<prod|circleci|local>]"
	@echo "       Create a new conda env or virtualenv for the specified python version"
	@echo "make delete_env [server=<prod|circleci|local>]"
	@echo "       Delete the current conda env or virtualenv"
	@echo "-----------------------------------------------------------------------------------------------------------"

release:
	$(MAKE) pypi
	#$(MAKE) conda_release
	#fastrelease_bump_version
pypi:
	$(MAKE) dist
	twine upload --repository pypitest dist/*
conda_release:
	fastrelease_conda_package --upload_user drkostas
dist:
	$(MAKE) clean
	python setup.py sdist bdist_wheel
clean:
	python setup.py clean
tests:
	python setup.py test
create_env:
	@echo "Creating virtual environment.."
	eval $(CREATE_COMMAND)
delete_env:
	@echo "Deleting virtual environment.."
	eval $(DELETE_COMMAND)

.PHONY: all help release conda_release pypi clean dist tests create_env delete_env