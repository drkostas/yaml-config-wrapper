.ONESHELL:
SHELL:=/bin/bash
PYTHON_VERSION:=3.8

# You can use either venv (venv) or conda env
# by specifying the correct argument (env=<conda, venv>)
ifeq ($(env),venv)
	# Use Conda
	BASE=venv
	BIN=$(BASE)/bin
	CREATE_COMMAND="python$(PYTHON_VERSION) -m venv $(BASE)"
	DELETE_COMMAND="rm -rf $(BASE)"
	ACTIVATE_COMMAND="source venv/bin/activate"
	DEACTIVATE_COMMAND="deactivate"
else
	# Use Conda
	BASE=~/anaconda3/envs/yaml_config_wrapper
	BIN=$(BASE)/bin
	CREATE_COMMAND="conda create --prefix $(BASE) python=$(PYTHON_VERSION) -y"
	DELETE_COMMAND="conda env remove -p $(BASE)"
	ACTIVATE_COMMAND="conda activate -p $(BASE)"
	DEACTIVATE_COMMAND="conda deactivate"
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
	@echo "make create_env [env=<conda|venv>]"
	@echo "       Create a new conda env or venv for the specified python version"
	@echo "make delete_env [env=<conda|venv>]"
	@echo "       Delete the current conda env or venv"
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
	@eval $(CREATE_COMMAND)
delete_env:
	@eval $(DELETE_COMMAND)

.PHONY: all help release conda_release pypi clean dist tests create_env delete_env