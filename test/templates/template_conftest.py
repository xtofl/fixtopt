"""template file for testing the mop pytest options as fixture"""

from pathlib import Path
from fixtopt import Option
from fixtopt import ConfigOption
from fixtopt import register_with_config_fallback, register

SCRIPTDIR = Path(__file__).absolute().parent


def pytest_addoption(parser):
    """declare options to be used when invoking pytest"""

    config = ConfigOption(
        "config",
        "default.conf",
        "the configuration file",
        searchpath=SCRIPTDIR
    )

    options = (
        Option(name="x", default="defaultx", help="option x"),
        Option(name="y", default="defaulty", help="option y"),
        Option(name="option1", default="default1", help="option 1"),
    )

    register_with_config_fallback(globals(), parser, config, options)

    register(globals(), parser, (
        Option(name="message", default="Hello {}", help="the message"),
        Option(name="receiver", default="World", help="the receiver"),
    ))
