dls_vivado
===========================

|code_ci| |docs_ci| |coverage| |pypi_version| |license|

A test project to try out vivado container and github CI

============== ==============================================================
PyPI           ``pip install dls_vivado``
Source code    https://github.com/dls-controls/dls_vivado
Documentation  https://dls-controls.github.io/dls_vivado
============== ==============================================================


.. code:: python

    from dls_vivado import HelloClass

    hello = HelloClass("me")
    print(hello.format_greeting())

Or if it is a commandline tool then you might put some example commands here::

    dls_vivado person --times=2


.. |code_ci| image:: https://github.com/dls-controls/dls_vivado/workflows/Code%20CI/badge.svg?branch=master
    :target: https://github.com/dls-controls/dls_vivado/actions?query=workflow%3A%22Code+CI%22
    :alt: Code CI

.. |docs_ci| image:: https://github.com/dls-controls/dls_vivado/workflows/Docs%20CI/badge.svg?branch=master
    :target: https://github.com/dls-controls/dls_vivado/actions?query=workflow%3A%22Docs+CI%22
    :alt: Docs CI

.. |coverage| image:: https://codecov.io/gh/dls-controls/dls_vivado/branch/master/graph/badge.svg
    :target: https://codecov.io/gh/dls-controls/dls_vivado
    :alt: Test Coverage

.. |pypi_version| image:: https://img.shields.io/pypi/v/dls_vivado.svg
    :target: https://pypi.org/project/dls_vivado
    :alt: Latest PyPI version

.. |license| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
    :target: https://opensource.org/licenses/Apache-2.0
    :alt: Apache License

..
    Anything below this line is used when viewing README.rst and will be replaced
    when included in index.rst

See https://dls-controls.github.io/dls_vivado for more detailed documentation.
