PATH := build/python/bin:$(PATH)
VERSION = $(shell python setup.py --version)
ALLFILES = $(shell echo bottle.py test/*.py test/views/*.tpl)
VENV = build/venv

.PHONY: release coverage install docs test test_all test_25 test_26 test_27 test_31 test_32 test_33 2to3 clean

release: venv
	$(VENV)/bin/python3 setup.py --version | egrep -q -v '[a-zA-Z]' # Fail on dev/rc versions
	git commit -e -m "Release of $(VERSION)"            # Fail on nothing to commit
	git tag -a -m "Release of $(VERSION)" $(VERSION)    # Fail on existing tags
	git push origin HEAD                                # Fail on out-of-sync upstream
	git push origin tag $(VERSION)                      # Fail on dublicate tag
	$(VENV)/bin/python3 setup.py sdist bdist_wheel      # Build project
	$(VENV)/bin/twine upload                            # Release to pypi

venv: $(VENV)/.installed
$(VENV)/.installed: Makefile
	python3 -mvenv $(VENV)
	$(VENV)/bin/python3 -mensurepip
	$(VENV)/bin/pip install -U pip
	$(VENV)/bin/pip install -U setuptools wheel twine coverage
	touch $(VENV)/.installed

coverage:
	-mkdir build/
	coverage erase
	COVERAGE_PROCESS_START=.coveragerc test/testall.py
	coverage combine
	coverage report
	coverage html

push: test_all
	git push origin HEAD

install:
	python setup.py install

docs:
	sphinx-build -b html -d build/docs/doctrees docs build/docs/html

test:
	python test/testall.py

test_all: test_25 test_26 test_27 test_31 test_32 test_33 test_34

test_25:
	python2.5 test/testall.py

test_26:
	python2.6 test/testall.py

test_27:
	python2.7 test/testall.py

test_31:
	python3.1 test/testall.py

test_32:
	python3.2 test/testall.py

test_33:
	python3.3 test/testall.py

test_34:
	python3.4 test/testall.py

clean:
	rm -rf build/ dist/ MANIFEST 2>/dev/null || true
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '._*' -exec rm -f {} +
	find . -name '.coverage*' -exec rm -f {} +
